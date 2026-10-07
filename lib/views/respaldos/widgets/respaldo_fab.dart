import 'package:flutter/material.dart';

class RespaldoFab extends StatelessWidget {
  const RespaldoFab({super.key, this.onCrearCopia});

  final VoidCallback? onCrearCopia;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onCrearCopia,
      heroTag: 'respaldo_fab',
      icon: const Icon(Icons.backup_outlined),
      label: const Text('Crear copia'),
      tooltip: 'Crear copia de seguridad',
    );
  }
}
