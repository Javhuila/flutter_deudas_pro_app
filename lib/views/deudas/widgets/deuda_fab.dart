import 'package:flutter/material.dart';

class DeudaFab extends StatelessWidget {
  const DeudaFab({super.key, this.onPressed, this.extended = true});

  final VoidCallback? onPressed;

  final bool extended;

  @override
  Widget build(BuildContext context) {
    if (!extended) {
      return FloatingActionButton(
        onPressed: onPressed,
        heroTag: 'deuda_fab',
        tooltip: 'Nueva deuda',
        child: const Icon(Icons.add_card),
      );
    }

    return FloatingActionButton.extended(
      onPressed: onPressed,
      heroTag: 'deuda_fab',
      tooltip: 'Nueva deuda',
      icon: const Icon(Icons.add_card),
      label: const Text('Nueva deuda'),
    );
  }
}
