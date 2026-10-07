import 'package:flutter_deudas_pro_app/models/pago.dart';
import 'package:isar/isar.dart';

import '../core/enums/estado_deuda.dart';
import '../core/utils/uuid_helper.dart';
import 'cliente.dart';
import 'cuota_deuda.dart';
import 'interes_deuda.dart';

part 'deuda.g.dart';

@collection
class Deuda {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  final cliente = IsarLink<Cliente>();

  @Backlink(to: 'deuda')
  final pagos = IsarLinks<Pago>();

  @Backlink(to: 'deuda')
  final intereses = IsarLinks<InteresDeuda>();

  @Backlink(to: 'deuda')
  final cuotas = IsarLinks<CuotaDeuda>();

  int numeroDeuda = 0;

  double capital = 0;
  double porcentajeInteres = 0;

  double interesCalculado = 0;

  double total = 0;

  double totalPagado = 0;
  bool programada = false;
  int mesesProgramados = 0;
  double saldoPendiente = 0;
  bool tieneCuotas = false;
  int numeroCuotas = 0;
  @Index()
  DateTime fechaPrestamo = DateTime.now();

  DateTime fechaRegistro = DateTime.now();
  DateTime? fechaActualizacion;
  DateTime? fechaVencimiento;
  String? observacion;
  bool archivada = false;

  @Enumerated(EnumType.name)
  EstadoDeuda estado = EstadoDeuda.pendiente;

  Deuda() {
    uuid = UuidHelper.generate();
  }
}
