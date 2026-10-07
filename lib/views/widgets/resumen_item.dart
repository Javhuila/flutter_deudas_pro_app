import 'package:flutter/material.dart';

class ResumenItem extends StatelessWidget {
  const ResumenItem({
    super.key,
    required this.titulo,
    required this.valor,
    this.destacado = false,
  });

  final String titulo;
  final String valor;
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            titulo,
            style: destacado
                ? theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                : theme.textTheme.bodyMedium,
          ),
        ),
        Text(
          valor,
          style: destacado
              ? theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )
              : theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
