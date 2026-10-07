import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';

import '../../../models/cliente.dart';

class ClienteCard extends StatelessWidget {
  const ClienteCard({
    super.key,
    required this.cliente,
    this.cantidadDeudas = 0,
    this.saldoPendiente = 0,
    this.onTap,
    this.onEdit,
    this.onToggleActivo,
    this.onDelete,
  });

  final Cliente cliente;

  final int cantidadDeudas;

  final double saldoPendiente;

  final VoidCallback? onTap;

  final VoidCallback? onEdit;
  final VoidCallback? onToggleActivo;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: cliente.activo
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Text(AppConstants.iniciales(cliente.nombre)),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliente.nombre,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if ((cliente.telefono ?? '').isNotEmpty) ...[
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              cliente.telefono!,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ],

                    if ((cliente.direccion ?? '').isNotEmpty) ...[
                      const SizedBox(height: 4),

                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 16),

                          const SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              cliente.direccion!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 14),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          avatar: const Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 18,
                          ),
                          label: Text('$cantidadDeudas deudas'),
                        ),

                        Chip(
                          avatar: const Icon(Icons.payments_outlined, size: 18),
                          label: Text(
                            AppConstants.formatearMoneda(saldoPendiente),
                          ),
                        ),

                        Chip(
                          avatar: Icon(
                            cliente.activo ? Icons.check_circle : Icons.cancel,
                            size: 18,
                            color: cliente.activo ? Colors.green : Colors.red,
                          ),
                          backgroundColor: cliente.activo
                              ? Colors.green.withValues(alpha: .10)
                              : Colors.red.withValues(alpha: .10),
                          side: BorderSide.none,
                          label: Text(cliente.activo ? 'Activo' : 'Inactivo'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              PopupMenuButton<_ClienteAction>(
                tooltip: 'Opciones',
                onSelected: (action) {
                  switch (action) {
                    case _ClienteAction.editar:
                      onEdit?.call();
                      break;

                    case _ClienteAction.eliminar:
                      onDelete?.call();
                      break;

                    case _ClienteAction.cambiarEstado:
                      onToggleActivo?.call();
                      break;
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: _ClienteAction.editar,
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Editar'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),

                  PopupMenuItem(
                    value: _ClienteAction.eliminar,
                    child: ListTile(
                      leading: Icon(Icons.delete_outline),
                      title: Text('Eliminar'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: _ClienteAction.cambiarEstado,
                    child: ListTile(
                      leading: Icon(
                        cliente.activo
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      title: Text(cliente.activo ? 'Desactivar' : 'Activar'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _ClienteAction { editar, eliminar, cambiarEstado }
