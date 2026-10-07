import 'package:flutter/material.dart';

class DeudaFilterBar extends StatelessWidget {
  const DeudaFilterBar({
    super.key,
    this.totalDeudas,
    this.deudasMostradas,
    this.hayFiltros,
    this.onFilterPressed,
  });

  final int? totalDeudas;
  final int? deudasMostradas;
  final bool? hayFiltros;
  final VoidCallback? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final total = totalDeudas ?? 0;
    final mostradas = deudasMostradas ?? total;

    String texto;

    if (hayFiltros == true && mostradas != total) {
      texto = '$mostradas de $total deudas';
    } else {
      texto = '$total deudas';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    texto,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),

                if (hayFiltros == true) ...[
                  const SizedBox(width: 8),

                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          FilledButton.tonalIcon(
            onPressed: onFilterPressed,
            icon: const Icon(Icons.filter_list),
            label: const Text('Filtros'),
          ),
        ],
      ),
    );
  }
}
