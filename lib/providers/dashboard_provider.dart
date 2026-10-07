import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/dashboard/dashboard_backup_summary.dart';
import '../services/dashboard/dashboard_recent_debt.dart';
import '../services/dashboard/dashboard_service.dart';

import '../services/dashboard/dashboard_statistics_data.dart';
import '../services/dashboard/dashboard_summary.dart';

import 'cliente_provider.dart';
import 'deuda_provider.dart';
import 'pago_provider.dart';
import 'respaldo_provider.dart';

//==========================================================
// SERVICE
//==========================================================

final dashboardServiceProvider = Provider<DashboardService>((ref) {
  return DashboardService(
    clienteService: ref.watch(clienteServiceProvider),
    deudaService: ref.watch(deudaServiceProvider),
    pagoService: ref.watch(pagoServiceProvider),
    respaldoService: ref.watch(respaldoServiceProvider),
  );
});

//==========================================================
// RESUMEN
//==========================================================

final dashboardSummaryProvider = FutureProvider<DashboardSummary>((ref) async {
  final service = ref.watch(dashboardServiceProvider);

  return service.obtenerResumen();
});

//==========================================================
// ESTADÍSTICAS
//==========================================================

final dashboardStatisticsProvider = FutureProvider<DashboardStatisticsData>((
  ref,
) async {
  final service = ref.watch(dashboardServiceProvider);

  return service.obtenerEstadisticas();
});

//==========================================================
// ÚLTIMAS DEUDAS
//==========================================================

final dashboardRecentDebtsProvider = FutureProvider<List<DashboardRecentDebt>>((
  ref,
) async {
  final service = ref.watch(dashboardServiceProvider);

  return service.obtenerUltimasDeudas();
});

//==========================================================
// ÚLTIMO RESPALDO
//==========================================================

final dashboardBackupProvider = FutureProvider<DashboardBackupSummary>((
  ref,
) async {
  final service = ref.watch(dashboardServiceProvider);

  return service.obtenerUltimoRespaldo();
});

//==========================================================
// REFRESH
//==========================================================

final dashboardRefreshProvider = FutureProvider<void>((ref) async {
  ref.invalidate(dashboardSummaryProvider);
  ref.invalidate(dashboardStatisticsProvider);
  ref.invalidate(dashboardRecentDebtsProvider);
  ref.invalidate(dashboardBackupProvider);

  await Future.wait([
    ref.read(dashboardSummaryProvider.future),
    ref.read(dashboardStatisticsProvider.future),
    ref.read(dashboardRecentDebtsProvider.future),
    ref.read(dashboardBackupProvider.future),
  ]);
});
