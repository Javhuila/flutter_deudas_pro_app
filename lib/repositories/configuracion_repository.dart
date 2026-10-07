import 'package:isar/isar.dart';

import '../core/enums/frecuencia_backup.dart';
import '../models/configuracion.dart';

class ConfiguracionRepository {
  final Isar isar;

  ConfiguracionRepository(this.isar);

  Future<Configuracion> obtener() async {
    final configuracion = await isar.configuracions.get(1);

    if (configuracion != null) {
      return configuracion;
    }

    final nueva = Configuracion();
    await guardar(nueva);

    return nueva;
  }

  Future<bool> existe() async {
    return await isar.configuracions.get(1) != null;
  }

  Future<void> guardar(Configuracion configuracion) async {
    configuracion.fechaActualizacion = DateTime.now();

    await isar.writeTxn(() async {
      await isar.configuracions.put(configuracion);
    });
  }

  Future<void> restaurarValores() async {
    final configuracion = Configuracion();
    await guardar(configuracion);
  }

  //==========================================================
  // NUMERACIÓN
  //==========================================================

  /// Reserva el siguiente número consecutivo para una deuda.
  ///
  /// La lectura, incremento y persistencia se realizan dentro
  /// de una misma transacción de Isar.
  ///
  /// El número reservado no se reutiliza aunque posteriormente
  /// la deuda sea eliminada.
  Future<int> reservarNumeroDeuda() async {
    return isar.writeTxn(() async {
      var configuracion = await isar.configuracions.get(1);

      if (configuracion == null) {
        configuracion = Configuracion();
      }

      var numero = configuracion.siguienteNumeroDeuda;

      if (numero < 1) {
        numero = 1;
      }

      configuracion.siguienteNumeroDeuda = numero + 1;
      configuracion.fechaActualizacion = DateTime.now();

      await isar.configuracions.put(configuracion);

      return numero;
    });
  }

  /// Reserva el siguiente número consecutivo para un pago.
  ///
  /// La lectura, incremento y persistencia se realizan dentro
  /// de una misma transacción de Isar.
  ///
  /// El número reservado no se reutiliza aunque posteriormente
  /// el pago sea eliminado.
  Future<int> reservarNumeroPago() async {
    return isar.writeTxn(() async {
      var configuracion = await isar.configuracions.get(1);

      if (configuracion == null) {
        configuracion = Configuracion();
      }

      var numero = configuracion.siguienteNumeroPago;

      if (numero < 1) {
        numero = 1;
      }

      configuracion.siguienteNumeroPago = numero + 1;
      configuracion.fechaActualizacion = DateTime.now();

      await isar.configuracions.put(configuracion);

      return numero;
    });
  }

  //==========================================================
  // ACTUALIZACIONES
  //==========================================================
  Future<void> actualizarTemaOscuro(bool valor) async {
    final configuracion = await obtener();

    configuracion.temaOscuro = valor;

    await guardar(configuracion);
  }

  Future<void> actualizarPrimeraEjecucion(bool valor) async {
    final configuracion = await obtener();

    configuracion.primeraEjecucion = valor;

    await guardar(configuracion);
  }

  //==========================================================
  // NOTIFICACIONES
  //==========================================================

  Future<void> actualizarNotificaciones(bool valor) async {
    final configuracion = await obtener();

    configuracion.notificacionesActivas = valor;

    await guardar(configuracion);
  }

  Future<void> actualizarHoraNotificacion(int hora, int minuto) async {
    final configuracion = await obtener();

    configuracion.horaNotificacion = hora;
    configuracion.minutoNotificacion = minuto;

    await guardar(configuracion);
  }

  Future<void> actualizarDiasAnticipacion(int dias) async {
    final configuracion = await obtener();

    configuracion.diasAnticipacion = dias;

    await guardar(configuracion);
  }

  Future<void> actualizarNotificarDeudasVencidas(bool valor) async {
    final configuracion = await obtener();

    configuracion.notificarDeudasVencidas = valor;

    await guardar(configuracion);
  }

  Future<void> actualizarNotificarPagosPendientes(bool valor) async {
    final configuracion = await obtener();

    configuracion.notificarPagosPendientes = valor;

    await guardar(configuracion);
  }

  //==========================================================
  // BACKUP
  //==========================================================

  Future<void> actualizarBackupAutomatico(bool valor) async {
    final configuracion = await obtener();

    configuracion.backupAutomatico = valor;

    await guardar(configuracion);
  }

  Future<void> actualizarFrecuenciaBackup(FrecuenciaBackup frecuencia) async {
    final configuracion = await obtener();

    configuracion.frecuenciaBackup = frecuencia;

    await guardar(configuracion);
  }

  Future<void> actualizarHoraBackup(int hora, int minuto) async {
    final configuracion = await obtener();

    configuracion.horaBackup = hora;
    configuracion.minutoBackup = minuto;

    await guardar(configuracion);
  }

  Future<void> actualizarCarpetaBackup(
    String? carpeta,
    String? carpetaUri,
  ) async {
    final configuracion = await obtener();

    configuracion.carpetaBackup = carpeta;
    configuracion.carpetaBackupUri = carpetaUri;

    await guardar(configuracion);
  }

  Future<void> actualizarMaximoBackups(int cantidad) async {
    final configuracion = await obtener();

    configuracion.maximoBackups = cantidad;

    await guardar(configuracion);
  }

  Future<void> actualizarUltimoBackup(DateTime fecha) async {
    final configuracion = await obtener();

    configuracion.ultimoBackup = fecha;

    await guardar(configuracion);
  }

  //==========================================================
  // EXPORTACIÓN
  //==========================================================

  Future<void> actualizarExportarPdf(bool valor) async {
    final configuracion = await obtener();

    configuracion.exportarPdf = valor;

    await guardar(configuracion);
  }

  Future<void> actualizarExportarExcel(bool valor) async {
    final configuracion = await obtener();

    configuracion.exportarExcel = valor;

    await guardar(configuracion);
  }

  //==========================================================
  // UTILIDADES
  //==========================================================

  Future<void> actualizar(
    Future<void> Function(Configuracion configuracion) accion,
  ) async {
    final configuracion = await obtener();

    await accion(configuracion);

    await guardar(configuracion);
  }
}
