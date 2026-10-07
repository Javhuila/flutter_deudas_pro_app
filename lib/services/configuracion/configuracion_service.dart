import '../../core/enums/frecuencia_backup.dart';
import '../../models/configuracion.dart';
import '../../repositories/configuracion_repository.dart';

class ConfiguracionService {
  ConfiguracionService(this._repository);

  final ConfiguracionRepository _repository;

  //==========================================================
  // CONSULTAS
  //==========================================================

  Future<Configuracion> obtener() {
    return _repository.obtener();
  }

  Future<bool> existe() {
    return _repository.existe();
  }

  //==========================================================
  // CRUD
  //==========================================================

  Future<void> guardar(Configuracion configuracion) async {
    await _repository.guardar(configuracion);
  }

  Future<void> restaurarValores() async {
    await _repository.restaurarValores();
  }

  //==========================================================
  // TEMA
  //==========================================================

  Future<void> cambiarTemaOscuro(bool activar) async {
    await _repository.actualizarTemaOscuro(activar);
  }

  Future<bool> esTemaOscuro() async {
    final configuracion = await obtener();

    return configuracion.temaOscuro;
  }

  //==========================================================
  // NUMERACIÓN
  //==========================================================

  /// Obtiene y reserva el siguiente número consecutivo de deuda.
  Future<int> reservarNumeroDeuda() {
    return _repository.reservarNumeroDeuda();
  }

  /// Obtiene y reserva el siguiente número consecutivo de pago.
  Future<int> reservarNumeroPago() {
    return _repository.reservarNumeroPago();
  }

  //==========================================================
  // PRIMERA EJECUCIÓN
  //==========================================================

  Future<bool> esPrimeraEjecucion() async {
    final configuracion = await obtener();

    return configuracion.primeraEjecucion;
  }

  Future<void> finalizarPrimeraEjecucion() async {
    await _repository.actualizarPrimeraEjecucion(false);
  }

  Future<void> reiniciarPrimeraEjecucion() async {
    await _repository.actualizarPrimeraEjecucion(true);
  }

  //==========================================================
  // UTILIDADES
  //==========================================================

  Future<void> actualizar(
    Future<void> Function(Configuracion configuracion) accion,
  ) async {
    await _repository.actualizar(accion);
  }

  //==========================================================
  // NOTIFICACIONES
  //==========================================================

  Future<void> activarNotificaciones() async {
    await _repository.actualizarNotificaciones(true);
  }

  Future<void> desactivarNotificaciones() async {
    await _repository.actualizarNotificaciones(false);
  }

  Future<void> cambiarEstadoNotificaciones(bool activar) async {
    await _repository.actualizarNotificaciones(activar);
  }

  Future<bool> notificacionesActivas() async {
    final configuracion = await obtener();

    return configuracion.notificacionesActivas;
  }

  Future<void> actualizarHoraNotificacion(int hora, int minuto) async {
    if (hora < 0 || hora > 23) {
      throw ArgumentError('Hora inválida.');
    }

    if (minuto < 0 || minuto > 59) {
      throw ArgumentError('Minuto inválido.');
    }

    await _repository.actualizarHoraNotificacion(hora, minuto);
  }

  Future<(int hora, int minuto)> obtenerHoraNotificacion() async {
    final configuracion = await obtener();

    return (configuracion.horaNotificacion, configuracion.minutoNotificacion);
  }

  Future<void> actualizarDiasAnticipacion(int dias) async {
    if (dias < 0) {
      dias = 0;
    }

    await _repository.actualizarDiasAnticipacion(dias);
  }

  Future<int> obtenerDiasAnticipacion() async {
    final configuracion = await obtener();

    return configuracion.diasAnticipacion;
  }

  Future<void> activarAvisoDeudasVencidas() async {
    await _repository.actualizarNotificarDeudasVencidas(true);
  }

  Future<void> desactivarAvisoDeudasVencidas() async {
    await _repository.actualizarNotificarDeudasVencidas(false);
  }

  Future<void> activarAvisoPagosPendientes() async {
    await _repository.actualizarNotificarPagosPendientes(true);
  }

  Future<void> desactivarAvisoPagosPendientes() async {
    await _repository.actualizarNotificarPagosPendientes(false);
  }

  //==========================================================
  // BACKUP
  //==========================================================

  Future<void> activarBackupAutomatico() async {
    await _repository.actualizarBackupAutomatico(true);
  }

  Future<void> desactivarBackupAutomatico() async {
    await _repository.actualizarBackupAutomatico(false);
  }

  Future<void> cambiarBackupAutomatico(bool activar) async {
    await _repository.actualizarBackupAutomatico(activar);
  }

  Future<bool> backupAutomaticoActivo() async {
    final configuracion = await obtener();

    return configuracion.backupAutomatico;
  }

  Future<void> cambiarFrecuenciaBackup(FrecuenciaBackup frecuencia) async {
    await _repository.actualizarFrecuenciaBackup(frecuencia);
  }

  Future<FrecuenciaBackup> obtenerFrecuenciaBackup() async {
    final configuracion = await obtener();

    return configuracion.frecuenciaBackup;
  }

  Future<void> actualizarHoraBackup(int hora, int minuto) async {
    if (hora < 0 || hora > 23) {
      throw ArgumentError('Hora inválida.');
    }

    if (minuto < 0 || minuto > 59) {
      throw ArgumentError('Minuto inválido.');
    }

    await _repository.actualizarHoraBackup(hora, minuto);
  }

  Future<void> actualizarCarpetaBackup(
    String? carpeta,
    String? carpetaUri,
  ) async {
    await _repository.actualizarCarpetaBackup(carpeta, carpetaUri);
  }

  Future<void> actualizarMaximoBackups(int cantidad) async {
    if (cantidad < 1) {
      cantidad = 1;
    }

    await _repository.actualizarMaximoBackups(cantidad);
  }

  Future<void> registrarUltimoBackup() async {
    await _repository.actualizarUltimoBackup(DateTime.now());
  }

  //==========================================================
  // EXPORTACIONES
  //==========================================================

  Future<void> activarExportarPdf() async {
    await _repository.actualizarExportarPdf(true);
  }

  Future<void> desactivarExportarPdf() async {
    await _repository.actualizarExportarPdf(false);
  }

  Future<void> activarExportarExcel() async {
    await _repository.actualizarExportarExcel(true);
  }

  Future<void> desactivarExportarExcel() async {
    await _repository.actualizarExportarExcel(false);
  }

  Future<bool> exportarPdfActivo() async {
    final configuracion = await obtener();

    return configuracion.exportarPdf;
  }

  Future<bool> exportarExcelActivo() async {
    final configuracion = await obtener();

    return configuracion.exportarExcel;
  }

  //==========================================================
  // RESÚMENES
  //==========================================================

  Future<bool> backupConfigurado() async {
    final configuracion = await obtener();

    return configuracion.carpetaBackup != null &&
        configuracion.carpetaBackup!.trim().isNotEmpty;
  }

  Future<bool> existeUltimoBackup() async {
    final configuracion = await obtener();

    return configuracion.ultimoBackup != null;
  }

  Future<DateTime?> obtenerUltimoBackup() async {
    final configuracion = await obtener();

    return configuracion.ultimoBackup;
  }

  //==========================================================
  // UTILIDADES
  //==========================================================

  Future<void> reiniciarConfiguracion() async {
    await restaurarValores();
  }

  Future<void> guardarConfiguracion(Configuracion configuracion) async {
    await guardar(configuracion);
  }
}
