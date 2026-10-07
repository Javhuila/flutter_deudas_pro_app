import 'package:flutter/material.dart';

class ConfiguracionRestaurarCard extends StatelessWidget {
  const ConfiguracionRestaurarCard({super.key, required this.onRestaurar});

  final VoidCallback onRestaurar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.restore_outlined, color: colorScheme.primary),

                const SizedBox(width: 10),

                Text(
                  'Restablecer',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              'Restablece las opciones de configuración a sus valores '
              'predeterminados. Los datos de la aplicación no serán eliminados.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: onRestaurar,
              icon: const Icon(Icons.restore),
              label: const Text('Restaurar configuración'),
            ),
          ],
        ),
      ),
    );
  }
}
