import '../../models/cliente.dart';
import '../../models/deuda.dart';

class DeudaSummary {
  /// Deuda asociada al resumen.
  final Deuda deuda;

  /// Cliente propietario de la deuda.
  final Cliente cliente;

  /// Capital prestado.
  final double capital;

  /// Porcentaje de interés aplicado.
  final double porcentajeInteres;

  /// Valor del interés generado.
  final double interesCalculado;

  /// Valor total de la deuda.
  final double total;

  /// Valor total abonado.
  final double totalPagado;

  /// Saldo restante.
  final double saldoPendiente;

  /// Cantidad de pagos realizados.
  final int cantidadPagos;

  /// Fecha del préstamo.
  final DateTime fechaPrestamo;

  /// Fecha de vencimiento.
  final DateTime? fechaVencimiento;

  /// Fecha del último pago.
  final DateTime? ultimoPago;

  /// Días transcurridos desde el préstamo.
  final int diasTranscurridos;

  /// Días restantes para el vencimiento.
  final int diasRestantes;

  /// Indica si la deuda está vencida.
  final bool vencida;

  /// Indica si la deuda está completamente pagada.
  final bool pagada;

  /// Indica si aún posee saldo pendiente.
  final bool pendiente;

  /// Indica si fue archivada.
  final bool archivada;

  const DeudaSummary({
    required this.deuda,
    required this.cliente,
    required this.capital,
    required this.porcentajeInteres,
    required this.interesCalculado,
    required this.total,
    required this.totalPagado,
    required this.saldoPendiente,
    required this.cantidadPagos,
    required this.fechaPrestamo,
    this.fechaVencimiento,
    this.ultimoPago,
    required this.diasTranscurridos,
    required this.diasRestantes,
    required this.vencida,
    required this.pagada,
    required this.pendiente,
    required this.archivada,
  });

  ///==========================================================
  /// GETTERS
  ///==========================================================

  /// Porcentaje cancelado de la deuda.
  double get porcentajePagado {
    if (total <= 0) return 0;

    return (totalPagado / total) * 100;
  }

  /// Porcentaje pendiente.
  double get porcentajePendiente {
    if (total <= 0) return 0;

    return (saldoPendiente / total) * 100;
  }

  /// ¿Tiene pagos registrados?
  bool get tienePagos => cantidadPagos > 0;

  /// ¿Está próxima a vencer?
  bool get proximaAVencer {
    if (fechaVencimiento == null) return false;

    return !vencida && diasRestantes >= 0 && diasRestantes <= 3;
  }

  /// ¿Puede archivarse?
  bool get puedeArchivarse => pagada && !archivada;

  /// ¿Puede eliminarse?
  bool get puedeEliminar => cantidadPagos == 0;

  ///==========================================================
  /// COPY WITH
  ///==========================================================

  DeudaSummary copyWith({
    Deuda? deuda,
    Cliente? cliente,
    double? capital,
    double? porcentajeInteres,
    double? interesCalculado,
    double? total,
    double? totalPagado,
    double? saldoPendiente,
    int? cantidadPagos,
    DateTime? fechaPrestamo,
    DateTime? fechaVencimiento,
    DateTime? ultimoPago,
    int? diasTranscurridos,
    int? diasRestantes,
    bool? vencida,
    bool? pagada,
    bool? pendiente,
    bool? archivada,
  }) {
    return DeudaSummary(
      deuda: deuda ?? this.deuda,
      cliente: cliente ?? this.cliente,
      capital: capital ?? this.capital,
      porcentajeInteres: porcentajeInteres ?? this.porcentajeInteres,
      interesCalculado: interesCalculado ?? this.interesCalculado,
      total: total ?? this.total,
      totalPagado: totalPagado ?? this.totalPagado,
      saldoPendiente: saldoPendiente ?? this.saldoPendiente,
      cantidadPagos: cantidadPagos ?? this.cantidadPagos,
      fechaPrestamo: fechaPrestamo ?? this.fechaPrestamo,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      ultimoPago: ultimoPago ?? this.ultimoPago,
      diasTranscurridos: diasTranscurridos ?? this.diasTranscurridos,
      diasRestantes: diasRestantes ?? this.diasRestantes,
      vencida: vencida ?? this.vencida,
      pagada: pagada ?? this.pagada,
      pendiente: pendiente ?? this.pendiente,
      archivada: archivada ?? this.archivada,
    );
  }
}
