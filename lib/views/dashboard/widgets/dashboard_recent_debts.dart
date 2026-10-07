import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../services/dashboard/dashboard_recent_debt.dart';
import '../../widgets/app_section_card.dart';

class DashboardRecentDeudas extends ConsumerWidget {
  const DashboardRecentDeudas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentDeudas = ref.watch(dashboardRecentDebtsProvider);

    return recentDeudas.when(
      data: (data) => _Content(deudas: data),

      loading: () => const _Loading(),

      error: (error, stackTrace) => _Error(
        onRetry: () {
          ref.invalidate(dashboardRecentDebtsProvider);
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.deudas});

  final List<DashboardRecentDebt> deudas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Últimas deudas',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(width: 8),

              TextButton(onPressed: () {}, child: const Text('Ver todas')),
            ],
          ),

          const SizedBox(height: 12),

          if (deudas.isEmpty)
            const AppSectionCard(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: Text('No existen deudas registradas.')),
              ),
            )
          else
            AppSectionCard(
              child: Column(
                children: List.generate(deudas.length, (index) {
                  final deuda = deudas[index];

                  return Column(
                    children: [
                      _RecentDebtItem(deuda: deuda),

                      if (index != deudas.length - 1) const Divider(height: 24),
                    ],
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecentDebtItem extends StatelessWidget {
  const _RecentDebtItem({required this.deuda});

  final DashboardRecentDebt deuda;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                deuda.nombreCliente.isNotEmpty
                    ? deuda.nombreCliente.substring(0, 1).toUpperCase()
                    : '?',
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(deuda.nombreCliente, style: theme.textTheme.titleMedium),

                  const SizedBox(height: 2),

                  Text(
                    AppConstants.formatearEstado(deuda.estado),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Text(
              AppConstants.formatearMoneda(deuda.total),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
            'Últimas deudas',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          const SizedBox(height: 240, child: Card()),
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
                'No fue posible cargar las últimas deudas.',
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
