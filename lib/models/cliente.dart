import 'package:isar/isar.dart';
import '../core/utils/uuid_helper.dart';
part 'cliente.g.dart';

@collection
class Cliente {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: false)
  late String uuid;

  @Index(caseSensitive: false)
  late String nombre;

  @Index(caseSensitive: false)
  String? telefono;

  String? direccion;

  String? observacion;

  bool activo = true;

  DateTime fechaRegistro = DateTime.now();
  DateTime? fechaActualizacion;
  Cliente() {
    uuid = UuidHelper.generate();
  }
}
