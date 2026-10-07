class DashboardSummary {
  const DashboardSummary({
    required this.totalClientes,
    required this.totalDeudas,
    required this.deudasPendientes,
    required this.deudasPagadas,
  });

  final int totalClientes;
  final int totalDeudas;
  final int deudasPendientes;
  final int deudasPagadas;

  factory DashboardSummary.empty() {
    return const DashboardSummary(
      totalClientes: 0,
      totalDeudas: 0,
      deudasPendientes: 0,
      deudasPagadas: 0,
    );
  }

  DashboardSummary copyWith({
    int? totalClientes,
    int? totalDeudas,
    int? deudasPendientes,
    int? deudasPagadas,
  }) {
    return DashboardSummary(
      totalClientes: totalClientes ?? this.totalClientes,
      totalDeudas: totalDeudas ?? this.totalDeudas,
      deudasPendientes: deudasPendientes ?? this.deudasPendientes,
      deudasPagadas: deudasPagadas ?? this.deudasPagadas,
    );
  }
}
