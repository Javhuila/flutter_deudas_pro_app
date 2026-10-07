import 'package:flutter/material.dart';

import '../../../models/cliente.dart';

class ClienteDeleteDialog extends StatelessWidget {
  const ClienteDeleteDialog({super.key, required this.cliente});

  final Cliente cliente;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: Icon(
        Icons.delete_outline,
        color: theme.colorScheme.error,
        size: 32,
      ),

      title: const Text('Eliminar cliente'),

      content: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            const TextSpan(text: '¿Deseas eliminar el cliente '),

            TextSpan(
              text: cliente.nombre,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const TextSpan(text: '?\n\nEsta acción no se puede deshacer.'),
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

  static Future<bool> mostrar(BuildContext context, Cliente cliente) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) => ClienteDeleteDialog(cliente: cliente),
    );

    return resultado ?? false;
  }
}
