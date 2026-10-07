import '../../core/enums/estado_cuota.dart';
import '../../core/enums/estado_deuda.dart';
import '../../core/enums/tipo_pago.dart';
import '../../models/cuota_deuda.dart';
import '../../models/deuda.dart';
import '../../models/interes_deuda.dart';
import '../../models/pago.dart';
import '../../repositories/cuota_deuda_repository.dart';
import '../../repositories/deuda_repository.dart';
import '../../repositories/interes_deuda_repository.dart';
import '../../repositories/pago_repository.dart';
import '../configuracion/configuracion_service.dart';
import '../notifications/deuda_notification_service.dart';
import 'deuda_exception.dart';
import 'deuda_filter.dart';
import 'deuda_summary.dart';
import 'deuda_validator.dart';

class DeudaService {
  DeudaService({
    required this._repository,
    required this._validator,
    required this._pagoRepository,
    required this._interesRepository,
    required this._cuotaRepository,
    required this._configuracionService,
  });

  final DeudaRepository _repository;
  final DeudaValidator _validator;
  final PagoRepository _pagoRepository;
  final InteresDeudaRepository _interesRepository;
  final CuotaDeudaRepository _cuotaRepository;
  final ConfiguracionService _configuracionService;
  final DeudaNotificationService _deudaNotificationService =
      DeudaNotificationService.instance;

  //==========================================================
  // CRUD
  //==========================================================

  Future<Deuda> crear(Deuda deuda) async {
    await _validator.validar(deuda);

    if (deuda.programada) {
      if (deuda.mesesProgramados <= 0) {
        throw const DeudaException(
          'Una deuda programada debe tener una duración mayor a 0 meses.',
        );
      }
      deuda.fechaVencimiento = _calcularFechaVencimientoProgramada(deuda);
    }
    // Asignar el número visible de la deuda nueva.
    deuda.numeroDeuda = await _configuracionService.reservarNumeroDeuda();

    deuda.observacion = deuda.observacion?.trim();
    deuda.fechaActualizacion = DateTime.now();
    // Para una deuda nueva todavía no existen pagos.
    deuda.totalPagado = 0;
    deuda.interesCalculado = 0;
    deuda.total = 0;
    deuda.saldoPendiente = 0;
    // Primero guardamos la deuda para que Isar le asigne su ID.
    await _repository.guardar(deuda);
    await recalcular(deuda);
    await _sincronizarNotificaciones(deuda);
    return deuda;
  }

  Future<Deuda> editar(Deuda deuda) async {
    final actual = await _repository.obtenerPorId(deuda.id);

    if (actual == null) {
      throw const DeudaException('La deuda no existe.');
    }

    await _validator.validar(deuda);
    // ---------------------------------------------------------
    // 3. Obtener los pagos existentes.
    //
    //    Esto nos permitirá determinar si podemos reconstruir
    //    libremente la estructura de la deuda o si debemos
    //    conservar cuidadosamente cuotas e intereses.
    // ---------------------------------------------------------

    final pagos = await _pagoRepository.obtenerPorDeuda(deuda.id);

    final pagosActivos = pagos.where((pago) => !pago.eliminado).toList();

    final tienePagos = pagosActivos.isNotEmpty;

    // ---------------------------------------------------------
    // 4. Detectar cambios estructurales.
    // ---------------------------------------------------------

    final cambioCapital = deuda.capital != actual.capital;

    final cambioPorcentajeInteres =
        deuda.porcentajeInteres != actual.porcentajeInteres;

    final cambioFechaPrestamo = deuda.fechaPrestamo != actual.fechaPrestamo;
    final cambioTieneCuotas = deuda.tieneCuotas != actual.tieneCuotas;
    final cambioNumeroCuotas = deuda.numeroCuotas != actual.numeroCuotas;

    final cambioProgramada = deuda.programada != actual.programada;

    final cambioMesesProgramados =
        deuda.mesesProgramados != actual.mesesProgramados;

    final cambioEstructural =
        cambioCapital ||
        cambioPorcentajeInteres ||
        cambioFechaPrestamo ||
        cambioTieneCuotas ||
        cambioNumeroCuotas ||
        cambioProgramada ||
        cambioMesesProgramados;

    deuda.observacion = deuda.observacion?.trim();
    deuda.fechaRegistro = actual.fechaRegistro;
    deuda.fechaActualizacion = DateTime.now();

    if (deuda.programada) {
      if (deuda.mesesProgramados <= 0) {
        throw const DeudaException(
          'Una deuda programada debe tener una duración mayor a 0 meses.',
        );
      }

      deuda.fechaVencimiento = _calcularFechaVencimientoProgramada(deuda);
    }

    if (!tienePagos && cambioEstructural) {
      // -------------------------------------------------------
      // Las funciones auxiliares que agregaremos después se
      // encargarán de eliminar/reconstruir correctamente:
      //
      //   - cuotas
      //   - períodos de interés
      // -------------------------------------------------------
      await _reconstruirEstructuraSinPagos(deuda);
      // Recalcular los valores derivados utilizando la nueva
      // estructura de la deuda.
      await recalcular(deuda);
      // Actualizar el estado final.
      await actualizarEstado(deuda);
      await _sincronizarNotificaciones(deuda);
      return deuda;
    }
    if (tienePagos) {
      await _manejarCambiosConPagos(
        actual: actual,
        nueva: deuda,
        cambioCapital: cambioCapital,
        cambioPorcentajeInteres: cambioPorcentajeInteres,
        cambioFechaPrestamo: cambioFechaPrestamo,
        cambioTieneCuotas: cambioTieneCuotas,
        cambioNumeroCuotas: cambioNumeroCuotas,
        cambioProgramada: cambioProgramada,
        cambioMesesProgramados: cambioMesesProgramados,
      );
    }

    await _repository.guardar(deuda);
    await recalcular(deuda);
    await actualizarEstado(deuda);
    await _sincronizarNotificaciones(deuda);
    return deuda;
  }

  Future<void> eliminar(int id) async {
    final deuda = await _repository.obtenerPorId(id);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    if (deuda.saldoPendiente > 0) {
      throw const DeudaException(
        'Solo se puede eliminar una deuda completamente pagada.',
      );
    }
    await _cancelarNotificaciones(id);
    await _repository.eliminarConRelaciones(id);
  }

  Future<void> cancelar(int id) async {
    final deuda = await _repository.obtenerPorId(id);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    if (deuda.saldoPendiente <= 0) {
      throw const DeudaException(
        'La deuda ya está completamente pagada. '
        'Utilice la opción de eliminar.',
      );
    }
    await _cancelarNotificaciones(id);
    await _repository.eliminarConRelaciones(id);
  }

  Future<void> archivar(int id) async {
    final deuda = await _repository.obtenerPorId(id);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    if (deuda.archivada) {
      throw const DeudaException('La deuda ya está archivada.');
    }

    // if (!puedeArchivarse(deuda)) {
    //   throw const DeudaException(
    //     'Solo se pueden archivar deudas completamente pagadas.',
    //   );
    // }

    deuda.archivada = true;
    deuda.fechaActualizacion = DateTime.now();
    await _repository.guardar(deuda);
    await _cancelarNotificaciones(id);
  }

  Future<void> desarchivar(int id) async {
    final deuda = await _repository.obtenerPorId(id);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }
    if (!deuda.archivada) {
      throw const DeudaException('La deuda no está archivada.');
    }

    deuda.archivada = false;
    deuda.fechaActualizacion = DateTime.now();

    await _repository.guardar(deuda);
    await recalcular(deuda);
    await _sincronizarNotificaciones(deuda);
  }

  //==========================================================
  // CONSULTAS
  //==========================================================
  Future<List<Deuda>> obtenerTodas() {
    return _repository.obtenerTodas();
  }

  Future<List<Deuda>> obtenerActivas() {
    return _repository.obtenerActivas();
  }

  Future<List<Deuda>> obtenerArchivadas() {
    return _repository.obtenerArchivadas();
  }

  Future<List<Deuda>> obtenerPendientes() {
    return _repository.obtenerPendientes();
  }

  Future<List<Deuda>> obtenerPagadas() {
    return _repository.obtenerPagadas();
  }

  Future<List<Deuda>> obtenerVencidas() {
    return _repository.obtenerVencidas();
  }

  Future<List<Deuda>> obtenerPorCliente(int clienteId) {
    return _repository.obtenerPorCliente(clienteId);
  }

  Future<Deuda?> obtenerPorId(int id) {
    return _repository.obtenerPorId(id);
  }

  Future<Deuda?> obtenerPorUuid(String uuid) {
    return _repository.obtenerPorUuid(uuid);
  }

  //==========================================================
  // BÚSQUEDA
  //==========================================================

  Future<List<Deuda>> buscar(String texto) {
    return _repository.buscar(texto.trim());
  }

  //==========================================================
  // FILTROS
  //==========================================================

  Future<List<Deuda>> filtrar(DeudaFilter filter) {
    if (!filter.tieneFiltros) {
      return _repository.obtenerTodas();
    }

    return _repository.filtrar(
      clienteId: filter.clienteId,
      estado: filter.estado,
      archivada: filter.archivada,
      desde: filter.desde,
      hasta: filter.hasta,
    );
  }

  //==========================================================
  // VALIDACIONES
  //==========================================================

  Future<void> validar(Deuda deuda) {
    return _validator.validar(deuda);
  }

  //==========================================================
  // UTILIDADES
  //==========================================================

  Future<bool> existe(String uuid) async {
    return await _repository.obtenerPorUuid(uuid) != null;
  }

  Future<bool> tienePagos(int deudaId) async {
    final pagos = await _pagoRepository.obtenerPorDeuda(deudaId);

    // if (deuda == null) {
    //   return false;
    // }

    // await deuda.pagos.load();

    // return deuda.pagos.isNotEmpty;
    return pagos.isNotEmpty;
  }

  Future<bool> tienePagosActivos(int deudaId) async {
    final pagos = await _pagoRepository.obtenerPorDeuda(deudaId);

    return pagos.any((pago) => !pago.eliminado);
  }

  Future<bool> puedeEliminar(int deudaId) async {
    return !(await tienePagos(deudaId));
  }

  //==========================================================
  // RECÁLCULOS
  //==========================================================

  Future<void> recalcular(Deuda deuda) async {
    // ---------------------------------------------------------
    // 1. Obtener todos los pagos de la deuda.
    // ---------------------------------------------------------
    final pagos = await _pagoRepository.obtenerPorDeuda(deuda.id);

    final pagosActivos = pagos.where((pago) => !pago.eliminado).toList();

    // ---------------------------------------------------------
    // 2. Generar los períodos de interés que correspondan.
    //
    //    Esta función NO modifica:
    //      - deuda.capital
    //      - deuda.porcentajeInteres
    //
    //    Solamente crea los registros InteresDeuda que hagan
    //    falta.
    // ---------------------------------------------------------
    await _generarIntereses(deuda);

    // ---------------------------------------------------------
    // 3. Obtener nuevamente los intereses.
    //
    //    Se vuelve a consultar porque _generarIntereses()
    //    puede haber creado nuevos períodos.
    // ---------------------------------------------------------
    final intereses = await _interesRepository.obtenerPorDeuda(deuda.id);

    // ---------------------------------------------------------
    // 4. Distribuir los pagos de interés entre los períodos.
    //
    //    Un mismo período puede tener varios pagos.
    //
    //    Ejemplo:
    //
    //      Interés período 1 = 40.000
    //
    //      Pago 1 = 10.000
    //      Pago 2 = 15.000
    //
    //      valorPagado = 25.000
    //      pendiente   = 15.000
    //
    //    También puede quedar completamente pagado.
    // ---------------------------------------------------------
    if (!(deuda.programada && deuda.tieneCuotas)) {
      await _actualizarIntereses(intereses, pagosActivos);
    }

    // ---------------------------------------------------------
    // 5. Calcular el capital pagado.
    //
    //    Los pagos de interés NO reducen el capital.
    // ---------------------------------------------------------
    final interesCalculado = intereses.fold<double>(
      0,
      (total, interes) => total + interes.valor,
    );
    final interesesPagados = intereses.fold<double>(
      0,
      (total, interes) => total + interes.valorPagado,
    );
    deuda.interesCalculado = interesCalculado;
    deuda.total = deuda.capital + interesCalculado;
    deuda.totalPagado = pagosActivos.fold<double>(
      0,
      (total, pago) => total + pago.valor,
    );
    if (deuda.tieneCuotas) {
      await _generarCuotas(deuda);
      await _actualizarCuotas(deuda, pagosActivos);
    }
    if (deuda.programada && deuda.tieneCuotas) {
      deuda.saldoPendiente = deuda.total - deuda.totalPagado;
    } else {
      final capitalPagado = pagosActivos
          .where((pago) => pago.tipoPago == TipoPago.capital)
          .fold<double>(0, (total, pago) => total + pago.valor);

      double capitalPendiente = deuda.capital - capitalPagado;

      if (capitalPendiente < 0) {
        capitalPendiente = 0;
      }

      double interesPendiente = interesCalculado - interesesPagados;

      if (interesPendiente < 0) {
        interesPendiente = 0;
      }

      deuda.saldoPendiente = capitalPendiente + interesPendiente;
    }
    // ---------------------------------------------------------
    // 11. Protección contra valores negativos.
    // ---------------------------------------------------------
    if (deuda.totalPagado < 0) {
      deuda.totalPagado = 0;
    }

    if (deuda.saldoPendiente < 0) {
      deuda.saldoPendiente = 0;
    }

    // ---------------------------------------------------------
    // 12. Determinar estado.
    // ---------------------------------------------------------
    deuda.estado = determinarEstado(deuda);

    deuda.fechaActualizacion = DateTime.now();

    // ---------------------------------------------------------
    // 13. Persistir la deuda.
    // ---------------------------------------------------------
    await _repository.guardar(deuda);
  }

  Future<void> _generarIntereses(Deuda deuda) async {
    final interesesExistentes = await _interesRepository.obtenerPorDeuda(
      deuda.id,
    );

    // ---------------------------------------------------------
    // Determinar desde qué fecha debemos comenzar a generar
    // períodos.
    // Si no existe ningún interés:
    //   El primer período comienza inmediatamente en la fecha
    //   del préstamo.
    // Si ya existen períodos:
    //   Continuamos desde la fecha final del último período.
    // ---------------------------------------------------------
    DateTime fechaInicio;
    int siguientePeriodo = 1;
    if (interesesExistentes.isNotEmpty) {
      siguientePeriodo =
          interesesExistentes
              .map((interes) => interes.numeroPeriodo)
              .reduce((a, b) => a > b ? a : b) +
          1;
    }

    if (interesesExistentes.isEmpty) {
      fechaInicio = deuda.fechaPrestamo;
    } else {
      final ultimo = interesesExistentes.reduce(
        (a, b) => a.numeroPeriodo > b.numeroPeriodo ? a : b,
      );

      fechaInicio = ultimo.fechaFin;
    }

    final nuevosIntereses = <InteresDeuda>[];
    if (deuda.programada) {
      final cantidadPeriodos = deuda.mesesProgramados;

      while (siguientePeriodo <= cantidadPeriodos) {
        final fechaFin = _sumarPeriodoComercial(fechaInicio);

        final interes = InteresDeuda()
          ..deuda.value = deuda
          ..numeroPeriodo = siguientePeriodo
          ..fechaInicio = fechaInicio
          ..fechaFin = fechaFin
          ..porcentaje = deuda.porcentajeInteres
          ..valor = _calcularInteresPeriodo(deuda)
          ..valorPagado = 0
          ..pagado = false
          ..fechaRegistro = DateTime.now();

        nuevosIntereses.add(interes);

        fechaInicio = fechaFin;
        siguientePeriodo++;
      }

      if (nuevosIntereses.isNotEmpty) {
        await _interesRepository.guardarTodos(nuevosIntereses);
      }

      return;
    }

    final ahora = DateTime.now();
    // ---------------------------------------------------------
    // PERÍODOS POSTERIORES
    //
    // A partir del primer período, solamente generamos los
    // períodos cuyo plazo mensual ya haya llegado.
    //
    // Ejemplo:
    //
    // préstamo: 10/09/2026
    //
    // período 1:
    // 10/09 -> 10/10
    //
    // período 2 solamente se genera cuando:
    // fecha actual >= 10/10
    //
    // período 3 solamente se genera cuando:
    // fecha actual >= 10/11
    //
    // etc.
    // ---------------------------------------------------------
    while (true) {
      final fechaFin = _sumarUnMes(fechaInicio);

      // Todavía no se ha completado el período.
      if (fechaFin.isAfter(ahora)) {
        break;
      }

      final interes = InteresDeuda()
        ..deuda.value = deuda
        ..numeroPeriodo = siguientePeriodo
        ..fechaInicio = fechaInicio
        ..fechaFin = fechaFin
        ..porcentaje = deuda.porcentajeInteres
        ..valor = _calcularInteresPeriodo(deuda)
        ..valorPagado = 0
        ..pagado = false
        ..fechaRegistro = DateTime.now();

      nuevosIntereses.add(interes);

      fechaInicio = fechaFin;
      siguientePeriodo++;
    }

    // ---------------------------------------------------------
    // Guardar todos los períodos nuevos.
    // ---------------------------------------------------------
    if (nuevosIntereses.isNotEmpty) {
      await _interesRepository.guardarTodos(nuevosIntereses);
    }
  }

  Future<void> _actualizarIntereses(
    List<InteresDeuda> intereses,
    List<Pago> pagos,
  ) async {
    if (intereses.isEmpty) {
      return;
    }

    // ---------------------------------------------------------
    // Solamente consideramos pagos explícitamente marcados
    // como intereses.
    // ---------------------------------------------------------
    final pagosInteres = pagos
        .where((pago) => pago.tipoPago == TipoPago.interes)
        .toList();

    if (pagosInteres.isEmpty) {
      // Aunque no haya pagos de interés, debemos asegurarnos
      // de que los períodos estén correctamente marcados.
      for (final interes in intereses) {
        interes.valorPagado = 0;
        interes.pagado = false;
        interes.fechaPago = null;
        interes.fechaActualizacion = DateTime.now();
      }

      await _interesRepository.guardarTodos(intereses);
      return;
    }

    // ---------------------------------------------------------
    // Reiniciamos los valores antes de volver a distribuir
    // los pagos.
    //
    // Esto es importante cuando:
    //
    // - se edita un pago,
    // - se elimina un pago,
    // - se restaura un pago,
    // - se cambia un pago de deuda.
    //
    // De esta manera recalcular() siempre reconstruye el estado
    // real a partir de los pagos existentes.
    // ---------------------------------------------------------
    for (final interes in intereses) {
      interes.valorPagado = 0;
      interes.pagado = false;
      interes.fechaPago = null;
    }

    // ---------------------------------------------------------
    // Ordenamos los pagos por fecha.
    //
    // Los pagos de interés se aplican primero al período más
    // antiguo que todavía tenga saldo.
    // ---------------------------------------------------------
    pagosInteres.sort((a, b) => a.fechaPago.compareTo(b.fechaPago));

    // ---------------------------------------------------------
    // Distribución de los pagos.
    //
    // Ejemplo:
    //
    // Interés 1 = 40.000
    // Interés 2 = 40.000
    //
    // Pago = 20.000
    //
    // Resultado:
    //
    // Interés 1:
    //   pagado = 20.000
    //   pendiente = 20.000
    //
    // Interés 2:
    //   pagado = 0
    //
    // Si después existe otro pago de 30.000:
    //
    // Interés 1:
    //   pagado = 40.000
    //
    // Interés 2:
    //   pagado = 10.000
    // ---------------------------------------------------------
    for (final pago in pagosInteres) {
      double disponible = pago.valor;

      if (disponible <= 0) {
        continue;
      }

      for (final interes in intereses) {
        final pendiente = interes.valor - interes.valorPagado;

        if (pendiente <= 0) {
          continue;
        }

        final aplicado = disponible < pendiente ? disponible : pendiente;

        interes.valorPagado += aplicado;

        disponible -= aplicado;

        if (disponible <= 0) {
          break;
        }
      }
    }

    // ---------------------------------------------------------
    // Determinar estado de cada período.
    // ---------------------------------------------------------
    for (final interes in intereses) {
      if (interes.valorPagado >= interes.valor) {
        interes.valorPagado = interes.valor;
        interes.pagado = true;
        interes.fechaPago = _obtenerFechaUltimoPagoInteres(
          interes,
          pagosInteres,
        );
      } else {
        interes.pagado = false;
        interes.fechaPago = null;
      }

      interes.fechaActualizacion = DateTime.now();
    }

    await _interesRepository.guardarTodos(intereses);
  }

  //==========================================================
  // CALCULAR INTERÉS DE UN PERÍODO
  //==========================================================

  double _calcularInteresPeriodo(Deuda deuda) {
    return deuda.capital * (deuda.porcentajeInteres / 100);
  }

  //==========================================================
  // OBTENER FECHA DEL ÚLTIMO PAGO DE UN INTERÉS
  //==========================================================

  DateTime? _obtenerFechaUltimoPagoInteres(
    InteresDeuda interes,
    List<Pago> pagosInteres,
  ) {
    // En este punto solamente conocemos cuánto dinero se ha
    // distribuido al período, no exactamente qué pago terminó
    // de cubrirlo.
    //
    // Por eso buscamos el último pago de interés cuya fecha
    // pueda corresponder al período.
    //
    // Esta función podrá refinarse cuando conectemos
    // explícitamente Pago.interes con InteresDeuda.pago.
    if (pagosInteres.isEmpty) {
      return null;
    }

    DateTime? fecha;

    for (final pago in pagosInteres) {
      if (pago.fechaPago.isBefore(interes.fechaInicio)) {
        continue;
      }

      if (pago.fechaPago.isAfter(interes.fechaFin)) {
        continue;
      }

      if (fecha == null || pago.fechaPago.isAfter(fecha)) {
        fecha = pago.fechaPago;
      }
    }

    return fecha;
  }

  //==========================================================
  // SUMAR UN MES
  //==========================================================

  DateTime _sumarUnMes(DateTime fecha) {
    final siguienteMes = fecha.month == 12 ? 1 : fecha.month + 1;

    final siguienteAnio = fecha.month == 12 ? fecha.year + 1 : fecha.year;

    final ultimoDiaMes = DateTime(siguienteAnio, siguienteMes + 1, 0).day;

    final dia = fecha.day > ultimoDiaMes ? ultimoDiaMes : fecha.day;

    return DateTime(
      siguienteAnio,
      siguienteMes,
      dia,
      fecha.hour,
      fecha.minute,
      fecha.second,
      fecha.millisecond,
      fecha.microsecond,
    );
  }

  Future<void> _generarCuotas(Deuda deuda) async {
    if (!deuda.tieneCuotas || deuda.numeroCuotas <= 0) {
      return;
    }

    final cuotasExistentes = await _cuotaRepository.obtenerPorDeuda(deuda.id);

    if (cuotasExistentes.isNotEmpty) {
      return;
    }

    final cantidad = deuda.numeroCuotas;

    final intereses = deuda.programada
        ? (await _interesRepository.obtenerPorDeuda(deuda.id))
        : <InteresDeuda>[];

    final interesTotal = intereses.fold<double>(
      0,
      (total, interes) => total + interes.valor,
    );

    final totalParaCuotas = deuda.programada
        ? deuda.capital + interesTotal
        : deuda.capital;

    if (totalParaCuotas <= 0) {
      return;
    }

    final valorBase = totalParaCuotas / cantidad;
    final valorRedondeado = (valorBase / 50).round() * 50.0;
    final cuotas = <CuotaDeuda>[];

    double acumulado = 0;

    for (int i = 1; i <= cantidad; i++) {
      double valor;

      if (i == cantidad) {
        valor = double.parse((totalParaCuotas - acumulado).toStringAsFixed(2));
      } else {
        valor = valorRedondeado;
        acumulado += valor;
      }

      final cuota = CuotaDeuda()
        ..deuda.value = deuda
        ..numeroCuota = i
        ..valor = valor
        ..valorPagado = 0
        ..estado = EstadoCuota.pendiente
        ..fechaPago = null
        ..fechaRegistro = DateTime.now()
        ..fechaActualizacion = null;

      cuotas.add(cuota);
    }

    await _cuotaRepository.guardarTodas(cuotas);
  }

  Future<void> _actualizarCuotas(Deuda deuda, List<Pago> pagosActivos) async {
    if (!deuda.tieneCuotas || deuda.numeroCuotas <= 0) {
      return;
    }

    final cuotas = await _cuotaRepository.obtenerPorDeuda(deuda.id);

    if (cuotas.isEmpty) {
      return;
    }

    cuotas.sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

    for (final cuota in cuotas) {
      cuota.valorPagado = 0;
      cuota.estado = EstadoCuota.pendiente;
      cuota.fechaPago = null;
      cuota.fechaActualizacion = DateTime.now();
    }
    final pagosAplicables = deuda.programada
        ? pagosActivos
        : pagosActivos
              .where((pago) => pago.tipoPago == TipoPago.capital)
              .toList();

    for (final pago in pagosAplicables) {
      await pago.cuotas.load();

      final cuotasDelPago = pago.cuotas.toList()
        ..sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

      double restante = pago.valor;

      for (final cuotaRelacionada in cuotasDelPago) {
        if (restante <= 0) {
          break;
        }

        final indice = cuotas.indexWhere(
          (cuota) => cuota.id == cuotaRelacionada.id,
        );

        if (indice == -1) {
          continue;
        }

        final cuota = cuotas[indice];

        final saldoCuota = cuota.valor - cuota.valorPagado;

        if (saldoCuota <= 0) {
          continue;
        }

        final importeAplicado = restante > saldoCuota ? saldoCuota : restante;

        cuota.valorPagado += importeAplicado;
        restante -= importeAplicado;
      }
    }

    for (final cuota in cuotas) {
      if (cuota.valorPagado >= cuota.valor) {
        // La cuota está completamente pagada.
        cuota.valorPagado = cuota.valor;
        cuota.estado = EstadoCuota.pagada;

        // Buscar el último pago activo que está relacionado
        // con esta cuota.
        final pagosDeCuota = <Pago>[];

        for (final pago in pagosAplicables) {
          await pago.cuotas.load();

          final pertenece = pago.cuotas.any(
            (cuotaPago) => cuotaPago.id == cuota.id,
          );

          if (pertenece) {
            pagosDeCuota.add(pago);
          }
        }

        if (pagosDeCuota.isNotEmpty) {
          cuota.fechaPago = pagosDeCuota
              .map((pago) => pago.fechaPago)
              .reduce((a, b) => a.isAfter(b) ? a : b);
        }
      } else if (cuota.valorPagado > 0) {
        // La cuota está parcialmente pagada.
        cuota.estado = EstadoCuota.parcial;
        cuota.fechaPago = null;
      } else {
        // La cuota todavía no tiene pagos.
        cuota.estado = EstadoCuota.pendiente;
        cuota.fechaPago = null;
      }

      cuota.fechaActualizacion = DateTime.now();
    }

    await _cuotaRepository.guardarTodas(cuotas);
  }

  //==========================================================
  // RECONSTRUCCIÓN DE ESTRUCTURA SIN PAGOS
  //==========================================================

  Future<void> _reconstruirEstructuraSinPagos(Deuda deuda) async {
    // ---------------------------------------------------------
    // 1. Eliminar las cuotas existentes.
    //
    // Como la deuda no tiene pagos activos, podemos eliminar
    // completamente las cuotas anteriores y generarlas nuevamente.
    // ---------------------------------------------------------

    await _cuotaRepository.eliminarPorDeuda(deuda.id);

    // ---------------------------------------------------------
    // 2. Obtener y eliminar los períodos de interés existentes.
    //
    // La fecha del préstamo y el porcentaje pueden haber cambiado,
    // por lo tanto los períodos anteriores ya podrían no representar
    // correctamente la nueva estructura de la deuda.
    // ---------------------------------------------------------

    final interesesExistentes = await _interesRepository.obtenerPorDeuda(
      deuda.id,
    );

    if (interesesExistentes.isNotEmpty) {
      final ids = interesesExistentes.map((interes) => interes.id).toList();

      await _interesRepository.eliminarTodos(ids);
    }

    // ---------------------------------------------------------
    // 3. Calcular fecha de vencimiento si es programada.
    // ---------------------------------------------------------
    if (deuda.programada) {
      if (deuda.mesesProgramados <= 0) {
        throw const DeudaException(
          'Una deuda programada debe tener una duración '
          'mayor a 0 meses.',
        );
      }

      deuda.fechaVencimiento = _calcularFechaVencimientoProgramada(deuda);
    }

    // ---------------------------------------------------------
    // 3. Guardar primero la nueva estructura básica de la deuda.
    //
    // Esto garantiza que las nuevas cuotas e intereses queden
    // asociados a los nuevos valores:
    //
    // - capital
    // - porcentajeInteres
    // - fechaPrestamo
    // - numeroCuotas
    // ---------------------------------------------------------

    await _repository.guardar(deuda);

    // ---------------------------------------------------------
    // 5. Generar nuevamente los períodos de interés.
    //
    // _generarIntereses() utilizará ahora la nueva fecha de préstamo
    // y el nuevo porcentaje de interés.
    // ---------------------------------------------------------

    await _generarIntereses(deuda);

    // ---------------------------------------------------------
    // 4. Generar nuevamente las cuotas.
    // ---------------------------------------------------------

    if (deuda.tieneCuotas && deuda.numeroCuotas > 0) {
      await _generarCuotas(deuda);
    }
  }

  //==========================================================
  // MANEJO DE CAMBIOS CON PAGOS EXISTENTES
  //==========================================================

  Future<void> _manejarCambiosConPagos({
    required Deuda actual,
    required Deuda nueva,
    required bool cambioCapital,
    required bool cambioPorcentajeInteres,
    required bool cambioFechaPrestamo,
    required bool cambioTieneCuotas,
    required bool cambioNumeroCuotas,
    required bool cambioProgramada,
    required bool cambioMesesProgramados,
  }) async {
    // ---------------------------------------------------------
    // Obtener los pagos activos.
    // ---------------------------------------------------------

    final pagos = await _pagoRepository.obtenerPorDeuda(actual.id);

    final pagosActivos = pagos.where((pago) => !pago.eliminado).toList();

    // ---------------------------------------------------------
    // Calcular cuánto capital ya ha sido pagado.
    // ---------------------------------------------------------
    final totalPagado = pagosActivos.fold<double>(
      0,
      (total, pago) => total + pago.valor,
    );
    final capitalPagado = pagosActivos
        .where((pago) => pago.tipoPago == TipoPago.capital)
        .fold<double>(0, (total, pago) => total + pago.valor);

    // ---------------------------------------------------------
    // 1. VALIDAR CAMBIO DE CAPITAL
    //
    // No podemos permitir que el nuevo capital sea menor que
    // el capital que ya fue pagado.
    // ---------------------------------------------------------

    if (cambioCapital) {
      final limitePagado = actual.programada && actual.tieneCuotas
          ? totalPagado
          : capitalPagado;

      if (nueva.capital < limitePagado) {
        throw DeudaException(
          'No es posible establecer un capital de '
          '${nueva.capital.toStringAsFixed(0)}, porque '
          'ya existen pagos por '
          '${limitePagado.toStringAsFixed(0)}.',
        );
      }
    }

    // ---------------------------------------------------------
    // 2. CAMBIO DE CONFIGURACIÓN DE CUOTAS
    //
    // Si existen pagos relacionados, NO eliminamos ni
    // reconstruimos las cuotas automáticamente.
    // ---------------------------------------------------------

    if (cambioTieneCuotas || cambioNumeroCuotas) {
      final cuotasExistentes = await _cuotaRepository.obtenerPorDeuda(
        actual.id,
      );

      if (cuotasExistentes.isNotEmpty) {
        // Conservamos la estructura actual para proteger las
        // relaciones Pago ↔ CuotaDeuda.
        nueva.tieneCuotas = actual.tieneCuotas;
        nueva.numeroCuotas = actual.numeroCuotas;
      }
    }
    // ---------------------------------------------------------
    // CAMBIO DE CONFIGURACIÓN PROGRAMADA
    //
    // Si ya existen pagos, no reconstruimos una deuda
    // programada porque eso modificaría las cuotas y los
    // períodos que ya están relacionados con pagos.
    // ---------------------------------------------------------
    if (cambioProgramada || cambioMesesProgramados) {
      final cuotasExistentes = await _cuotaRepository.obtenerPorDeuda(
        actual.id,
      );

      final interesesExistentes = await _interesRepository.obtenerPorDeuda(
        actual.id,
      );

      final tieneEstructura =
          cuotasExistentes.isNotEmpty || interesesExistentes.isNotEmpty;

      if (tieneEstructura) {
        nueva.programada = actual.programada;
        nueva.mesesProgramados = actual.mesesProgramados;
        nueva.fechaVencimiento = actual.fechaVencimiento;
      }
    }
    // ---------------------------------------------------------
    // 3. CAMBIO DE FECHA DE PRÉSTAMO
    //
    // No eliminamos los períodos de interés existentes.
    //
    // Esto evita romper relaciones con pagos de interés.
    //
    // Los nuevos períodos que hagan falta podrán generarse
    // posteriormente desde la nueva configuración.
    // ---------------------------------------------------------

    if (cambioFechaPrestamo) {
      final interesesExistentes = await _interesRepository.obtenerPorDeuda(
        actual.id,
      );

      final tieneInteresesConPagos = interesesExistentes.any(
        (interes) => interes.valorPagado > 0 || interes.pagado,
      );

      if (tieneInteresesConPagos) {
        // Conservamos la fecha original cuando ya existen
        // períodos de interés con pagos registrados.
        nueva.fechaPrestamo = actual.fechaPrestamo;
      }
    }

    // ---------------------------------------------------------
    // 4. CAMBIO DEL PORCENTAJE DE INTERÉS
    //
    // Permitimos guardar el nuevo porcentaje.
    //
    // Los períodos ya existentes NO serán eliminados, porque
    // podrían contener pagos.
    //
    // Los períodos futuros utilizarán la nueva configuración
    // cuando se generen.
    // ---------------------------------------------------------

    if (cambioPorcentajeInteres) {
      // No es necesario realizar una acción adicional aquí.
      //
      // El nuevo porcentaje permanece en "nueva".
      //
      // No eliminamos intereses existentes.
    }
  }

  //==========================================================
  // NOTIFICACIONES
  //==========================================================

  Future<void> _sincronizarNotificaciones(Deuda deuda) async {
    final configuracion = await _configuracionService.obtener();

    await _deudaNotificationService.programarParaDeuda(
      deuda: deuda,
      configuracion: configuracion,
    );
  }

  Future<void> _cancelarNotificaciones(int deudaId) async {
    await _deudaNotificationService.cancelarParaDeuda(deudaId);
  }

  //==========================================================
  // ESTADOS
  //==========================================================

  Future<void> actualizarEstado(Deuda deuda) async {
    final nuevoEstado = determinarEstado(deuda);

    // if (nuevoEstado != deuda.estado) {
    deuda.estado = nuevoEstado;
    deuda.fechaActualizacion = DateTime.now();

    await _repository.guardar(deuda);
    await _sincronizarNotificaciones(deuda);
    // }
  }

  EstadoDeuda determinarEstado(Deuda deuda) {
    if (deuda.saldoPendiente <= 0) {
      return EstadoDeuda.pagada;
    }

    if (estaVencida(deuda)) {
      return EstadoDeuda.vencida;
    }

    return EstadoDeuda.pendiente;
  }

  bool estaVencida(Deuda deuda) {
    if (deuda.fechaVencimiento == null) {
      return false;
    }

    if (deuda.saldoPendiente <= 0) {
      return false;
    }

    return DateTime.now().isAfter(deuda.fechaVencimiento!);
  }

  Future<void> verificarEstado(Deuda deuda) async {
    await recalcular(deuda);

    // deuda.estado = determinarEstado(deuda);

    // deuda.fechaActualizacion = DateTime.now();

    // await _repository.guardar(deuda);
  }

  //==========================================================
  // RECÁLCULO DESPUÉS DE PAGOS
  //==========================================================

  Future<void> recalcularDespuesPago(Deuda deuda) async {
    await recalcular(deuda);

    // deuda.estado = determinarEstado(deuda);

    // deuda.fechaActualizacion = DateTime.now();

    // await _repository.guardar(deuda);
  }

  Future<void> recalcularDespuesEliminarPago(Deuda deuda) async {
    await recalcular(deuda);

    // deuda.estado = determinarEstado(deuda);

    // deuda.fechaActualizacion = DateTime.now();

    // await _repository.guardar(deuda);
  }

  //==========================================================
  // CAMBIOS MANUALES DE ESTADO
  //==========================================================

  Future<void> marcarComoPagada(int deudaId) async {
    final deuda = await _repository.obtenerPorId(deudaId);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    deuda.totalPagado = deuda.total;
    deuda.saldoPendiente = 0;
    deuda.estado = EstadoDeuda.pagada;
    deuda.fechaActualizacion = DateTime.now();

    await _repository.guardar(deuda);
    await _cancelarNotificaciones(deudaId);
  }

  Future<void> marcarComoPendiente(int deudaId) async {
    final deuda = await _repository.obtenerPorId(deudaId);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    // deuda.estado = EstadoDeuda.pendiente;
    // deuda.fechaActualizacion = DateTime.now();

    await recalcular(deuda);

    // await _repository.guardar(deuda);
  }

  Future<void> marcarComoVencida(int deudaId) async {
    final deuda = await _repository.obtenerPorId(deudaId);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    if (!estaVencida(deuda)) {
      throw const DeudaException(
        'La deuda todavía no cumple las condiciones para estar vencida.',
      );
    }

    deuda.estado = EstadoDeuda.vencida;
    deuda.fechaActualizacion = DateTime.now();

    await _repository.guardar(deuda);
    await _sincronizarNotificaciones(deuda);
  }

  //==========================================================
  // ARCHIVADO
  //==========================================================

  bool puedeArchivarse(Deuda deuda) {
    return deuda.estado == EstadoDeuda.pagada;
  }

  Future<void> archivarAutomaticamente(Deuda deuda) async {
    if (!puedeArchivarse(deuda)) {
      return;
    }

    deuda.archivada = true;
    deuda.fechaActualizacion = DateTime.now();

    await _repository.guardar(deuda);
  }

  Future<void> restaurar(int deudaId) async {
    final deuda = await _repository.obtenerPorId(deudaId);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    deuda.archivada = false;

    // deuda.estado = determinarEstado(deuda);

    // deuda.fechaActualizacion = DateTime.now();

    // await _repository.guardar(deuda);
    await recalcular(deuda);
    await _sincronizarNotificaciones(deuda);
  }

  //==========================================================
  // FECHAS
  //==========================================================

  Future<void> actualizarFechaVencimiento(int deudaId, DateTime? fecha) async {
    final deuda = await _repository.obtenerPorId(deudaId);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    if (fecha != null && fecha.isBefore(deuda.fechaPrestamo)) {
      throw const DeudaException(
        'La fecha de vencimiento no puede ser anterior a la fecha del préstamo.',
      );
    }

    deuda.fechaVencimiento = fecha;
    // deuda.fechaActualizacion = DateTime.now();

    // deuda.estado = determinarEstado(deuda);

    // await _repository.guardar(deuda);
    await recalcular(deuda);
    await _sincronizarNotificaciones(deuda);
  }

  DateTime _calcularFechaVencimientoProgramada(Deuda deuda) {
    return deuda.fechaPrestamo.add(Duration(days: deuda.mesesProgramados * 30));
  }

  DateTime _sumarPeriodoComercial(DateTime fecha) {
    return fecha.add(const Duration(days: 30));
  }

  Future<void> actualizarObservacion(int deudaId, String? observacion) async {
    final deuda = await _repository.obtenerPorId(deudaId);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    final texto = observacion?.trim();

    if (texto != null && texto.length > 500) {
      throw const DeudaException(
        'La observación no puede superar los 500 caracteres.',
      );
    }
    deuda.observacion = texto;
    // deuda.observacion = observacion?.trim();
    // deuda.fechaActualizacion = DateTime.now();

    await _repository.guardar(deuda);
  }

  Future<void> prolongarDeudaProgramada(Deuda deuda) async {
    if (!deuda.programada) {
      throw const DeudaException(
        'La deuda no está configurada como programada.',
      );
    }

    if (deuda.saldoPendiente <= 0) {
      throw const DeudaException('La deuda ya está completamente pagada.');
    }

    if (!estaVencida(deuda)) {
      throw const DeudaException(
        'La deuda todavía no ha llegado a su fecha de vencimiento.',
      );
    }

    // ---------------------------------------------------------
    // 1. Obtener el siguiente período.
    // ---------------------------------------------------------
    final intereses = await _interesRepository.obtenerPorDeuda(deuda.id);

    int siguientePeriodo = 1;

    if (intereses.isNotEmpty) {
      siguientePeriodo =
          intereses
              .map((interes) => interes.numeroPeriodo)
              .reduce((a, b) => a > b ? a : b) +
          1;
    }

    DateTime fechaInicio;

    if (intereses.isEmpty) {
      fechaInicio = deuda.fechaPrestamo;
    } else {
      final ultimo = intereses.reduce(
        (a, b) => a.numeroPeriodo > b.numeroPeriodo ? a : b,
      );

      fechaInicio = ultimo.fechaFin;
    }

    // ---------------------------------------------------------
    // 2. Generar un nuevo mes de interés.
    // ---------------------------------------------------------
    final fechaFin = _sumarPeriodoComercial(fechaInicio);

    final nuevoInteres = InteresDeuda()
      ..deuda.value = deuda
      ..numeroPeriodo = siguientePeriodo
      ..fechaInicio = fechaInicio
      ..fechaFin = fechaFin
      ..porcentaje = deuda.porcentajeInteres
      ..valor = _calcularInteresPeriodo(deuda)
      ..valorPagado = 0
      ..pagado = false
      ..fechaRegistro = DateTime.now();

    await _interesRepository.guardar(nuevoInteres);

    // ---------------------------------------------------------
    // 3. Aumentar duración en un mes comercial.
    // ---------------------------------------------------------
    deuda.mesesProgramados += 1;

    deuda.fechaVencimiento = _calcularFechaVencimientoProgramada(deuda);

    // ---------------------------------------------------------
    // 4. Si utiliza cuotas, agregamos 30 cuotas nuevas.
    //
    // La nueva base es:
    //
    // saldo pendiente anterior
    // +
    // nuevo interés
    //
    // Ejemplo:
    //
    // saldo = 500.000
    // interés = 100.000
    //
    // nueva base = 600.000
    // 600.000 / 30 = 20.000
    // ---------------------------------------------------------
    if (deuda.tieneCuotas) {
      final cuotasExistentes = await _cuotaRepository.obtenerPorDeuda(deuda.id);

      cuotasExistentes.sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

      final ultimoNumeroCuota = cuotasExistentes.isEmpty
          ? 0
          : cuotasExistentes.last.numeroCuota;

      final totalPagado = (await _pagoRepository.obtenerPorDeuda(deuda.id))
          .where((pago) => !pago.eliminado)
          .fold<double>(0, (total, pago) => total + pago.valor);

      final interesesActualizados = await _interesRepository.obtenerPorDeuda(
        deuda.id,
      );

      final interesTotal = interesesActualizados.fold<double>(
        0,
        (total, interes) => total + interes.valor,
      );

      final totalDeuda = deuda.capital + interesTotal;

      final saldoPendiente = totalDeuda - totalPagado;

      final cantidadNuevasCuotas = 30;

      final valorBase = saldoPendiente / cantidadNuevasCuotas;

      final valorRedondeado = (valorBase / 50).round() * 50.0;

      final nuevasCuotas = <CuotaDeuda>[];

      double acumulado = 0;

      for (int i = 1; i <= cantidadNuevasCuotas; i++) {
        double valor;

        if (i == cantidadNuevasCuotas) {
          valor = double.parse((saldoPendiente - acumulado).toStringAsFixed(2));
        } else {
          valor = valorRedondeado;
          acumulado += valor;
        }

        final cuota = CuotaDeuda()
          ..deuda.value = deuda
          ..numeroCuota = ultimoNumeroCuota + i
          ..valor = valor
          ..valorPagado = 0
          ..estado = EstadoCuota.pendiente
          ..fechaPago = null
          ..fechaRegistro = DateTime.now()
          ..fechaActualizacion = null;

        nuevasCuotas.add(cuota);
      }

      await _cuotaRepository.guardarTodas(nuevasCuotas);

      deuda.numeroCuotas += cantidadNuevasCuotas;
    }

    await _repository.guardar(deuda);

    await recalcular(deuda);
    await actualizarEstado(deuda);
  }

  //==========================================================
  // CONTADORES
  //==========================================================

  Future<int> contar() {
    return _repository.contar();
  }

  Future<int> contarPendientes() {
    return _repository.contarPendientes();
  }

  Future<int> contarPagadas() {
    return _repository.contarPagadas();
  }

  Future<int> contarVencidas() {
    return _repository.contarVencidas();
  }

  //==========================================================
  // TOTALES
  //==========================================================

  Future<double> totalCapital() {
    return _repository.totalCapital();
  }

  Future<double> totalPrestado() {
    return _repository.totalPrestado();
  }

  Future<double> totalPagado() {
    return _repository.totalPagado();
  }

  Future<double> totalPendiente() {
    return _repository.totalPendiente();
  }

  //==========================================================
  // DASHBOARD
  //==========================================================

  Future<List<Deuda>> obtenerVencenHoy() {
    return _repository.obtenerVencenHoy();
  }

  Future<List<Deuda>> obtenerVencenEstaSemana() {
    return _repository.obtenerVencenEstaSemana();
  }

  Future<List<Deuda>> obtenerVencidasSinPagar() {
    return _repository.obtenerVencidasSinPagar();
  }

  //==========================================================
  // INDICADORES
  //==========================================================

  Future<bool> existenDeudasPendientes() async {
    return (await contarPendientes()) > 0;
  }

  Future<bool> existenDeudasVencidas() async {
    return (await contarVencidas()) > 0;
  }

  Future<bool> existenDeudasArchivadas() async {
    return (await obtenerArchivadas()).isNotEmpty;
  }

  Future<double> porcentajeCobrado() async {
    final prestado = await totalPrestado();

    if (prestado == 0) {
      return 0;
    }

    final pagado = await totalPagado();

    return (pagado / prestado) * 100;
  }

  Future<double> porcentajePendiente() async {
    final prestado = await totalPrestado();

    if (prestado == 0) {
      return 0;
    }

    final pendiente = await totalPendiente();

    return (pendiente / prestado) * 100;
  }

  //==========================================================
  // EXPORTACIONES
  //==========================================================

  Future<List<Deuda>> obtenerParaExportar({
    bool incluirArchivadas = true,
  }) async {
    if (incluirArchivadas) {
      return obtenerTodas();
    }

    return obtenerActivas();
  }

  //==========================================================
  // MANTENIMIENTO
  //==========================================================

  Future<void> recalcularTodas() async {
    final deudas = await _repository.obtenerTodas();

    for (final deuda in deudas) {
      await recalcular(deuda);
      // deuda.fechaActualizacion = DateTime.now();
    }

    // await _repository.guardarTodas(deudas);
  }

  Future<void> actualizarEstados() async {
    final deudas = await _repository.obtenerTodas();

    // bool cambios = false;
    // final ahora = DateTime.now();
    for (final deuda in deudas) {
      // final estadoAnterior = deuda.estado;

      await recalcular(deuda);

      // if (estadoAnterior != deuda.estado) {
      /*
         * No necesitamos hacer nada adicional.
         * recalcular() ya dejó persistida la deuda.
         */
      // deuda.fechaActualizacion = DateTime.now();
      // cambios = true;
      // } else {
      //   deuda.fechaActualizacion = ahora;
      //   await _repository.guardar(deuda);
      // }
    }

    // if (cambios) {
    //   await _repository.guardarTodas(deudas);
    // }
  }

  Future<void> actualizarDeudasVencidas() async {
    final deudas = await _repository.obtenerPendientes();

    // bool cambios = false;

    for (final deuda in deudas) {
      if (estaVencida(deuda)) {
        deuda.estado = EstadoDeuda.vencida;
        deuda.fechaActualizacion = DateTime.now();
        // cambios = true;
        await _repository.guardar(deuda);
      }
    }

    // if (cambios) {
    //   await _repository.guardarTodas(deudas);
    // }
  }

  Future<void> archivarPagadas() async {
    final deudas = await _repository.obtenerPagadas();

    // bool cambios = false;
    final deudasParaGuardar = <Deuda>[];

    for (final deuda in deudas) {
      if (!deuda.archivada) {
        deuda.archivada = true;
        deuda.fechaActualizacion = DateTime.now();
        // cambios = true;
        deudasParaGuardar.add(deuda);
      }
    }

    // if (cambios) {
    //   await _repository.guardarTodas(deudas);
    // }
    if (deudasParaGuardar.isNotEmpty) {
      await _repository.guardarTodas(deudasParaGuardar);
    }
  }

  Future<void> desarchivarTodas() async {
    final deudas = await _repository.obtenerArchivadas();

    // bool cambios = false;
    final deudasParaGuardar = <Deuda>[];

    for (final deuda in deudas) {
      deuda.archivada = false;
      deuda.fechaActualizacion = DateTime.now();
      // cambios = true;
      deudasParaGuardar.add(deuda);
    }

    // if (cambios) {
    //   await _repository.guardarTodas(deudas);
    // }
    if (deudasParaGuardar.isNotEmpty) {
      await _repository.guardarTodas(deudasParaGuardar);
    }
  }

  Future<void> eliminarTodas() async {
    await _repository.limpiar();
  }

  //==========================================================
  // UTILIDADES
  //==========================================================

  Future<Deuda> duplicar(int deudaId) async {
    final original = await _repository.obtenerPorId(deudaId);

    if (original == null) {
      throw const DeudaException('La deuda no existe.');
    }

    await original.cliente.load();

    final nueva = Deuda()
      ..cliente.value = original.cliente.value
      ..capital = original.capital
      ..porcentajeInteres = original.porcentajeInteres
      ..interesCalculado = 0
      ..total = original.capital
      ..saldoPendiente = original.capital
      ..totalPagado = 0
      ..fechaPrestamo = DateTime.now()
      ..fechaRegistro = DateTime.now()
      ..fechaVencimiento = original.fechaVencimiento
      ..observacion = original.observacion
      ..estado = EstadoDeuda.pendiente
      ..archivada = false;

    await _repository.guardar(nueva);

    return nueva;
  }

  Future<bool> existePorUuid(String uuid) async {
    return await _repository.obtenerPorUuid(uuid) != null;
  }

  //==========================================================
  // RESÚMENES
  //==========================================================

  Future<DeudaSummary> obtenerResumen(int deudaId) async {
    final deuda = await _repository.obtenerPorId(deudaId);

    if (deuda == null) {
      throw const DeudaException('La deuda no existe.');
    }

    return _construirResumen(deuda);
  }

  Future<List<DeudaSummary>> obtenerResumenes() async {
    final deudas = await obtenerTodas();

    return Future.wait(deudas.map(_construirResumen));
  }

  Future<List<DeudaSummary>> obtenerResumenCliente(int clienteId) async {
    final deudas = await _repository.obtenerPorCliente(clienteId);

    return Future.wait(deudas.map(_construirResumen));
  }

  Future<DeudaSummary> _construirResumen(Deuda deuda) async {
    await deuda.cliente.load();
    // await deuda.pagos.load();
    final pagos = await _pagoRepository.obtenerPorDeuda(deuda.id);
    final pagosActivos = pagos.where((pago) => !pago.eliminado).toList();

    DateTime? ultimoPago;

    // if (deuda.pagos.isNotEmpty) {
    //   final pagos = deuda.pagos.toList()
    //     ..sort((a, b) => b.fechaPago.compareTo(a.fechaPago));

    // ultimoPago = pagos.first.fechaPago;
    // }
    if (pagosActivos.isNotEmpty) {
      pagosActivos.sort((a, b) => b.fechaPago.compareTo(a.fechaPago));

      ultimoPago = pagosActivos.first.fechaPago;
    }

    final ahora = DateTime.now();

    final diasTranscurridos = ahora.difference(deuda.fechaPrestamo).inDays;

    int diasRestantes = 0;

    if (deuda.fechaVencimiento != null) {
      diasRestantes = deuda.fechaVencimiento!.difference(ahora).inDays;
    }

    return DeudaSummary(
      deuda: deuda,
      cliente: deuda.cliente.value!,
      capital: deuda.capital,
      porcentajeInteres: deuda.porcentajeInteres,
      interesCalculado: deuda.interesCalculado,
      total: deuda.total,
      totalPagado: deuda.totalPagado,
      saldoPendiente: deuda.saldoPendiente,
      cantidadPagos: pagosActivos.length,
      fechaPrestamo: deuda.fechaPrestamo,
      fechaVencimiento: deuda.fechaVencimiento,
      ultimoPago: ultimoPago,
      diasTranscurridos: diasTranscurridos,
      diasRestantes: diasRestantes,
      vencida: deuda.estado == EstadoDeuda.vencida,
      pagada: deuda.estado == EstadoDeuda.pagada,
      pendiente: deuda.estado == EstadoDeuda.pendiente,
      archivada: deuda.archivada,
    );
  }
}
