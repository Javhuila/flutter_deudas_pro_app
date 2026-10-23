import 'package:flutter/material.dart';

import '../../../core/enums/estado_respaldo.dart';
import '../../../core/enums/tipo_respaldo.dart';
import '../../../models/respaldo.dart';

class RespaldoInfoCard extends StatelessWidget {
  const RespaldoInfoCard({super.key, this.respaldo});

  final Respaldo? respaldo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (respaldo == null) {
      return Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                context,
                icon: Icons.info_outline,
                title: 'Información del respaldo',
                subtitle: 'Todavía no hay copias de seguridad registradas.',
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.backup_outlined,
                      color: colorScheme.onSurfaceVariant,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'Cuando se realice una copia, aquí '
                        'podrás consultar su información.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final estadoColor = _obtenerColorEstado(context, respaldo!.estado);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(
              context,
              icon: Icons.analytics_outlined,
              title: 'Información del respaldo',
              subtitle: 'Detalle de la última copia realizada.',
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.calendar_today_outlined,
                    titulo: 'Fecha',
                    valor: _formatearFechaHora(respaldo!.fecha),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _InfoItem(
                    icon: Icons.backup_outlined,
                    titulo: 'Tipo',
                    valor: _formatearTipo(respaldo!.tipo),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: estadoColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    _iconoEstado(respaldo!.estado),
                    size: 20,
                    color: estadoColor,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      _formatearEstado(respaldo!.estado),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: estadoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _InfoRow(
              icon: Icons.insert_drive_file_outlined,
              titulo: 'Archivo',
              valor: respaldo!.nombreArchivo.isEmpty
                  ? 'Sin nombre'
                  : respaldo!.nombreArchivo,
            ),

            if (respaldo!.rutaArchivo.isNotEmpty) ...[
              const SizedBox(height: 10),

              _InfoRow(
                icon: Icons.folder_outlined,
                titulo: 'Ubicación',
                valor: respaldo!.rutaArchivo,
              ),
            ],

            const SizedBox(height: 16),

            Text(
              'Datos incluidos',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _StatisticItem(
                    icon: Icons.people_outline,
                    titulo: 'Clientes',
                    valor: respaldo!.cantidadClientes.toString(),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: _StatisticItem(
                    icon: Icons.account_balance_wallet_outlined,
                    titulo: 'Deudas',
                    valor: respaldo!.cantidadDeudas.toString(),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: _StatisticItem(
                    icon: Icons.payments_outlined,
                    titulo: 'Pagos',
                    valor: respaldo!.cantidadPagos.toString(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.storage_outlined,
                    titulo: 'Tamaño',
                    valor: _formatearTamano(respaldo!.tamanoBytes),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _InfoItem(
                    icon: Icons.timer_outlined,
                    titulo: 'Duración',
                    valor: _formatearDuracion(respaldo!.duracionMs),
                  ),
                ),
              ],
            ),

            if (respaldo!.observacion?.trim().isNotEmpty == true) ...[
              const SizedBox(height: 16),

              _InfoRow(
                icon: Icons.notes_outlined,
                titulo: 'Observación',
                valor: respaldo!.observacion!.trim(),
              ),
            ],

            const SizedBox(height: 16),

            Text(
              'Versión de la aplicación: '
              '${respaldo!.versionAplicacion}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(icon, color: colorScheme.onPrimaryContainer),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Color _obtenerColorEstado(
    BuildContext context,
    EstadoRespaldo estado,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (estado) {
      case EstadoRespaldo.exitoso:
        return colorScheme.primary;

      case EstadoRespaldo.error:
        return colorScheme.error;
    }
  }

  static IconData _iconoEstado(EstadoRespaldo estado) {
    switch (estado) {
      case EstadoRespaldo.exitoso:
        return Icons.check_circle_outline;

      case EstadoRespaldo.error:
        return Icons.error_outline;
    }
  }

  static String _formatearEstado(EstadoRespaldo estado) {
    switch (estado) {
      case EstadoRespaldo.exitoso:
        return 'Copia realizada correctamente';

      case EstadoRespaldo.error:
        return 'La copia presentó un error';
    }
  }

  static String _formatearTipo(TipoRespaldo tipo) {
    switch (tipo) {
      case TipoRespaldo.manual:
        return 'Manual';

      case TipoRespaldo.automatico:
        return 'Automática';

      case TipoRespaldo.restauracion:
        return 'Restauración';
    }
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

  static String _formatearTamano(int bytes) {
    if (bytes <= 0) {
      return '0 B';
    }

    if (bytes < 1024) {
      return '$bytes B';
    }

    if (bytes < 1024 * 1024) {
      final kb = bytes / 1024;
      return '${kb.toStringAsFixed(1)} KB';
    }

    if (bytes < 1024 * 1024 * 1024) {
      final mb = bytes / (1024 * 1024);

      return '${mb.toStringAsFixed(1)} MB';
    }

    final gb = bytes / (1024 * 1024 * 1024);

    return '${gb.toStringAsFixed(2)} GB';
  }

  static String _formatearDuracion(int milisegundos) {
    if (milisegundos <= 0) {
      return '0 ms';
    }

    if (milisegundos < 1000) {
      return '$milisegundos ms';
    }

    final segundos = milisegundos / 1000;

    if (segundos < 60) {
      return '${segundos.toStringAsFixed(1)} s';
    }

    final minutos = segundos / 60;

    return '${minutos.toStringAsFixed(1)} min';
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.titulo,
    required this.valor,
  });

  final IconData icon;
  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  valor,
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
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.titulo,
    required this.valor,
  });

  final IconData icon;
  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                valor,
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
    );
  }
}

class _StatisticItem extends StatelessWidget {
  const _StatisticItem({
    required this.icon,
    required this.titulo,
    required this.valor,
  });

  final IconData icon;
  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),

          const SizedBox(height: 6),

          Text(
            valor,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            titulo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
