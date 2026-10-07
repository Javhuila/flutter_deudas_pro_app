import 'package:isar/isar.dart';

import '../core/enums/frecuencia_backup.dart';

part 'configuracion.g.dart';

@collection
class Configuracion {
  Id id = 1;

  /// General
  bool temaOscuro = false;

  int siguienteNumeroDeuda = 1;
  int siguienteNumeroPago = 1;

  /// Notificaciones
  bool notificacionesActivas = true;

  int diasAnticipacion = 3;

  bool notificarDeudasVencidas = true;
  bool notificarPagosPendientes = true;

  int horaNotificacion = 8;
  int minutoNotificacion = 0;

  /// Copias de seguridad
  bool backupAutomatico = false;

  @Enumerated(EnumType.name)
  FrecuenciaBackup frecuenciaBackup = FrecuenciaBackup.semanal;

  int horaBackup = 22;
  int minutoBackup = 0;

  String? carpetaBackup;
  String? carpetaBackupUri;
  int maximoBackups = 10;

  DateTime? ultimoBackup;

  bool primeraEjecucion = true;

  /// Exportaciones
  bool exportarPdf = true;

  bool exportarExcel = true;

  /// Auditoría
  DateTime fechaCreacion = DateTime.now();

  DateTime fechaActualizacion = DateTime.now();
}
