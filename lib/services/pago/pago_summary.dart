import '../../core/enums/estado_deuda.dart';
import '../../core/enums/metodo_pago.dart';
import '../../models/deuda.dart';
import '../../models/pago.dart';

class PagoSummary {
  const PagoSummary({
    required this.pago,
    required this.deuda,
    required this.valor,
    required this.fechaPago,
    required this.metodoPago,
    required this.referencia,
    required this.observacion,
    required this.eliminado,
    required this.fechaRegistro,
    required this.fechaActualizacion,
    required this.capitalDeuda,
    required this.totalDeuda,
    required this.totalPagado,
    required this.saldoPendiente,
    required this.estadoDeuda,
  });

  /// Pago
  final Pago pago;

  /// Deuda asociada
  final Deuda deuda;

  /// Información del pago
  final double valor;

  final DateTime fechaPago;

  final MetodoPago metodoPago;

  final String? referencia;

  final String? observacion;

  final bool eliminado;

  final DateTime fechaRegistro;

  final DateTime? fechaActualizacion;

  /// Información de la deuda al momento de consultar
  final double capitalDeuda;

  final double totalDeuda;

  final double totalPagado;

  final double saldoPendiente;

  final EstadoDeuda estadoDeuda;

  /// Utilidades

  bool get estaEliminado => eliminado;

  bool get deudaPagada => estadoDeuda == EstadoDeuda.pagada;

  bool get deudaPendiente => estadoDeuda == EstadoDeuda.pendiente;

  bool get deudaVencida => estadoDeuda == EstadoDeuda.vencida;
}
