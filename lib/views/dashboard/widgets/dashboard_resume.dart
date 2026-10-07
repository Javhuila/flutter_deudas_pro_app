import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/dashboard_provider.dart';
import '../../../services/dashboard/dashboard_summary.dart';
import '../../widgets/app_stat_card.dart';

class DashboardResume extends ConsumerWidget {
  const DashboardResume({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);

    return summary.when(
      data: (data) => _Content(summary: data),

      loading: () => const _Loading(),

      error: (error, stackTrace) => _Error(
        onRetry: () {
          ref.invalidate(dashboardSummaryProvider);
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppStatCard(
                  title: 'Clientes',
                  value: summary.totalClientes.toString(),
                  icon: Icons.people,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AppStatCard(
                  title: 'Deudas',
                  value: summary.totalDeudas.toString(),
                  icon: Icons.account_balance_wallet,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: AppStatCard(
                  title: 'Pendientes',
                  value: summary.deudasPendientes.toString(),
                  icon: Icons.schedule,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: AppStatCard(
                  title: 'Pagadas',
                  value: summary.deudasPagadas.toString(),
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: SizedBox(height: 95, child: Card())),
              SizedBox(width: 12),
              Expanded(child: SizedBox(height: 95, child: Card())),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: SizedBox(height: 95, child: Card())),
              SizedBox(width: 12),
              Expanded(child: SizedBox(height: 95, child: Card())),
            ],
          ),
        ],
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Icon(Icons.error_outline, size: 42),

              const SizedBox(height: 12),

              const Text(
                'No fue posible cargar el resumen.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
