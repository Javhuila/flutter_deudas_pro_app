import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/enums/estado_deuda.dart';
import '../../../models/deuda.dart';

class DeudaCard extends StatelessWidget {
  const DeudaCard({
    super.key,
    required this.deuda,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onCancel,
    this.onArchive,
  });

  final Deuda deuda;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;
  final VoidCallback? onArchive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cliente = deuda.cliente.value;

    final estado = _obtenerEstado(deuda);
    final estadoColor = _obtenerColorEstado(context, estado);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    child: Text(
                      AppConstants.iniciales(cliente?.nombre ?? 'Sin cliente'),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cliente?.nombre ?? 'Cliente no disponible',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Préstamo: ${AppConstants.formatearFecha(deuda.fechaPrestamo)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Deuda #${deuda.numeroDeuda.toString().padLeft(6, '0')}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<_DeudaAction>(
                    onSelected: (action) {
                      switch (action) {
                        case _DeudaAction.editar:
                          onEdit?.call();
                          break;
                        case _DeudaAction.cancelar:
                          onCancel?.call();
                          break;
                        case _DeudaAction.eliminar:
                          onDelete?.call();
                          break;
                        case _DeudaAction.archivar:
                          onArchive?.call();
                          break;
                      }
                    },
                    itemBuilder: (_) {
                      final opciones = <PopupMenuEntry<_DeudaAction>>[
                        const PopupMenuItem(
                          value: _DeudaAction.editar,
                          child: ListTile(
                            leading: Icon(Icons.edit_outlined),
                            title: Text('Editar'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ];
                      if (deuda.saldoPendiente > 0) {
                        opciones.add(
                          const PopupMenuItem(
                            value: _DeudaAction.cancelar,
                            child: ListTile(
                              leading: Icon(Icons.cancel_outlined),
                              title: Text('Cancelar deuda'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        );
                      } else {
                        opciones.add(
                          const PopupMenuItem(
                            value: _DeudaAction.eliminar,
                            child: ListTile(
                              leading: Icon(Icons.delete_outline),
                              title: Text('Eliminar'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        );
                      }
                      opciones.add(
                        PopupMenuItem(
                          value: _DeudaAction.archivar,
                          child: ListTile(
                            leading: Icon(
                              deuda.archivada
                                  ? Icons.unarchive_outlined
                                  : Icons.archive_outlined,
                            ),
                            title: Text(
                              deuda.archivada ? 'Desarchivar' : 'Archivar',
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      );

                      return opciones;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _AmountItem(
                      titulo: 'Capital',
                      valor: AppConstants.formatearMoneda(deuda.capital),
                      icon: Icons.payments_outlined,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _AmountItem(
                      titulo: 'Saldo pendiente',
                      valor: AppConstants.formatearMoneda(deuda.saldoPendiente),
                      icon: Icons.account_balance_wallet_outlined,
                      destacado: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  _EstadoChip(estado: estado, color: estadoColor),

                  const Spacer(),

                  if (deuda.fechaVencimiento != null) ...[
                    Icon(
                      Icons.event_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        AppConstants.formatearFecha(deuda.fechaVencimiento!),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _obtenerEstado(Deuda deuda) {
    switch (deuda.estado) {
      case EstadoDeuda.pendiente:
        return 'Pendiente';

      case EstadoDeuda.pagada:
        return 'Pagada';

      case EstadoDeuda.vencida:
        return 'Vencida';
    }
  }

  static Color _obtenerColorEstado(BuildContext context, String estado) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (estado) {
      case 'Pagada':
        return Colors.green;

      case 'Vencida':
        return colorScheme.error;

      case 'Pendiente':
      default:
        return Colors.orange;
    }
  }
}

class _AmountItem extends StatelessWidget {
  const _AmountItem({
    required this.titulo,
    required this.valor,
    required this.icon,
    this.destacado = false,
  });

  final String titulo;

  final String valor;

  final IconData icon;

  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: destacado
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
          ),

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
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  valor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
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

class _EstadoChip extends StatelessWidget {
  const _EstadoChip({required this.estado, required this.color});

  final String estado;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(_iconoEstado(estado), size: 17, color: color),
      label: Text(estado),
      visualDensity: VisualDensity.compact,
      side: BorderSide(color: color.withValues(alpha: 0.25)),
    );
  }

  static IconData _iconoEstado(String estado) {
    switch (estado) {
      case 'Pagada':
        return Icons.check_circle_outline;

      case 'Vencida':
        return Icons.warning_amber_rounded;

      case 'Pendiente':
      default:
        return Icons.schedule;
    }
  }
}

enum _DeudaAction { editar, cancelar, eliminar, archivar }
