import 'package:flutter/material.dart';

import '../../../core/enums/estado_respaldo.dart';
import '../../../core/enums/tipo_respaldo.dart';
import '../../../models/respaldo.dart';

class RespaldoHistorialItem extends StatelessWidget {
  const RespaldoHistorialItem({super.key, required this.respaldo, this.onTap});

  final Respaldo respaldo;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colorEstado = _obtenerColorEstado(context, respaldo.estado);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surfaceContainerHighest,
              ),
              child: Icon(
                _obtenerIconoTipo(respaldo.tipo),
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    respaldo.nombreArchivo.isEmpty
                        ? 'Copia de seguridad'
                        : respaldo.nombreArchivo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    _descripcionTipo(respaldo.tipo),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    _formatearFecha(respaldo.fecha),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  _obtenerIconoEstado(respaldo.estado),
                  size: 20,
                  color: colorEstado,
                ),

                const SizedBox(height: 4),

                Text(
                  _formatearTamano(respaldo.tamanoBytes),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static IconData _obtenerIconoTipo(TipoRespaldo tipo) {
    switch (tipo) {
      case TipoRespaldo.manual:
        return Icons.save_outlined;

      case TipoRespaldo.automatico:
        return Icons.schedule_outlined;

      case TipoRespaldo.restauracion:
        return Icons.restore_outlined;
    }
  }

  static String _descripcionTipo(TipoRespaldo tipo) {
    switch (tipo) {
      case TipoRespaldo.manual:
        return 'Copia manual';

      case TipoRespaldo.automatico:
        return 'Copia automática';

      case TipoRespaldo.restauracion:
        return 'Restauración';
    }
  }

  static IconData _obtenerIconoEstado(EstadoRespaldo estado) {
    switch (estado) {
      case EstadoRespaldo.exitoso:
        return Icons.check_circle_outline;

      case EstadoRespaldo.error:
        return Icons.error_outline;
    }
  }

  static Color _obtenerColorEstado(
    BuildContext context,
    EstadoRespaldo estado,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (estado) {
      case EstadoRespaldo.exitoso:
        return Colors.green;

      case EstadoRespaldo.error:
        return colorScheme.error;
    }
  }

  static String _formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    final anio = fecha.year;

    final hora = fecha.hour.toString().padLeft(2, '0');
    final minuto = fecha.minute.toString().padLeft(2, '0');

    return '$dia/$mes/$anio · $hora:$minuto';
  }

  static String _formatearTamano(int bytes) {
    if (bytes <= 0) {
      return '0 B';
    }

    if (bytes < 1024) {
      return '$bytes B';
    }

    final kb = bytes / 1024;

    if (kb < 1024) {
      return '${kb.toStringAsFixed(1)} KB';
    }

    final mb = kb / 1024;

    if (mb < 1024) {
      return '${mb.toStringAsFixed(1)} MB';
    }

    final gb = mb / 1024;

    return '${gb.toStringAsFixed(1)} GB';
  }
}
