class DashboardStatisticsData {
  const DashboardStatisticsData({
    required this.totalPrestado,
    required this.totalRecuperado,
    required this.saldoPendiente,
    required this.interesesGenerados,
    required this.totalPagos,
    required this.promedioPrestamo,
  });

  final double totalPrestado;
  final double totalRecuperado;
  final double saldoPendiente;
  final double interesesGenerados;
  final int totalPagos;
  final double promedioPrestamo;

  factory DashboardStatisticsData.empty() {
    return const DashboardStatisticsData(
      totalPrestado: 0,
      totalRecuperado: 0,
      saldoPendiente: 0,
      interesesGenerados: 0,
      totalPagos: 0,
      promedioPrestamo: 0,
    );
  }

  DashboardStatisticsData copyWith({
    double? totalPrestado,
    double? totalRecuperado,
    double? saldoPendiente,
    double? interesesGenerados,
    int? totalPagos,
    double? promedioPrestamo,
  }) {
    return DashboardStatisticsData(
      totalPrestado: totalPrestado ?? this.totalPrestado,
      totalRecuperado: totalRecuperado ?? this.totalRecuperado,
      saldoPendiente: saldoPendiente ?? this.saldoPendiente,
      interesesGenerados: interesesGenerados ?? this.interesesGenerados,
      totalPagos: totalPagos ?? this.totalPagos,
      promedioPrestamo: promedioPrestamo ?? this.promedioPrestamo,
    );
  }
}
