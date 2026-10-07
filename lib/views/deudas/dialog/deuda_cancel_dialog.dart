import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';

import '../../../models/deuda.dart';

class DeudaCancelDialog extends StatelessWidget {
  const DeudaCancelDialog({super.key, required this.deuda});

  final Deuda deuda;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cliente = deuda.cliente.value;

    final nombreCliente = cliente?.nombre ?? 'Cliente desconocido';

    return AlertDialog(
      icon: Icon(
        Icons.cancel_outlined,
        color: theme.colorScheme.error,
        size: 32,
      ),

      title: const Text('Cancelar deuda'),

      content: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            const TextSpan(text: '¿Deseas cancelar la deuda de '),

            TextSpan(
              text: nombreCliente,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const TextSpan(text: '?\n\n'),

            TextSpan(
              text:
                  'Saldo pendiente: '
                  '${AppConstants.formatearMoneda(deuda.saldoPendiente)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const TextSpan(
              text:
                  '\n\nLa deuda, sus pagos, intereses y cuotas '
                  'serán eliminados permanentemente.',
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
          child: const Text('Volver'),
        ),

        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.cancel),
          label: const Text('Cancelar deuda'),
        ),
      ],
    );
  }

  static Future<bool> mostrar(BuildContext context, Deuda deuda) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) {
        return DeudaCancelDialog(deuda: deuda);
      },
    );

    return resultado ?? false;
  }
}
