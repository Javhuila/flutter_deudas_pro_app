import 'package:flutter/material.dart';

class PagoFab extends StatelessWidget {
  const PagoFab({super.key, this.onPressed, this.extended = true});

  final VoidCallback? onPressed;

  final bool extended;

  @override
  Widget build(BuildContext context) {
    if (!extended) {
      return FloatingActionButton(
        onPressed: onPressed,
        heroTag: 'pago_fab',
        tooltip: 'Registrar pago',
        child: const Icon(Icons.add_card),
      );
    }

    return FloatingActionButton.extended(
      onPressed: onPressed,
      heroTag: 'pago_fab',
      tooltip: 'Registrar pago',
      icon: const Icon(Icons.add_card),
      label: const Text('Registrar pago'),
    );
  }
}
