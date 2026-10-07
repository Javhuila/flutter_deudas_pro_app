import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../models/pago.dart';

class PagoDeleteDialog extends StatelessWidget {
  const PagoDeleteDialog({super.key, required this.pago});

  final Pago pago;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final deuda = pago.deuda.value;
    final cliente = deuda?.cliente.value;

    final nombreCliente = cliente?.nombre ?? 'Cliente desconocido';

    final totalDeuda = deuda?.total ?? 0;

    return AlertDialog(
      icon: Icon(
        Icons.delete_outline,
        color: theme.colorScheme.error,
        size: 32,
      ),

      title: const Text('Eliminar pago'),

      content: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            const TextSpan(text: '¿Deseas eliminar el pago registrado para '),

            TextSpan(
              text: nombreCliente,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const TextSpan(text: '?\n\n'),

            TextSpan(
              text:
                  'Valor del pago: ${AppConstants.formatearMoneda(pago.valor)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const TextSpan(text: '\n'),

            TextSpan(
              text:
                  'Método: ${AppConstants.formatearMetodoPago(pago.metodoPago)}',
            ),

            const TextSpan(text: '\n'),

            TextSpan(
              text: 'Fecha: ${AppConstants.formatearFecha(pago.fechaPago)}',
            ),

            if (deuda != null) ...[
              const TextSpan(text: '\n\n'),

              TextSpan(
                text:
                    'Total de la deuda: ${AppConstants.formatearMoneda(totalDeuda)}',
              ),
            ],

            const TextSpan(text: '\n\nEsta acción no se puede deshacer.'),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancelar'),
        ),

        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.delete),
          label: const Text('Eliminar'),
        ),
      ],
    );
  }

  static Future<bool> mostrar(BuildContext context, Pago pago) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) {
        return PagoDeleteDialog(pago: pago);
      },
    );

    return resultado ?? false;
  }
}
