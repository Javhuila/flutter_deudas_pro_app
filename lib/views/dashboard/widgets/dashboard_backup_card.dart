import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/estado_respaldo.dart';
import '../../../providers/dashboard_provider.dart';
import '../../../services/dashboard/dashboard_backup_summary.dart';
import '../../widgets/app_status_card.dart';

class DashboardBackupCard extends ConsumerWidget {
  const DashboardBackupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backup = ref.watch(dashboardBackupProvider);

    return backup.when(
      data: (data) => _Content(backup: data),

      loading: () => const _Loading(),

      error: (error, stackTrace) => _Error(
        onRetry: () {
          ref.invalidate(dashboardBackupProvider);
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.backup});

  final DashboardBackupSummary backup;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!backup.existeRespaldo) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: AppStatusCard(
          title: 'Último respaldo',
          icon: Icons.backup_outlined,
          action: TextButton(
            onPressed: () {},
            child: const Text('Ver historial'),
          ),
          child: Column(
            children: [
              Column(
                children: [
                  const Icon(Icons.backup_outlined, size: 48),

                  const SizedBox(height: 12),

                  const Text(
                    'No existen respaldos registrados.',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.backup),
                      label: const Text('Crear respaldo'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: AppStatusCard(
        title: 'Último respaldo',
        icon: Icons.backup_outlined,
        action: TextButton(
          onPressed: () {},
          child: const Text('Ver historial'),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  backup.estado == EstadoRespaldo.exitoso
                      ? Icons.check_circle
                      : Icons.error,
                  color: backup.estado == EstadoRespaldo.exitoso
                      ? Colors.green
                      : Colors.red,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        backup.estado == EstadoRespaldo.exitoso
                            ? 'Respaldo completado correctamente'
                            : 'El respaldo finalizó con errores',
                        style: theme.textTheme.titleSmall,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        AppConstants.formatFecha(backup.fecha),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 28),

            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    titulo: 'Tipo',
                    valor: AppConstants.tipoTexto(backup.tipo),
                  ),
                ),

                Expanded(
                  child: _InfoItem(
                    titulo: 'Tamaño',
                    valor: AppConstants.formatBytes(backup.tamanoBytes),
                  ),
                ),

                Expanded(
                  child: _InfoItem(
                    titulo: 'Registros',
                    valor:
                        '${backup.cantidadClientes + backup.cantidadDeudas + backup.cantidadPagos}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.backup),
                label: const Text('Crear respaldo ahora'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.titulo, required this.valor});

  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          valor,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          titulo,
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: SizedBox(height: 220, child: Card()),
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
                'No fue posible cargar la información del respaldo.',
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
