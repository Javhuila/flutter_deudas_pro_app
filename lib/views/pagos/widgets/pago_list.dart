import 'package:flutter/material.dart';

import '../../../models/pago.dart';
import 'pago_card.dart';

class PagoList extends StatelessWidget {
  const PagoList({
    super.key,
    required this.pagos,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final List<Pago> pagos;

  final ValueChanged<Pago>? onTap;

  final ValueChanged<Pago>? onEdit;

  final ValueChanged<Pago>? onDelete;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: pagos.length,

        itemBuilder: (context, index) {
          final pago = pagos[index];

          return PagoCard(
            pago: pago,
            onTap: () => onTap?.call(pago),
            onEdit: () => onEdit?.call(pago),
            onDelete: () => onDelete?.call(pago),
          );
        },

        separatorBuilder: (_, _) => const SizedBox(height: 12),
      ),
    );
  }
}
