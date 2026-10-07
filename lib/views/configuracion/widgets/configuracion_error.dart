import 'package:flutter/material.dart';

class ConfiguracionError extends StatelessWidget {
  const ConfiguracionError({super.key, this.mensaje, this.onRetry});

  final String? mensaje;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mensajeMostrar = mensaje?.trim().isNotEmpty == true
        ? mensaje!.trim()
        : 'Ocurrió un problema al cargar la configuración.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.settings_outlined,
                size: 44,
                color: theme.colorScheme.onErrorContainer,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'No se pudo cargar la configuración',
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
    );
  }
}
