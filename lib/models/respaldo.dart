import 'package:flutter_deudas_pro_app/core/utils/uuid_helper.dart';
import 'package:isar/isar.dart';

import '../core/enums/estado_respaldo.dart';
import '../core/enums/tipo_respaldo.dart';

part 'respaldo.g.dart';

@collection
class Respaldo {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Enumerated(EnumType.name)
  TipoRespaldo tipo = TipoRespaldo.manual;

  @Enumerated(EnumType.name)
  EstadoRespaldo estado = EstadoRespaldo.exitoso;

  DateTime fecha = DateTime.now();

  String nombreArchivo = '';

  String rutaArchivo = '';

  int tamanoBytes = 0;

  String versionAplicacion = '1.0.0';

  String? observacion;

  int cantidadClientes = 0;

  int cantidadDeudas = 0;

  int cantidadPagos = 0;

  int duracionMs = 0;

  Respaldo() {
    uuid = UuidHelper.generate();
  }
}
