import 'package:isar/isar.dart';

import '../core/utils/uuid_helper.dart';
import 'deuda.dart';
import 'pago.dart';

part 'interes_deuda.g.dart';

@collection
class InteresDeuda {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  final deuda = IsarLink<Deuda>();

  @Backlink(to: 'interes')
  final pagos = IsarLinks<Pago>();

  int numeroPeriodo = 0;

  DateTime fechaInicio = DateTime.now();
  DateTime fechaFin = DateTime.now();

  double porcentaje = 0;

  double valor = 0;
  double valorPagado = 0;
  bool pagado = false;

  DateTime? fechaPago;

  DateTime fechaRegistro = DateTime.now();

  DateTime? fechaActualizacion;

  double get saldoPendiente => (valor - valorPagado).clamp(0, double.infinity);

  InteresDeuda() {
    uuid = UuidHelper.generate();
  }
}
