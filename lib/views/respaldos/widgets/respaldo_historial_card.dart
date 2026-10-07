import 'package:flutter/material.dart';

import '../../../models/respaldo.dart';
import 'respaldo_historial_item.dart';

class RespaldoHistorialCard extends StatelessWidget {
  const RespaldoHistorialCard({
    super.key,
    required this.respaldos,
    this.onVerDetalle,
  });

  final List<Respaldo> respaldos;

  final ValueChanged<Respaldo>? onVerDetalle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (respaldos.isEmpty) {
      return Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.history_outlined,
                size: 40,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 12),
              Text(
                'Sin historial',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Aún no se han realizado copias de seguridad.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Icon(Icons.history_outlined, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Historial',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${respaldos.length}',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: respaldos.length,
            itemBuilder: (context, index) {
              final respaldo = respaldos[index];

              return RespaldoHistorialItem(
                respaldo: respaldo,
                onTap: onVerDetalle == null
                    ? null
                    : () => onVerDetalle!.call(respaldo),
              );
            },
            separatorBuilder: (_, _) => const Divider(height: 1, indent: 72),
          ),
        ],
      ),
    );
  }
}
