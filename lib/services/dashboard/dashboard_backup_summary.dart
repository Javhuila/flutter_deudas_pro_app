import '../../core/enums/estado_respaldo.dart';
import '../../core/enums/tipo_respaldo.dart';

class DashboardBackupSummary {
  const DashboardBackupSummary({
    required this.existeRespaldo,
    required this.id,
    required this.uuid,
    required this.tipo,
    required this.estado,
    required this.fecha,
    required this.nombreArchivo,
    required this.rutaArchivo,
    required this.tamanoBytes,
    required this.versionAplicacion,
    required this.cantidadClientes,
    required this.cantidadDeudas,
    required this.cantidadPagos,
    required this.duracionMs,
    this.observacion,
  });

  final bool existeRespaldo;
  final int id;
  final String uuid;
  final TipoRespaldo tipo;
  final EstadoRespaldo estado;
  final DateTime? fecha;
  final String nombreArchivo;
  final String rutaArchivo;
  final int tamanoBytes;
  final String versionAplicacion;
  final int cantidadClientes;
  final int cantidadDeudas;
  final int cantidadPagos;
  final int duracionMs;
  final String? observacion;

  factory DashboardBackupSummary.empty() {
    return DashboardBackupSummary(
      existeRespaldo: false,
      id: 0,
      uuid: '',
      tipo: TipoRespaldo.manual,
      estado: EstadoRespaldo.exitoso,
      fecha: null,
      nombreArchivo: '',
      rutaArchivo: '',
      tamanoBytes: 0,
      versionAplicacion: '',
      cantidadClientes: 0,
      cantidadDeudas: 0,
      cantidadPagos: 0,
      duracionMs: 0,
      observacion: null,
    );
  }

  DashboardBackupSummary copyWith({
    bool? existeRespaldo,
    int? id,
    String? uuid,
    TipoRespaldo? tipo,
    EstadoRespaldo? estado,
    DateTime? fecha,
    String? nombreArchivo,
    String? rutaArchivo,
    int? tamanoBytes,
    String? versionAplicacion,
    int? cantidadClientes,
    int? cantidadDeudas,
    int? cantidadPagos,
    int? duracionMs,
    String? observacion,
  }) {
    return DashboardBackupSummary(
      existeRespaldo: existeRespaldo ?? this.existeRespaldo,
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      tipo: tipo ?? this.tipo,
      estado: estado ?? this.estado,
      fecha: fecha ?? this.fecha,
      nombreArchivo: nombreArchivo ?? this.nombreArchivo,
      rutaArchivo: rutaArchivo ?? this.rutaArchivo,
      tamanoBytes: tamanoBytes ?? this.tamanoBytes,
      versionAplicacion: versionAplicacion ?? this.versionAplicacion,
      cantidadClientes: cantidadClientes ?? this.cantidadClientes,
      cantidadDeudas: cantidadDeudas ?? this.cantidadDeudas,
      cantidadPagos: cantidadPagos ?? this.cantidadPagos,
      duracionMs: duracionMs ?? this.duracionMs,
      observacion: observacion ?? this.observacion,
    );
  }
}
