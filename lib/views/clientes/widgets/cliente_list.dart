import 'package:flutter/material.dart';

import '../../../models/cliente.dart';
import '../../../services/cliente/cliente_summary.dart';
import 'cliente_card.dart';

class ClienteList extends StatelessWidget {
  const ClienteList({
    super.key,
    required this.clientes,
    required this.resumenes,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleActivo,
  });

  final List<Cliente> clientes;
  final Map<int, ClienteSummary> resumenes;
  final ValueChanged<Cliente>? onTap;
  final ValueChanged<Cliente>? onEdit;
  final ValueChanged<Cliente>? onDelete;
  final ValueChanged<Cliente>? onToggleActivo;

  @override
  Widget build(BuildContext context) {
    if (clientes.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: clientes.length,

        itemBuilder: (context, index) {
          final cliente = clientes[index];
          final resumen = resumenes[cliente.id];
          return ClienteCard(
            key: ValueKey(cliente.uuid),
            cliente: cliente,
            cantidadDeudas: resumen?.cantidadDeudas ?? 0,
            saldoPendiente: resumen?.saldoPendiente ?? 0,
            onTap: () => onTap?.call(cliente),
            onEdit: () => onEdit?.call(cliente),
            onDelete: () => onDelete?.call(cliente),
            onToggleActivo: () => onToggleActivo?.call(cliente),
          );
        },

        separatorBuilder: (_, _) => const SizedBox(height: 12),
      ),
    );
  }
}
