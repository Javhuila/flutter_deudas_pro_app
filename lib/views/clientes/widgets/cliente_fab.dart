import 'package:flutter/material.dart';

class ClienteFab extends StatelessWidget {
  const ClienteFab({super.key, this.onPressed, this.extended = true});

  final VoidCallback? onPressed;

  final bool extended;

  @override
  Widget build(BuildContext context) {
    if (!extended) {
      return FloatingActionButton(
        onPressed: onPressed,
        heroTag: 'cliente_fab',
        tooltip: 'Nuevo cliente',
        child: const Icon(Icons.person_add_alt_1),
      );
    }

    return FloatingActionButton.extended(
      onPressed: onPressed,
      heroTag: 'cliente_fab',
      tooltip: 'Nuevo cliente',
      icon: const Icon(Icons.person_add_alt_1),
      label: const Text('Nuevo cliente'),
    );
  }
}
