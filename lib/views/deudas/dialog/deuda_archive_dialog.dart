import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';

import '../../../models/deuda.dart';

class DeudaArchiveDialog extends StatelessWidget {
  const DeudaArchiveDialog({super.key, required this.deuda});

  final Deuda deuda;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cliente = deuda.cliente.value;

    final nombreCliente = cliente?.nombre ?? 'Cliente desconocido';

    final estaArchivada = deuda.archivada;

    return AlertDialog(
      icon: Icon(
        estaArchivada ? Icons.unarchive_outlined : Icons.archive_outlined,
        color: theme.colorScheme.primary,
        size: 32,
      ),

      title: Text(estaArchivada ? 'Desarchivar deuda' : 'Archivar deuda'),

      content: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: estaArchivada
                  ? '¿Deseas desarchivar la deuda de '
                  : '¿Deseas archivar la deuda de ',
            ),

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
              text: '\n\nLa deuda conservará toda su información.',
            ),
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
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            estaArchivada ? Icons.unarchive_outlined : Icons.archive_outlined,
          ),
          label: Text(estaArchivada ? 'Desarchivar' : 'Archivar'),
        ),
      ],
    );
  }

  static Future<bool> mostrar(BuildContext context, Deuda deuda) async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (_) {
        return DeudaArchiveDialog(deuda: deuda);
      },
    );

    return resultado ?? false;
  }
}
