import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';

import '../../../models/deuda.dart';

class DeudaDeleteDialog extends StatelessWidget {
  const DeudaDeleteDialog({super.key, required this.deuda});

  final Deuda deuda;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cliente = deuda.cliente.value;

    final nombreCliente = cliente?.nombre ?? 'Cliente desconocido';

    return AlertDialog(
      icon: Icon(
        Icons.delete_outline,
        color: theme.colorScheme.error,
        size: 32,
      ),

      title: const Text('Eliminar deuda'),

      content: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            const TextSpan(text: '¿Deseas eliminar la deuda de '),

            TextSpan(
              text: nombreCliente,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const TextSpan(text: '?\n\n'),

            TextSpan(
              text: 'Valor: ${AppConstants.formatearMoneda(deuda.total)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

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

  static Future<bool> mostrar(BuildContext context, Deuda deuda) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) {
        return DeudaDeleteDialog(deuda: deuda);
      },
    );

    return resultado ?? false;
  }
}
