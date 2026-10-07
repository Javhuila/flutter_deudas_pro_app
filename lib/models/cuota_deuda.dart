import 'package:isar/isar.dart';

import '../core/enums/estado_cuota.dart';
import '../core/utils/uuid_helper.dart';
import 'deuda.dart';
import 'pago.dart';

part 'cuota_deuda.g.dart';

@collection
class CuotaDeuda {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  final deuda = IsarLink<Deuda>();

  @Backlink(to: 'cuotas')
  final pagos = IsarLinks<Pago>();

  int numeroCuota = 0;

  double valor = 0;

  double valorPagado = 0;

  @Enumerated(EnumType.name)
  EstadoCuota estado = EstadoCuota.pendiente;

  DateTime? fechaPago;

  DateTime fechaRegistro = DateTime.now();

  DateTime? fechaActualizacion;

  CuotaDeuda() {
    uuid = UuidHelper.generate();
  }

  double get saldoPendiente => (valor - valorPagado).clamp(0, double.infinity);
}
