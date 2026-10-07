import '../../models/cliente.dart';

class ClienteSummary {
  final Cliente cliente;

  /// Cantidad total de deudas registradas
  final int cantidadDeudas;

  /// Deudas pendientes
  final int deudasPendientes;

  /// Deudas pagadas
  final int deudasPagadas;

  /// Deudas vencidas
  final int deudasVencidas;

  /// Capital prestado
  final double totalPrestado;

  /// Total pagado por el cliente
  final double totalPagado;

  /// Saldo pendiente
  final double saldoPendiente;

  /// Intereses generados
  final double totalIntereses;

  /// Fecha del último préstamo
  final DateTime? ultimoPrestamo;

  /// Fecha del último pago
  final DateTime? ultimoPago;

  const ClienteSummary({
    required this.cliente,
    this.cantidadDeudas = 0,
    this.deudasPendientes = 0,
    this.deudasPagadas = 0,
    this.deudasVencidas = 0,
    this.totalPrestado = 0,
    this.totalPagado = 0,
    this.saldoPendiente = 0,
    this.totalIntereses = 0,
    this.ultimoPrestamo,
    this.ultimoPago,
  });

  bool get tieneDeudas => cantidadDeudas > 0;

  bool get tieneSaldoPendiente => saldoPendiente > 0;

  bool get estaAlDia => saldoPendiente <= 0 && deudasVencidas == 0;
}
