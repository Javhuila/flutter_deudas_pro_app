import 'package:flutter_deudas_pro_app/core/utils/uuid_helper.dart';
import 'package:isar/isar.dart';

import '../core/enums/metodo_pago.dart';
import '../core/enums/tipo_pago.dart';
import 'cuota_deuda.dart';
import 'deuda.dart';
import 'interes_deuda.dart';

part 'pago.g.dart';

@collection
class Pago {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  final deuda = IsarLink<Deuda>();

  int numeroPago = 0;

  final interes = IsarLink<InteresDeuda>();
  final cuotas = IsarLinks<CuotaDeuda>();
  double valor = 0;

  DateTime fechaPago = DateTime.now();

  @Enumerated(EnumType.name)
  MetodoPago metodoPago = MetodoPago.efectivo;

  @Enumerated(EnumType.name)
  TipoPago tipoPago = TipoPago.capital;

  String? observacion;

  String? referencia;

  DateTime fechaRegistro = DateTime.now();
  DateTime? fechaActualizacion;

  bool eliminado = false;

  Pago() {
    uuid = UuidHelper.generate();
  }
}
