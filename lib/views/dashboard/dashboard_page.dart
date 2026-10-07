import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/dashboard_provider.dart';
import 'widgets/dashboard_backup_card.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_quick_actions.dart';
import 'widgets/dashboard_recent_debts.dart';
import 'widgets/dashboard_resume.dart';
import 'widgets/dashboard_stats.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({
    super.key,
    this.onNuevoCliente,
    this.onNuevaDeuda,
    this.onRegistrarPago,
    this.onCrearRespaldo,
  });

  final VoidCallback? onNuevoCliente;
  final VoidCallback? onNuevaDeuda;
  final VoidCallback? onRegistrarPago;
  final VoidCallback? onCrearRespaldo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(ref),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: DashboardHeader(date: DateTime.now())),
              SliverToBoxAdapter(child: DashboardResume()),
              SliverToBoxAdapter(child: DashboardStats()),
              SliverToBoxAdapter(
                child: DashboardQuickActions(
                  // Abrir pantalla de clientes
                  onNuevoCliente: onNuevoCliente,
                  // Abrir pantalla de deudas
                  onNuevaDeuda: onNuevaDeuda,
                  // Abrir pantalla de pagos
                  onRegistrarPago: onRegistrarPago,
                  // Abrir pantalla de respaldos
                  onCrearRespaldo: onCrearRespaldo,
                ),
              ),
              SliverToBoxAdapter(child: DashboardRecentDeudas()),
              SliverToBoxAdapter(child: DashboardBackupCard()),
              SliverPadding(padding: EdgeInsets.only(bottom: 24)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh(WidgetRef ref) async {
    await ref.read(dashboardRefreshProvider.future);
  }
}
