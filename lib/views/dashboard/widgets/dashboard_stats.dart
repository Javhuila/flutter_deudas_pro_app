import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/dashboard_provider.dart';
import '../../../services/dashboard/dashboard_statistics_data.dart';
import '../../widgets/app_info_card.dart';

class DashboardStats extends ConsumerWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statistics = ref.watch(dashboardStatisticsProvider);

    return statistics.when(
      data: (data) => _Content(statistics: data),

      loading: () => const _Loading(),

      error: (error, stackTrace) => _Error(
        onRetry: () {
          ref.invalidate(dashboardStatisticsProvider);
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.statistics});

  final DashboardStatisticsData statistics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estadísticas',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          AppInfoCard(
            title: 'Total prestado',
            value: AppConstants.formatearMoneda(statistics.totalPrestado),
            subtitle:
                '${AppConstants.formatearMoneda(statistics.promedioPrestamo)} promedio por préstamo',
            icon: Icons.payments_outlined,
          ),

          const SizedBox(height: 12),

          AppInfoCard(
            title: 'Total recuperado',
            value: AppConstants.formatearMoneda(statistics.totalRecuperado),
            subtitle: '${statistics.totalPagos} pagos registrados',
            icon: Icons.savings_outlined,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          AppInfoCard(
            title: 'Saldo pendiente',
            value: AppConstants.formatearMoneda(statistics.saldoPendiente),
            subtitle: 'Pendiente por recuperar',
            icon: Icons.account_balance_wallet_outlined,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          AppInfoCard(
            title: 'Intereses generados',
            value: AppConstants.formatearMoneda(statistics.interesesGenerados),
            subtitle: 'Intereses acumulados',
            icon: Icons.trending_up,
            color: Colors.blue,
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estadísticas',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 14),

          const SizedBox(height: 90, child: Card()),

          SizedBox(height: 12),

          const SizedBox(height: 90, child: Card()),

          SizedBox(height: 12),

          const SizedBox(height: 90, child: Card()),

          SizedBox(height: 12),

          const SizedBox(height: 90, child: Card()),
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
                'No fue posible cargar las estadísticas.',
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
