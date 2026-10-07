import 'package:flutter/material.dart';

import '../../../models/configuracion.dart';

class ConfiguracionExportacionesCard extends StatelessWidget {
  const ConfiguracionExportacionesCard({
    super.key,
    required this.configuracion,
    required this.onExportarPdfChanged,
    required this.onExportarExcelChanged,
  });

  final Configuracion configuracion;

  final ValueChanged<bool> onExportarPdfChanged;
  final ValueChanged<bool> onExportarExcelChanged;

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
            Text(
              'Exportaciones',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Configura los formatos disponibles para exportar información.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: configuracion.exportarPdf,
              secondary: const Icon(Icons.picture_as_pdf_outlined),
              title: const Text('Exportación PDF'),
              subtitle: const Text('Permitir generar documentos PDF.'),
              onChanged: onExportarPdfChanged,
            ),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: configuracion.exportarExcel,
              secondary: const Icon(Icons.table_chart_outlined),
              title: const Text('Exportación Excel'),
              subtitle: const Text('Permitir generar archivos Excel.'),
              onChanged: onExportarExcelChanged,
            ),
          ],
        ),
      ),
    );
  }
}
