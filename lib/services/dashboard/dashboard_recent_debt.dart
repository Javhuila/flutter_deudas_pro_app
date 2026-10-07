import '../../core/enums/estado_deuda.dart';

class DashboardRecentDebt {
  const DashboardRecentDebt({
    required this.id,
    required this.uuid,
    required this.nombreCliente,
    required this.capital,
    required this.total,
    required this.saldoPendiente,
    required this.fechaPrestamo,
    this.fechaVencimiento,
    required this.estado,
  });

  final int id;

  final String uuid;

  final String nombreCliente;

  final double capital;

  final double total;

  final double saldoPendiente;

  final DateTime fechaPrestamo;

  final DateTime? fechaVencimiento;

  final EstadoDeuda estado;

  factory DashboardRecentDebt.empty() {
    return DashboardRecentDebt(
      id: 0,
      uuid: '',
      nombreCliente: '',
      capital: 0,
      total: 0,
      saldoPendiente: 0,
      fechaPrestamo: DateTime.now(),
      fechaVencimiento: null,
      estado: EstadoDeuda.pendiente,
    );
  }

  DashboardRecentDebt copyWith({
    int? id,
    String? uuid,
    String? nombreCliente,
    double? capital,
    double? total,
    double? saldoPendiente,
    DateTime? fechaPrestamo,
    DateTime? fechaVencimiento,
    EstadoDeuda? estado,
  }) {
    return DashboardRecentDebt(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      nombreCliente: nombreCliente ?? this.nombreCliente,
      capital: capital ?? this.capital,
      total: total ?? this.total,
      saldoPendiente: saldoPendiente ?? this.saldoPendiente,
      fechaPrestamo: fechaPrestamo ?? this.fechaPrestamo,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      estado: estado ?? this.estado,
    );
  }
}
