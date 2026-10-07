import 'package:flutter/material.dart';

import '../../../models/configuracion.dart';

class ConfiguracionGeneralCard extends StatelessWidget {
  const ConfiguracionGeneralCard({
    super.key,
    required this.configuracion,
    required this.onTemaOscuroChanged,
  });

  final Configuracion configuracion;
  final ValueChanged<bool> onTemaOscuroChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.tune_outlined,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'General',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Configura el comportamiento general de la aplicación.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: configuracion.temaOscuro,
              secondary: const Icon(Icons.dark_mode_outlined),
              title: const Text('Tema oscuro'),
              subtitle: const Text(
                'Utilizar una apariencia oscura en la aplicación.',
              ),
              onChanged: onTemaOscuroChanged,
            ),
          ],
        ),
      ),
    );
  }
}
