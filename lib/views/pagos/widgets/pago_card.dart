import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';

import '../../../core/enums/metodo_pago.dart';
import '../../../models/pago.dart';

class PagoCard extends StatelessWidget {
  const PagoCard({
    super.key,
    required this.pago,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Pago pago;

  final VoidCallback? onTap;

  final VoidCallback? onEdit;

  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final deuda = pago.deuda.value;
    final cliente = deuda?.cliente.value;

    final nombreCliente = cliente?.nombre ?? 'Cliente desconocido';

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
                    child: Text(AppConstants.iniciales(nombreCliente)),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nombreCliente,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pago: ${AppConstants.formatearFecha(pago.fechaPago)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Pago #${pago.numeroPago.toString().padLeft(6, '0')}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<_PagoAction>(
                    onSelected: (action) {
                      switch (action) {
                        case _PagoAction.editar:
                          onEdit?.call();
                          break;

                        case _PagoAction.eliminar:
                          onDelete?.call();
                          break;
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: _PagoAction.editar,
                        child: ListTile(
                          leading: Icon(Icons.edit_outlined),
                          title: Text('Editar'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),

                      PopupMenuItem(
                        value: _PagoAction.eliminar,
                        child: ListTile(
                          leading: Icon(Icons.delete_outline),
                          title: Text('Eliminar'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Valor del pago',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            AppConstants.formatearMoneda(pago.valor),
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: Icon(_iconoMetodoPago(pago.metodoPago), size: 18),
                    label: Text(
                      AppConstants.formatearMetodoPago(pago.metodoPago),
                    ),
                  ),

                  if (deuda != null)
                    Chip(
                      avatar: const Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 18,
                      ),
                      label: Text(
                        'Saldo: ${AppConstants.formatearMoneda(deuda.saldoPendiente)}',
                      ),
                    ),
                ],
              ),

              if ((pago.referencia ?? '').trim().isNotEmpty) ...[
                const SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 17,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        'Referencia: ${pago.referencia!.trim()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              if ((pago.observacion ?? '').trim().isNotEmpty) ...[
                const SizedBox(height: 6),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notes_outlined,
                      size: 17,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        pago.observacion!.trim(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static IconData _iconoMetodoPago(MetodoPago metodo) {
    switch (metodo) {
      case MetodoPago.efectivo:
        return Icons.payments_outlined;

      default:
        return Icons.payment_outlined;
    }
  }
}

enum _PagoAction { editar, eliminar }
