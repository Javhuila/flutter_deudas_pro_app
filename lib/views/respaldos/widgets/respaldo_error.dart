import 'package:flutter/material.dart';

class RespaldoError extends StatelessWidget {
  const RespaldoError({super.key, this.mensaje, this.onRetry});

  final String? mensaje;

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mensajeMostrar = mensaje?.trim().isNotEmpty == true
        ? mensaje!.trim()
        : 'Ocurrió un problema al cargar la información de los respaldos. '
              'Intenta nuevamente.';

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.errorContainer,
                ),
                child: Icon(
                  Icons.cloud_off_outlined,
                  size: 44,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'No se pudieron cargar los respaldos',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                mensajeMostrar,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Intentar nuevamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
