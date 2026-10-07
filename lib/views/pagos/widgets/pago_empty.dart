import 'package:flutter/material.dart';

class PagoEmpty extends StatelessWidget {
  const PagoEmpty({
    super.key,
    this.hayFiltros = false,
    this.onClearFilters,
    this.onCreate,
  });

  final bool hayFiltros;

  final VoidCallback? onClearFilters;

  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titulo = hayFiltros
        ? 'No se encontraron pagos'
        : 'No hay pagos registrados';

    final descripcion = hayFiltros
        ? 'No existen pagos que coincidan con la búsqueda o los filtros aplicados.'
        : 'Registra un nuevo pago para comenzar a llevar el control de los abonos realizados.';

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primaryContainer,
                ),
                child: Icon(
                  hayFiltros
                      ? Icons.search_off_outlined
                      : Icons.payments_outlined,
                  size: 42,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                titulo,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                descripcion,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              if (hayFiltros)
                OutlinedButton.icon(
                  onPressed: onClearFilters,
                  icon: const Icon(Icons.filter_alt_off_outlined),
                  label: const Text('Limpiar filtros'),
                )
              else
                FilledButton.icon(
                  onPressed: onCreate,
                  icon: const Icon(Icons.add),
                  label: const Text('Registrar pago'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
