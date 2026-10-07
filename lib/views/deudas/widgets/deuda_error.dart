import 'package:flutter/material.dart';

class DeudaError extends StatelessWidget {
  const DeudaError({super.key, this.mensaje, this.onRetry});

  final String? mensaje;

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  Icons.error_outline,
                  size: 44,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'No se pudieron cargar las deudas',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                mensaje?.trim().isNotEmpty == true
                    ? mensaje!
                    : 'Ocurrió un problema al obtener la información de las deudas. Intenta nuevamente.',
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
