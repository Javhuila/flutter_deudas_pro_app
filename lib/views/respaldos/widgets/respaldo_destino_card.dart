import 'package:flutter/material.dart';

class RespaldoDestinoCard extends StatelessWidget {
  const RespaldoDestinoCard({
    super.key,
    this.carpeta,
    this.carpetaUri,
    this.seleccionando = false,
    this.onSeleccionarCarpeta,
    this.onRestablecerCarpeta,
  });

  /// Ruta de la carpeta seleccionada.
  final String? carpeta;

  /// URI de la carpeta seleccionada.
  final String? carpetaUri;

  /// Indica si actualmente se está seleccionando una carpeta.
  final bool seleccionando;

  /// Acción para seleccionar/cambiar la carpeta.
  final VoidCallback? onSeleccionarCarpeta;

  /// Acción para restablecer la carpeta configurada.
  final VoidCallback? onRestablecerCarpeta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final tieneDestino =
        carpeta?.trim().isNotEmpty == true ||
        carpetaUri?.trim().isNotEmpty == true;

    final textoDestino = _obtenerTextoDestino();

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
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.folder_outlined,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destino de respaldo',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Selecciona la carpeta donde se guardarán las copias de seguridad.',
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
                    tieneDestino ? Icons.folder : Icons.folder_off_outlined,
                    color: tieneDestino
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carpeta actual',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          textoDestino,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
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
              child: FilledButton.tonalIcon(
                onPressed: seleccionando ? null : onSeleccionarCarpeta,
                icon: seleccionando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        tieneDestino
                            ? Icons.drive_file_move_outlined
                            : Icons.folder_open_outlined,
                      ),
                label: Text(
                  seleccionando
                      ? 'Seleccionando...'
                      : tieneDestino
                      ? 'Cambiar carpeta'
                      : 'Seleccionar carpeta',
                ),
              ),
            ),

            if (tieneDestino && onRestablecerCarpeta != null) ...[
              const SizedBox(height: 4),

              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: seleccionando ? null : onRestablecerCarpeta,
                  icon: const Icon(Icons.restore_outlined),
                  label: const Text('Restablecer destino'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _obtenerTextoDestino() {
    final ruta = carpeta?.trim();

    if (ruta != null && ruta.isNotEmpty) {
      return ruta;
    }

    final uri = carpetaUri?.trim();

    if (uri != null && uri.isNotEmpty) {
      return uri;
    }

    return 'No se ha seleccionado una carpeta.';
  }
}
