import 'package:flutter/material.dart';

class ClienteFilterBar extends StatelessWidget {
  const ClienteFilterBar({
    super.key,
    this.visibles,
    this.total,
    this.hayFiltros,
    this.onFilterPressed,
  });

  final int? visibles;
  final int? total;
  final bool? hayFiltros;
  final VoidCallback? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalClientes = total ?? 0;
    final mostrarClientes = visibles ?? totalClientes;

    String texto;

    if (hayFiltros == true && mostrarClientes != totalClientes) {
      texto = '$mostrarClientes de $totalClientes clientes';
    } else {
      texto = '$totalClientes clientes';
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
          const SizedBox(width: 12),
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
