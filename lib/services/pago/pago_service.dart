import '../../core/enums/estado_cuota.dart';
import '../../core/enums/metodo_pago.dart';
import '../../core/enums/tipo_pago.dart';
import '../../models/cuota_deuda.dart';
import '../../models/deuda.dart';
import '../../models/interes_deuda.dart';
import '../../models/pago.dart';
import '../../repositories/cuota_deuda_repository.dart';
import '../../repositories/interes_deuda_repository.dart';
import '../../repositories/pago_repository.dart';
import '../configuracion/configuracion_service.dart';
import '../deuda/deuda_service.dart';
import 'pago_exception.dart';
import 'pago_filter.dart';
import 'pago_summary.dart';
import 'pago_validator.dart';

class PagoService {
  PagoService({
    required this._repository,
    required this._validator,
    required this._deudaService,
    required this._interesRepository,
    required this._cuotaRepository,
    required this._configuracionService,
  });

  final PagoRepository _repository;
  final PagoValidator _validator;
  final DeudaService _deudaService;
  final InteresDeudaRepository _interesRepository;
  final CuotaDeudaRepository _cuotaRepository;
  final ConfiguracionService _configuracionService;

  //==========================================================
  // CRUD
  //==========================================================

  // Future<Pago> crear(Pago pago) async {
  //   await _validator.validar(pago);

  //   pago.fechaRegistro = DateTime.now();
  //   pago.fechaActualizacion = null;
  //   pago.eliminado = false;

  //   await _repository.guardar(pago);

  //   return pago;
  // }

  // Future<Pago> editar(Pago pago) async {
  //   final actual = await _repository.obtenerPorId(pago.id);

  //   if (actual == null) {
  //     throw const PagoException('El pago no existe.');
  //   }

  //   await _validator.validar(pago);

  //   pago.fechaRegistro = actual.fechaRegistro;
  //   pago.fechaActualizacion = DateTime.now();

  //   await _repository.guardar(pago);

  //   return pago;
  // }

  // Future<void> eliminar(int id) async {
  //   final pago = await _repository.obtenerPorId(id);

  //   if (pago == null) {
  //     throw const PagoException('El pago no existe.');
  //   }

  //   await _repository.eliminar(id);
  // }

  //==========================================================
  // CONSULTAS
  //==========================================================

  Future<List<Pago>> obtenerTodos() {
    return _repository.obtenerTodos();
  }

  Future<List<Pago>> obtenerActivos() {
    return _repository.obtenerActivos();
  }

  Future<List<Pago>> obtenerEliminados() {
    return _repository.obtenerEliminados();
  }

  Future<Pago> obtenerPorId(int id) async {
    final pago = await _repository.obtenerPorId(id);

    if (pago == null) {
      throw const PagoException('El pago no existe.');
    }

    return pago;
  }

  Future<Pago> obtenerPorUuid(String uuid) async {
    final pago = await _repository.obtenerPorUuid(uuid);

    if (pago == null) {
      throw const PagoException('El pago no existe.');
    }

    return pago;
  }

  Future<List<Pago>> obtenerPorDeuda(int deudaId) {
    return _repository.obtenerPorDeuda(deudaId);
  }

  //==========================================================
  // BÚSQUEDA
  //==========================================================

  Future<List<Pago>> buscar(String texto) {
    return _repository.buscar(texto.trim());
  }

  //==========================================================
  // FILTROS
  //==========================================================

  Future<List<Pago>> filtrar(PagoFilter filter) {
    if (!filter.tieneFiltros) {
      return _repository.obtenerTodos();
    }
    return _repository.filtrar(
      deudaId: filter.deudaId,
      metodoPago: filter.metodoPago,
      eliminado: filter.eliminado,
      desde: filter.desde,
      hasta: filter.hasta,
    );
  }

  //==========================================================
  // VALIDACIONES
  //==========================================================

  Future<void> validar(Pago pago) {
    return _validator.validar(pago);
  }

  Future<bool> existe(String uuid) {
    return _validator.existe(uuid);
  }

  Future<bool> puedeEliminar(int id) async {
    final pago = await _repository.obtenerPorId(id);

    return pago != null;
  }

  Future<bool> estaEliminado(int id) async {
    final pago = await _repository.obtenerPorId(id);

    if (pago == null) {
      return false;
    }

    return pago.eliminado;
  }

  //==========================================================
  // REGISTRO DE PAGOS
  //==========================================================

  Future<Pago> registrarPago(
    Pago pago, {
    List<CuotaDeuda> cuotasSeleccionadas = const [],
  }) async {
    await _validator.validar(pago);

    // await pago.deuda.load();

    final deudaSeleccionada = pago.deuda.value;

    if (deudaSeleccionada == null) {
      throw const PagoException('La deuda asociada no existe.');
    }

    final deuda = await _deudaService.obtenerPorId(deudaSeleccionada.id);

    if (deuda == null) {
      throw const PagoException('La deuda asociada no existe.');
    }

    if (deuda.archivada) {
      throw const PagoException(
        'No es posible registrar pagos sobre una deuda archivada.',
      );
    }

    if (pago.valor <= 0) {
      throw const PagoException('El valor del pago debe ser mayor que cero.');
    }

    // ==========================================================
    // DEUDA PROGRAMADA CON CUOTAS
    // ==========================================================
    if (deuda.programada && deuda.tieneCuotas) {
      await _deudaService.recalcular(deuda);

      if (deuda.saldoPendiente <= 0) {
        throw const PagoException(
          'La deuda ya se encuentra totalmente pagada.',
        );
      }

      if (pago.valor > deuda.saldoPendiente) {
        throw const PagoException(
          'El valor del pago supera el saldo pendiente de la deuda.',
        );
      }

      if (cuotasSeleccionadas.isEmpty) {
        throw const PagoException(
          'Debe seleccionar al menos una cuota para el pago.',
        );
      }

      await _validarCuotasPago(deuda, cuotasSeleccionadas, pago.valor);

      pago.deuda.value = deuda;
      pago.interes.value = null;

      pago.cuotas
        ..clear()
        ..addAll(cuotasSeleccionadas);

      // Se conserva TipoPago.capital como valor técnico para
      // mantener compatibilidad con el modelo actual.
      pago.tipoPago = TipoPago.capital;
      pago.numeroPago = await _configuracionService.reservarNumeroPago();
      await _repository.guardar(pago);

      await _actualizarCuotasDesdePagos(deuda);

      await _deudaService.recalcular(deuda);
      await _deudaService.actualizarEstado(deuda);

      return pago;
    }

    // ==========================================================
    // PAGO DE CAPITAL
    // ==========================================================
    if (pago.tipoPago == TipoPago.capital) {
      final capitalPagado = await _obtenerCapitalPagado(deuda.id);
      final capitalPendiente = deuda.capital - capitalPagado;

      if (capitalPendiente <= 0) {
        throw const PagoException(
          'La deuda ya no tiene capital pendiente por pagar.',
        );
      }

      if (pago.valor > capitalPendiente) {
        throw const PagoException(
          'El valor del pago supera el capital pendiente.',
        );
      }

      // ----------------------------------------------------------
      // Si la deuda utiliza cuotas, validamos las cuotas
      // seleccionadas.
      // ----------------------------------------------------------

      if (deuda.tieneCuotas) {
        if (cuotasSeleccionadas.isEmpty) {
          throw const PagoException(
            'Debe seleccionar al menos una cuota para el pago.',
          );
        }

        await _validarCuotasPago(deuda, cuotasSeleccionadas, pago.valor);

        pago.cuotas
          ..clear()
          ..addAll(cuotasSeleccionadas);
      } else {
        pago.cuotas.clear();
      }

      // Un pago de capital no necesita asociarse a un interés.
      pago.interes.value = null;
      pago.deuda.value = deuda;
      pago.numeroPago = await _configuracionService.reservarNumeroPago();
      await _repository.guardar(pago);

      // Actualizamos el estado de las cuotas afectadas.
      if (deuda.tieneCuotas) {
        await _actualizarCuotasDesdePagos(deuda);
      }

      await _deudaService.recalcular(deuda);
      await _deudaService.actualizarEstado(deuda);

      return pago;
    }

    // ==========================================================
    // PAGO DE INTERÉS
    // ==========================================================

    if (pago.tipoPago == TipoPago.interes) {
      final interesSeleccionado = pago.interes.value;

      if (interesSeleccionado == null) {
        throw const PagoException(
          'Debe seleccionar el período de interés que desea pagar.',
        );
      }

      final interes = await _interesRepository.obtenerPorId(
        interesSeleccionado.id,
      );

      if (interes == null) {
        throw const PagoException('El período de interés no existe.');
      }

      await interes.deuda.load();

      final deudaInteres = interes.deuda.value;

      if (deudaInteres == null || deudaInteres.id != deuda.id) {
        throw const PagoException(
          'El interés seleccionado no pertenece a la deuda.',
        );
      }

      await _actualizarInteresDesdePagos(interes);

      if (interes.pagado || interes.saldoPendiente <= 0) {
        throw const PagoException(
          'El interés seleccionado ya se encuentra completamente pagado.',
        );
      }

      if (pago.valor > interes.saldoPendiente) {
        throw const PagoException(
          'El valor del pago supera el interés pendiente del período.',
        );
      }

      pago.deuda.value = deuda;
      pago.interes.value = interes;

      // Un pago de interés no tiene cuotas de capital.
      // await pago.cuotas.load();
      pago.cuotas.clear();
      pago.numeroPago = await _configuracionService.reservarNumeroPago();
      await _repository.guardar(pago);

      await _actualizarInteresDesdePagos(interes);

      await _deudaService.recalcular(deuda);
      await _deudaService.actualizarEstado(deuda);

      return pago;
    }

    throw const PagoException('El tipo de pago no es válido.');
  }

  //==========================================================
  // EDICIÓN
  //==========================================================

  Future<Pago> editarPago(Pago pago) async {
    final anterior = await obtenerPorId(pago.id);
    // Obtenemos la deuda anterior.
    await anterior.deuda.load();
    await anterior.interes.load();
    await anterior.cuotas.load();

    final deudaAnterior = anterior.deuda.value;
    final interesAnterior = anterior.interes.value;
    // Validamos el nuevo pago.
    await _validator.validar(pago);

    // La deuda seleccionada en el formulario.
    final deudaSeleccionada = pago.deuda.value;

    if (deudaSeleccionada == null) {
      throw const PagoException('La deuda asociada no existe.');
    }

    // Obtenemos la deuda nueva desde Isar.
    final deudaNueva = await _deudaService.obtenerPorId(deudaSeleccionada.id);

    if (deudaNueva == null) {
      throw const PagoException('La deuda asociada no existe.');
    }

    if (deudaNueva.archivada) {
      throw const PagoException(
        'No es posible asociar el pago a una deuda archivada.',
      );
    }

    if (pago.valor <= 0) {
      throw const PagoException('El valor del pago debe ser mayor que cero.');
    }
    if (deudaNueva.programada && deudaNueva.tieneCuotas) {
      await _deudaService.recalcular(deudaNueva);

      final saldoDisponible = deudaNueva.saldoPendiente + anterior.valor;

      if (pago.valor > saldoDisponible) {
        throw const PagoException(
          'El valor del pago supera el saldo pendiente de la deuda.',
        );
      }

      await pago.cuotas.load();

      final cuotas = pago.cuotas.toList();

      if (cuotas.isEmpty) {
        throw const PagoException(
          'Debe seleccionar al menos una cuota para el pago.',
        );
      }

      await _validarCuotasPago(
        deudaNueva,
        cuotas,
        pago.valor,
        excluirPagoId: pago.id,
      );

      pago.tipoPago = TipoPago.capital;
      pago.interes.value = null;
    }
    // ==========================================================
    // VALIDACIÓN DEL NUEVO TIPO DE PAGO
    // ==========================================================

    if (pago.tipoPago == TipoPago.capital &&
        !(deudaNueva.programada && deudaNueva.tieneCuotas)) {
      final capitalPagado = await _obtenerCapitalPagado(
        deudaNueva.id,
        excluirPagoId: pago.id,
      );

      final capitalPendiente = deudaNueva.capital - capitalPagado;

      if (capitalPendiente <= 0) {
        throw const PagoException(
          'La deuda no tiene capital pendiente por pagar.',
        );
      }

      if (pago.valor > capitalPendiente) {
        throw const PagoException(
          'El valor del pago supera el capital pendiente.',
        );
      }

      if (deudaNueva.tieneCuotas) {
        await pago.cuotas.load();

        final cuotas = pago.cuotas.toList();

        if (cuotas.isEmpty) {
          throw const PagoException(
            'Debe seleccionar al menos una cuota para el pago.',
          );
        }

        await _validarCuotasPago(deudaNueva, cuotas, pago.valor);
      }

      pago.interes.value = null;
    }

    // ==========================================================
    // NUEVO PAGO DE INTERÉS
    // ==========================================================

    if (pago.tipoPago == TipoPago.interes) {
      final interesSeleccionado = pago.interes.value;

      if (interesSeleccionado == null) {
        throw const PagoException(
          'Debe seleccionar el período de interés que desea pagar.',
        );
      }

      final interesNuevo = await _interesRepository.obtenerPorId(
        interesSeleccionado.id,
      );

      if (interesNuevo == null) {
        throw const PagoException('El período de interés no existe.');
      }

      await interesNuevo.deuda.load();

      final deudaDelInteres = interesNuevo.deuda.value;

      if (deudaDelInteres == null || deudaDelInteres.id != deudaNueva.id) {
        throw const PagoException(
          'El interés seleccionado no pertenece a la deuda.',
        );
      }

      await _actualizarInteresDesdePagos(interesNuevo, excluirPagoId: pago.id);

      if (interesNuevo.pagado || interesNuevo.saldoPendiente <= 0) {
        throw const PagoException(
          'El interés seleccionado ya se encuentra completamente pagado.',
        );
      }

      if (pago.valor > interesNuevo.saldoPendiente) {
        throw const PagoException(
          'El valor del pago supera el interés pendiente del período.',
        );
      }

      pago.interes.value = interesNuevo;

      // Un pago de interés no tiene cuotas.
      await pago.cuotas.load();
      pago.cuotas.clear();
    }

    pago.fechaRegistro = anterior.fechaRegistro;
    pago.fechaActualizacion = DateTime.now();

    pago.deuda.value = deudaNueva;

    await _repository.guardar(pago);

    if (interesAnterior != null) {
      await _actualizarInteresDesdePagos(interesAnterior);
    }

    // ==========================================================
    // ACTUALIZAR INTERÉS NUEVO
    // ==========================================================

    if (pago.tipoPago == TipoPago.interes) {
      final interesNuevo = pago.interes.value;

      if (interesNuevo != null) {
        await _actualizarInteresDesdePagos(interesNuevo);
      }
    }

    // ==========================================================
    // RECALCULAR DEUDAS
    // ==========================================================

    final deudasARecalcular = <int>{};

    if (deudaAnterior != null) {
      deudasARecalcular.add(deudaAnterior.id);
    }

    deudasARecalcular.add(deudaNueva.id);

    for (final deudaId in deudasARecalcular) {
      final deuda = await _deudaService.obtenerPorId(deudaId);

      if (deuda == null) {
        continue;
      }

      if (deuda.tieneCuotas) {
        await _actualizarCuotasDesdePagos(deuda);
      }

      await _deudaService.recalcular(deuda);
      await _deudaService.actualizarEstado(deuda);
    }

    return pago;
  }

  //==========================================================
  // ELIMINACIÓN LÓGICA
  //==========================================================

  Future<void> eliminarPago(int id) async {
    final pago = await obtenerPorId(id);

    if (pago.eliminado) {
      return;
    }
    // Primero obtenemos la deuda asociada mientras el pago
    // todavía está administrado por Isar.
    await pago.deuda.load();
    await pago.interes.load();
    await pago.cuotas.load();

    final deuda = pago.deuda.value;
    final interes = pago.interes.value;

    pago.eliminado = true;
    pago.fechaActualizacion = DateTime.now();

    await _repository.guardar(pago);

    // Si era un pago de interés, recalculamos el período.
    if (interes != null) {
      await _actualizarInteresDesdePagos(interes);
    }

    if (deuda != null) {
      if (deuda.tieneCuotas) {
        await _actualizarCuotasDesdePagos(deuda);
      }

      await _deudaService.recalcular(deuda);
      await _deudaService.actualizarEstado(deuda);
    }
  }

  //Validación de cuotas
  Future<void> _validarCuotasPago(
    Deuda deuda,
    List<CuotaDeuda> cuotas,
    double valorPago, {
    int? excluirPagoId,
  }) async {
    double saldoDisponible = 0;
    if (cuotas.isEmpty) {
      throw const PagoException('Debe seleccionar al menos una cuota.');
    }

    final cuotasDeuda = await _cuotaRepository.obtenerPorDeuda(deuda.id);

    final cuotasPorId = {for (final cuota in cuotasDeuda) cuota.id: cuota};

    for (final cuotaSeleccionada in cuotas) {
      final cuota = cuotasPorId[cuotaSeleccionada.id];

      if (cuota == null) {
        throw const PagoException('Una de las cuotas seleccionadas no existe.');
      }

      await cuota.deuda.load();

      final deudaCuota = cuota.deuda.value;

      if (deudaCuota == null || deudaCuota.id != deuda.id) {
        throw const PagoException(
          'Una de las cuotas seleccionadas no pertenece a la deuda.',
        );
      }

      // if (cuota.saldoPendiente > 0) {
      //   saldoDisponible += cuota.saldoPendiente;
      // }
    }
    // Calculamos cuánto ha sido aplicado realmente a cada cuota
    // por los pagos activos existentes.
    final pagos = await _repository.obtenerPorDeuda(deuda.id);

    final pagosAplicables = pagos
        .where(
          (pago) =>
              !pago.eliminado &&
              (excluirPagoId == null || pago.id != excluirPagoId),
        )
        .toList();

    cuotasDeuda.sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

    final pagadoPorCuota = <int, double>{
      for (final cuota in cuotasDeuda) cuota.id: 0,
    };

    for (final pago in pagosAplicables) {
      await pago.cuotas.load();

      final cuotasDelPago = pago.cuotas.toList()
        ..sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

      double disponible = pago.valor;

      for (final cuotaRelacionada in cuotasDelPago) {
        if (disponible <= 0) {
          break;
        }

        final cuota = cuotasPorId[cuotaRelacionada.id];

        if (cuota == null) {
          continue;
        }

        final pagado = pagadoPorCuota[cuota.id] ?? 0;
        final pendiente = cuota.valor - pagado;

        if (pendiente <= 0) {
          continue;
        }

        final aplicado = disponible < pendiente ? disponible : pendiente;

        pagadoPorCuota[cuota.id] = pagado + aplicado;
        disponible -= aplicado;
      }
    }
    for (final cuotaSeleccionada in cuotas) {
      final cuota = cuotasPorId[cuotaSeleccionada.id]!;

      final pagado = pagadoPorCuota[cuota.id] ?? 0;
      final saldo = cuota.valor - pagado;

      if (saldo > 0) {
        saldoDisponible += saldo;
      }
    }
    if (saldoDisponible <= 0) {
      throw const PagoException(
        'Las cuotas seleccionadas no tienen saldo pendiente.',
      );
    }

    if (valorPago > saldoDisponible) {
      throw const PagoException(
        'El valor del pago supera el saldo pendiente de las cuotas seleccionadas.',
      );
    }
  }

  // Actualizar cuotas
  Future<void> _actualizarCuotasDesdePagos(Deuda deuda) async {
    if (!deuda.tieneCuotas) {
      return;
    }

    final cuotas = await _cuotaRepository.obtenerPorDeuda(deuda.id);

    if (cuotas.isEmpty) {
      return;
    }

    final pagos = await _repository.obtenerPorDeuda(deuda.id);

    final pagosAplicables = deuda.programada
        ? pagos.where((pago) => !pago.eliminado).toList()
        : pagos
              .where(
                (pago) => !pago.eliminado && pago.tipoPago == TipoPago.capital,
              )
              .toList();

    cuotas.sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));
    // Reiniciamos el estado de todas las cuotas.
    for (final cuota in cuotas) {
      cuota.valorPagado = 0;
      cuota.estado = EstadoCuota.pendiente;
      cuota.fechaPago = null;
      cuota.fechaActualizacion = DateTime.now();
    }
    final cuotasPorId = {for (final cuota in cuotas) cuota.id: cuota};

    // Distribuimos cada pago entre sus cuotas asociadas.
    for (final pago in pagosAplicables) {
      await pago.cuotas.load();

      final cuotasDelPago = pago.cuotas.toList()
        ..sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

      double disponible = pago.valor;

      for (final cuotaRelacionada in cuotasDelPago) {
        if (disponible <= 0) {
          break;
        }

        final cuota = cuotasPorId[cuotaRelacionada.id];

        if (cuota == null) {
          continue;
        }

        final pendiente = cuota.valor - cuota.valorPagado;

        if (pendiente <= 0) {
          continue;
        }

        final aplicado = disponible < pendiente ? disponible : pendiente;

        cuota.valorPagado += aplicado;
        disponible -= aplicado;
      }
    }
    for (final cuota in cuotas) {
      if (cuota.valorPagado >= cuota.valor) {
        cuota.valorPagado = cuota.valor;
        cuota.estado = EstadoCuota.pagada;

        final pagosDeCuota = <Pago>[];

        for (final pago in pagosAplicables) {
          await pago.cuotas.load();

          if (pago.cuotas.any((cuotaPago) => cuotaPago.id == cuota.id)) {
            pagosDeCuota.add(pago);
          }
        }

        if (pagosDeCuota.isNotEmpty) {
          cuota.fechaPago = pagosDeCuota
              .map((pago) => pago.fechaPago)
              .reduce((a, b) => a.isAfter(b) ? a : b);
        }
      } else if (cuota.valorPagado > 0) {
        cuota.estado = EstadoCuota.parcial;
        cuota.fechaPago = null;
      } else {
        cuota.estado = EstadoCuota.pendiente;
        cuota.fechaPago = null;
      }

      cuota.fechaActualizacion = DateTime.now();
    }

    await _cuotaRepository.guardarTodas(cuotas);
  }

  //==========================================================
  // RESTAURACIÓN
  //==========================================================

  Future<void> restaurarPago(int id) async {
    final pago = await obtenerPorId(id);

    if (!pago.eliminado) {
      return;
    }
    await pago.deuda.load();
    await pago.interes.load();
    await pago.cuotas.load();

    final deuda = pago.deuda.value;
    final interes = pago.interes.value;

    if (deuda == null) {
      throw const PagoException('La deuda asociada al pago no existe.');
    }

    pago.eliminado = false;
    pago.fechaActualizacion = DateTime.now();

    await _repository.guardar(pago);

    if (interes != null) {
      await _actualizarInteresDesdePagos(interes);
    }

    if (deuda.tieneCuotas) {
      await _actualizarCuotasDesdePagos(deuda);
    }

    await _deudaService.recalcular(deuda);
    await _deudaService.actualizarEstado(deuda);
  }

  //==========================================================
  // RECÁLCULOS
  //==========================================================

  Future<void> recalcularDeuda(int deudaId) async {
    final deuda = await _deudaService.obtenerPorId(deudaId);
    if (deuda == null) {
      throw const PagoException('La deuda asociada no existe.');
    }

    await _deudaService.recalcular(deuda);
    await _deudaService.actualizarEstado(deuda);
  }

  //==========================================================
  // VALIDACIONES DE NEGOCIO
  //==========================================================

  Future<bool> puedeRegistrarPago(Pago pago) async {
    // await pago.deuda.load();

    final deudaSeleccionada = pago.deuda.value;
    if (deudaSeleccionada == null) {
      return false;
    }

    final deuda = await _deudaService.obtenerPorId(deudaSeleccionada.id);

    if (deuda == null) {
      return false;
    }

    if (deuda.archivada) {
      return false;
    }

    if (pago.valor <= 0) {
      return false;
    }
    // ==========================================================
    // CAPITAL
    // ==========================================================

    // if (pago.tipoPago == TipoPago.capital) {
    //   final capitalPagado = await _obtenerCapitalPagado(deuda.id);

    //   final capitalPendiente = deuda.capital - capitalPagado;

    //   if (capitalPendiente <= 0 || pago.valor > capitalPendiente) {
    //     return false;
    //   }

    //   if (!deuda.tieneCuotas) {
    //     return true;
    //   }

    //   await pago.cuotas.load();

    //   final cuotas = pago.cuotas.toList();

    //   if (cuotas.isEmpty) {
    //     return false;
    //   }

    //   try {
    //     await _validarCuotasPago(deuda, cuotas, pago.valor);

    //     return true;
    //   } catch (_) {
    //     return false;
    //   }
    // }
    if (deuda.programada && deuda.tieneCuotas) {
      if (pago.valor > deuda.saldoPendiente) {
        return false;
      }

      await pago.cuotas.load();

      final cuotas = pago.cuotas.toList();

      if (cuotas.isEmpty) {
        return false;
      }

      try {
        await _validarCuotasPago(deuda, cuotas, pago.valor);

        return true;
      } catch (_) {
        return false;
      }
    }

    if (pago.tipoPago == TipoPago.capital) {
      final capitalPagado = await _obtenerCapitalPagado(deuda.id);

      final capitalPendiente = deuda.capital - capitalPagado;

      if (capitalPendiente <= 0 || pago.valor > capitalPendiente) {
        return false;
      }

      if (!deuda.tieneCuotas) {
        return true;
      }

      await pago.cuotas.load();

      final cuotas = pago.cuotas.toList();

      if (cuotas.isEmpty) {
        return false;
      }

      try {
        await _validarCuotasPago(deuda, cuotas, pago.valor);

        return true;
      } catch (_) {
        return false;
      }
    }

    if (pago.tipoPago == TipoPago.interes) {
      final interesSeleccionado = pago.interes.value;

      if (interesSeleccionado == null) {
        return false;
      }

      final interes = await _interesRepository.obtenerPorId(
        interesSeleccionado.id,
      );

      if (interes == null) {
        return false;
      }

      await interes.deuda.load();

      final deudaDelInteres = interes.deuda.value;

      if (deudaDelInteres == null || deudaDelInteres.id != deuda.id) {
        return false;
      }

      await _actualizarInteresDesdePagos(interes);

      if (interes.pagado) {
        return false;
      }

      return pago.valor <= interes.saldoPendiente;
    }

    return false;
  }

  Future<bool> deudaTieneSaldo(int deudaId) async {
    final deuda = await _deudaService.obtenerPorId(deudaId);
    if (deuda == null) {
      return false;
    }

    final capitalPagado = await _obtenerCapitalPagado(deuda.id);

    final capitalPendiente = deuda.capital - capitalPagado;

    return capitalPendiente > 0;
  }

  //==========================================================
  // DASHBOARD
  //==========================================================

  Future<List<Pago>> obtenerHoy() {
    return _repository.obtenerHoy();
  }

  Future<List<Pago>> obtenerEstaSemana() {
    return _repository.obtenerEstaSemana();
  }

  Future<List<Pago>> obtenerEsteMes() {
    return _repository.obtenerEsteMes();
  }

  Future<List<Pago>> obtenerUltimos(int cantidad) {
    return _repository.obtenerUltimos(cantidad);
  }

  //==========================================================
  // CONTADORES
  //==========================================================

  Future<int> contar() {
    return _repository.contar();
  }

  Future<int> contarHoy() {
    return _repository.contarHoy();
  }

  Future<int> contarEsteMes() {
    return _repository.contarEsteMes();
  }

  //==========================================================
  // TOTALES
  //==========================================================

  Future<double> totalRecaudado() async {
    final pagos = await obtenerActivos();

    return pagos.fold<double>(0, (total, pago) => total + pago.valor);
  }

  Future<double> totalHoy() async {
    final pagos = await obtenerHoy();

    double total = 0;

    for (final pago in pagos) {
      if (!pago.eliminado) {
        total += pago.valor;
      }
    }

    return total;
  }

  Future<double> totalSemana() async {
    final pagos = await obtenerEstaSemana();

    double total = 0;

    for (final pago in pagos) {
      if (!pago.eliminado) {
        total += pago.valor;
      }
    }

    return total;
  }

  Future<double> totalMes() async {
    final pagos = await obtenerEsteMes();

    double total = 0;

    for (final pago in pagos) {
      if (!pago.eliminado) {
        total += pago.valor;
      }
    }

    return total;
  }

  //==========================================================
  // RESÚMENES
  //==========================================================

  Future<PagoSummary> obtenerResumen(int pagoId) async {
    final pago = await obtenerPorId(pagoId);

    return _construirResumen(pago);
  }

  Future<List<PagoSummary>> obtenerResumenes() async {
    final pagos = await obtenerTodos();

    return Future.wait(pagos.map(_construirResumen));
  }

  Future<List<PagoSummary>> obtenerResumenesDeuda(int deudaId) async {
    final pagos = await obtenerPorDeuda(deudaId);

    return Future.wait(pagos.map(_construirResumen));
  }

  //==========================================================
  // INDICADORES
  //==========================================================

  Future<bool> existenPagos() async {
    return (await contar()) > 0;
  }

  Future<bool> existenPagosHoy() async {
    return (await contarHoy()) > 0;
  }

  Future<bool> existenPagosEsteMes() async {
    return (await contarEsteMes()) > 0;
  }

  Future<double> promedioPago() async {
    final cantidad = await contar();

    if (cantidad == 0) {
      return 0;
    }

    final total = await totalRecaudado();

    return total / cantidad;
  }

  //==========================================================
  // RESUMEN PRIVADO
  //==========================================================

  Future<PagoSummary> _construirResumen(Pago pago) async {
    await pago.deuda.load();

    final deuda = pago.deuda.value;

    if (deuda == null) {
      throw const PagoException('La deuda asociada al pago no existe.');
    }

    return PagoSummary(
      pago: pago,
      deuda: deuda,
      valor: pago.valor,
      fechaPago: pago.fechaPago,
      metodoPago: pago.metodoPago,
      referencia: pago.referencia,
      observacion: pago.observacion,
      eliminado: pago.eliminado,
      fechaRegistro: pago.fechaRegistro,
      fechaActualizacion: pago.fechaActualizacion,
      capitalDeuda: deuda.capital,
      totalDeuda: deuda.total,
      totalPagado: deuda.totalPagado,
      saldoPendiente: deuda.saldoPendiente,
      estadoDeuda: deuda.estado,
    );
  }

  //==========================================================
  // EXPORTACIONES
  //==========================================================

  Future<List<Pago>> obtenerParaExportar({
    bool incluirEliminados = false,
  }) async {
    if (incluirEliminados) {
      return obtenerTodos();
    }

    return obtenerActivos();
  }

  //==========================================================
  // MANTENIMIENTO
  //==========================================================

  Future<void> actualizarFechas() async {
    final pagos = await obtenerTodos();

    bool cambios = false;

    for (final pago in pagos) {
      if (pago.fechaActualizacion == null) {
        pago.fechaActualizacion = pago.fechaRegistro;
        cambios = true;
      }
    }

    if (cambios) {
      await _repository.guardarTodos(pagos);
    }
  }

  Future<void> restaurarTodos() async {
    final pagos = await obtenerEliminados();

    if (pagos.isEmpty) {
      return;
    }

    final Set<int> deudas = {};

    for (final pago in pagos) {
      pago.eliminado = false;
      pago.fechaActualizacion = DateTime.now();

      await pago.deuda.load();

      final deuda = pago.deuda.value;

      if (deuda != null) {
        deudas.add(deuda.id);
      }
    }

    await _repository.guardarTodos(pagos);

    // for (final pago in pagos) {
    //   await pago.deuda.load();

    //   if (pago.deuda.value != null) {
    //     deudas.add(pago.deuda.value!.id);
    //   }
    // }

    for (final deudaId in deudas) {
      await recalcularDeuda(deudaId);
    }
  }

  Future<void> eliminarTodos() async {
    final pagos = await obtenerTodos();

    if (pagos.isEmpty) {
      return;
    }

    final Set<int> deudas = {};

    for (final pago in pagos) {
      pago.eliminado = true;
      pago.fechaActualizacion = DateTime.now();

      await pago.deuda.load();
      final deuda = pago.deuda.value;
      if (deuda != null) {
        deudas.add(pago.deuda.value!.id);
      }
    }

    await _repository.guardarTodos(pagos);

    for (final deudaId in deudas) {
      await recalcularDeuda(deudaId);
    }
  }

  Future<void> eliminarFisicamenteTodo() async {
    await _repository.limpiar();
  }

  //==========================================================
  // UTILIDADES
  //==========================================================

  Future<bool> existePorUuid(String uuid) async {
    return await _repository.obtenerPorUuid(uuid) != null;
  }

  Future<bool> tieneReferencia(String referencia) async {
    final pagos = await buscar(referencia);

    return pagos.any(
      (p) =>
          (p.referencia ?? '').trim().toLowerCase() ==
          referencia.trim().toLowerCase(),
    );
  }

  Future<Pago> duplicar(int pagoId) async {
    final original = await obtenerPorId(pagoId);

    await original.deuda.load();
    await original.interes.load();
    await original.cuotas.load();

    final deuda = original.deuda.value;

    if (deuda == null) {
      throw const PagoException('La deuda asociada al pago no existe.');
    }
    if (deuda.archivada) {
      throw const PagoException(
        'No es posible duplicar un pago de una deuda archivada.',
      );
    }

    final nuevo = Pago()
      ..deuda.value = deuda
      ..valor = original.valor
      ..fechaPago = DateTime.now()
      ..metodoPago = original.metodoPago
      ..tipoPago = original.tipoPago
      ..referencia = original.referencia
      ..observacion = original.observacion
      ..eliminado = false
      ..fechaRegistro = DateTime.now()
      ..fechaActualizacion = null;
    // ==========================================================
    // DEUDA PROGRAMADA CON CUOTAS
    // ==========================================================
    //
    // En este tipo de deuda el pago representa una reducción
    // de la obligación total.
    //
    // Por tanto, no se valida contra capital pendiente ni
    // contra un período de interés.
    //
    if (deuda.programada && deuda.tieneCuotas) {
      await _deudaService.recalcular(deuda);

      if (deuda.saldoPendiente <= 0) {
        throw const PagoException(
          'La deuda ya se encuentra completamente pagada.',
        );
      }

      if (nuevo.valor > deuda.saldoPendiente) {
        throw const PagoException(
          'El valor del pago supera el saldo pendiente de la deuda.',
        );
      }

      final cuotasOriginales = original.cuotas.toList();

      if (cuotasOriginales.isEmpty) {
        throw const PagoException(
          'El pago original no tiene cuotas asociadas.',
        );
      }

      await _validarCuotasPago(deuda, cuotasOriginales, nuevo.valor);

      nuevo.tipoPago = TipoPago.capital;
      nuevo.interes.value = null;

      nuevo.cuotas
        ..clear()
        ..addAll(cuotasOriginales);
    }
    // Si es un pago de interés, conservamos el período.
    else if (original.tipoPago == TipoPago.interes) {
      final interes = original.interes.value;

      if (interes != null) {
        await _actualizarInteresDesdePagos(interes);

        if (interes.pagado || interes.saldoPendiente <= 0) {
          throw const PagoException(
            'El interés asociado ya se encuentra completamente pagado.',
          );
        }

        if (nuevo.valor > interes.saldoPendiente) {
          throw const PagoException(
            'El valor del pago supera el interés pendiente.',
          );
        }

        nuevo.interes.value = interes;
        nuevo.cuotas.clear();
      } else {
        throw const PagoException(
          'El pago original no tiene un período de interés asociado.',
        );
      }
    }
    // Si es capital, validamos el capital pendiente.
    else if (original.tipoPago == TipoPago.capital) {
      final capitalPagado = await _obtenerCapitalPagado(
        deuda.id,
        excluirPagoId: original.id,
      );

      final capitalPendiente = deuda.capital - capitalPagado;

      if (nuevo.valor > capitalPendiente) {
        throw const PagoException(
          'El valor del pago supera el capital pendiente.',
        );
      }

      if (deuda.tieneCuotas) {
        final cuotasOriginales = original.cuotas.toList();

        if (cuotasOriginales.isEmpty) {
          throw const PagoException(
            'El pago original no tiene cuotas asociadas.',
          );
        }

        await _validarCuotasPago(deuda, cuotasOriginales, nuevo.valor);

        nuevo.cuotas
          ..clear()
          ..addAll(cuotasOriginales);
      } else {
        nuevo.cuotas.clear();
      }

      nuevo.interes.value = null;
    } else {
      throw const PagoException(
        'El tipo de pago del registro original no es válido.',
      );
    }

    await _repository.guardar(nuevo);

    if (nuevo.tipoPago == TipoPago.interes) {
      final interes = nuevo.interes.value;

      if (interes != null) {
        await _actualizarInteresDesdePagos(interes);
      }
    }

    if (deuda.tieneCuotas) {
      await _actualizarCuotasDesdePagos(deuda);
    }

    await _deudaService.recalcular(deuda);
    await _deudaService.actualizarEstado(deuda);

    return nuevo;
  }

  Future<void> actualizarMetodoPago(int pagoId, MetodoPago metodo) async {
    final pago = await obtenerPorId(pagoId);

    pago.metodoPago = metodo;
    pago.fechaActualizacion = DateTime.now();

    await _repository.guardar(pago);
  }

  Future<void> actualizarReferencia(int pagoId, String? referencia) async {
    final pago = await obtenerPorId(pagoId);

    pago.referencia = referencia?.trim();
    pago.fechaActualizacion = DateTime.now();

    await _repository.guardar(pago);
  }

  Future<void> actualizarObservacion(int pagoId, String? observacion) async {
    final pago = await obtenerPorId(pagoId);

    pago.observacion = observacion?.trim();
    pago.fechaActualizacion = DateTime.now();

    await _repository.guardar(pago);
  }

  Future<double> _obtenerCapitalPagado(
    int deudaId, {
    int? excluirPagoId,
  }) async {
    final pagos = await _repository.obtenerPorDeuda(deudaId);

    return pagos
        .where(
          (pago) =>
              !pago.eliminado &&
              pago.tipoPago == TipoPago.capital &&
              (excluirPagoId == null || pago.id != excluirPagoId),
        )
        .fold<double>(0, (total, pago) => total + pago.valor);
  }

  Future<void> _actualizarInteresDesdePagos(
    InteresDeuda interes, {
    int? excluirPagoId,
  }) async {
    await interes.pagos.load();

    final pagosActivos = interes.pagos.where(
      (pago) =>
          !pago.eliminado &&
          pago.tipoPago == TipoPago.interes &&
          (excluirPagoId == null || pago.id != excluirPagoId),
    );

    final totalPagado = pagosActivos.fold<double>(
      0,
      (total, pago) => total + pago.valor,
    );

    interes.valorPagado = totalPagado;

    if (interes.valorPagado > interes.valor) {
      interes.valorPagado = interes.valor;
    }

    interes.pagado = interes.saldoPendiente <= 0;

    if (interes.pagado) {
      interes.fechaPago = pagosActivos.isEmpty
          ? DateTime.now()
          : pagosActivos
                .map((pago) => pago.fechaPago)
                .reduce((a, b) => a.isAfter(b) ? a : b);
    } else {
      interes.fechaPago = null;
    }

    interes.fechaActualizacion = DateTime.now();

    await _interesRepository.guardar(interes);
  }
}
