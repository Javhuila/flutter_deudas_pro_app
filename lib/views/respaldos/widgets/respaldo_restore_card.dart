import 'package:flutter/material.dart';

class RespaldoRestoreCard extends StatelessWidget {
  const RespaldoRestoreCard({
    super.key,
    this.archivoSeleccionado,
    this.restaurando = false,
    this.onSeleccionarCopia,
    this.onRestaurar,
  });

  /// Nombre o ruta del archivo de respaldo seleccionado.
  final String? archivoSeleccionado;

  /// Indica si actualmente se está restaurando una copia.
  final bool restaurando;

  /// Acción para seleccionar un archivo de respaldo.
  final VoidCallback? onSeleccionarCopia;

  /// Acción para restaurar el respaldo seleccionado.
  final VoidCallback? onRestaurar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final tieneArchivo = archivoSeleccionado?.trim().isNotEmpty == true;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.tertiaryContainer,
                  child: Icon(
                    Icons.restore_outlined,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Restaurar copia',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Recupera la información de clientes, '
                        'deudas y pagos desde una copia existente.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    tieneArchivo
                        ? Icons.description_outlined
                        : Icons.file_open_outlined,
                    color: tieneArchivo
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Copia seleccionada',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          tieneArchivo
                              ? archivoSeleccionado!
                              : 'Ninguna copia seleccionada.',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: tieneArchivo
                                ? FontWeight.w500
                                : FontWeight.normal,
                            color: tieneArchivo
                                ? null
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: restaurando ? null : onSeleccionarCopia,
                icon: const Icon(Icons.folder_open_outlined),
                label: const Text('Seleccionar copia'),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: !tieneArchivo || restaurando ? null : onRestaurar,
                icon: restaurando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.restore_outlined),
                label: Text(restaurando ? 'Restaurando...' : 'Restaurar copia'),
              ),
            ),

            if (restaurando) ...[
              const SizedBox(height: 12),

              const LinearProgressIndicator(),

              const SizedBox(height: 8),

              Text(
                'No cierres la aplicación mientras se restaura la copia.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
