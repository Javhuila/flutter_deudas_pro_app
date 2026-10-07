import 'package:flutter/material.dart';

import '../../widgets/app_action_card.dart';

class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({
    super.key,
    this.onNuevoCliente,
    this.onNuevaDeuda,
    this.onRegistrarPago,
    this.onCrearRespaldo,
  });

  final VoidCallback? onNuevoCliente;
  final VoidCallback? onNuevaDeuda;
  final VoidCallback? onRegistrarPago;
  final VoidCallback? onCrearRespaldo;

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    final scale = textScaler.scale(1.25);

    final mainAxisExtent = 150 + ((scale - 1.0) * 100);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acciones rápidas',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: mainAxisExtent,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return AppActionCard(
                    icon: Icons.person_add_alt_1,
                    title: 'Nuevo cliente',
                    subtitle: 'Registrar cliente',
                    onTap: onNuevoCliente,
                  );

                case 1:
                  return AppActionCard(
                    icon: Icons.add_card,
                    title: 'Nueva deuda',
                    subtitle: 'Registrar préstamo',
                    onTap: onNuevaDeuda,
                  );

                case 2:
                  return AppActionCard(
                    icon: Icons.payments_outlined,
                    title: 'Registrar pago',
                    subtitle: 'Abonar deuda',
                    onTap: onRegistrarPago,
                  );

                case 3:
                  return AppActionCard(
                    icon: Icons.backup_outlined,
                    title: 'Crear respaldo',
                    subtitle: 'Guardar copia',
                    onTap: onCrearRespaldo,
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
