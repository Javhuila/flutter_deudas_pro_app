import 'package:flutter/material.dart';

import '../../../models/deuda.dart';
import 'deuda_card.dart';

class DeudaList extends StatelessWidget {
  const DeudaList({
    super.key,
    required this.deudas,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onCancel,
    this.onArchive,
  });

  final List<Deuda> deudas;

  final ValueChanged<Deuda>? onTap;

  final ValueChanged<Deuda>? onEdit;
  final ValueChanged<Deuda>? onDelete;

  final ValueChanged<Deuda>? onCancel;
  final ValueChanged<Deuda>? onArchive;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: deudas.length,

        itemBuilder: (context, index) {
          final deuda = deudas[index];

          return DeudaCard(
            deuda: deuda,
            onTap: () => onTap?.call(deuda),
            onEdit: () => onEdit?.call(deuda),
            onDelete: () => onDelete?.call(deuda),
            onCancel: () => onCancel?.call(deuda),
            onArchive: () => onArchive?.call(deuda),
          );
        },

        separatorBuilder: (_, _) => const SizedBox(height: 12),
      ),
    );
  }
}
