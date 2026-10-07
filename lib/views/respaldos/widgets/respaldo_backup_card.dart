import 'package:flutter/material.dart';

class RespaldoBackupCard extends StatelessWidget {
  const RespaldoBackupCard({
    super.key,
    this.ultimaCopia,
    this.creando = false,
    this.onCrearCopia,
  });

  /// Fecha y hora de la última copia realizada.
  final DateTime? ultimaCopia;

  /// Indica si actualmente se está creando una copia.
  final bool creando;

  /// Acción para crear una nueva copia.
  final VoidCallback? onCrearCopia;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.backup_outlined,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Copia de seguridad',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Guarda toda la información de clientes, deudas y pagos.',
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

            _UltimaCopiaInfo(fecha: ultimaCopia),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: creando ? null : onCrearCopia,
                icon: creando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.backup_outlined),
                label: Text(creando ? 'Creando copia...' : 'Crear copia ahora'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UltimaCopiaInfo extends StatelessWidget {
  const _UltimaCopiaInfo({required this.fecha});

  final DateTime? fecha;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final tieneCopia = fecha != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            tieneCopia ? Icons.check_circle_outline : Icons.info_outline,
            color: tieneCopia
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Última copia',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  tieneCopia
                      ? _formatearFechaHora(fecha!)
                      : 'No se ha realizado ninguna copia.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _formatearFechaHora(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');

    final mes = fecha.month.toString().padLeft(2, '0');

    final anio = fecha.year;

    final hora12 = fecha.hour % 12 == 0 ? 12 : fecha.hour % 12;

    final minuto = fecha.minute.toString().padLeft(2, '0');

    final periodo = fecha.hour >= 12 ? 'PM' : 'AM';

    return '$dia/$mes/$anio - '
        '$hora12:$minuto $periodo';
  }
}
