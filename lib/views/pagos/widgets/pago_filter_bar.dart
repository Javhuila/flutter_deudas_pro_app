import 'package:flutter/material.dart';

class PagoFilterBar extends StatelessWidget {
  const PagoFilterBar({
    super.key,
    this.totalPagos,
    this.pagosMostrados,
    this.hayFiltros,
    this.onFilterPressed,
  });

  final int? totalPagos;

  final int? pagosMostrados;

  final bool? hayFiltros;

  final VoidCallback? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final total = totalPagos ?? 0;
    final mostrados = pagosMostrados ?? total;

    String texto;

    if (hayFiltros == true && mostrados != total) {
      texto = '$mostrados de $total pagos';
    } else {
      texto = '$total pagos';
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
