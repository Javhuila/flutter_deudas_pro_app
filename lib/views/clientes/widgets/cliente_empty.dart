import 'package:flutter/material.dart';

class ClienteEmpty extends StatelessWidget {
  const ClienteEmpty({super.key, this.onNuevoCliente});

  final VoidCallback? onNuevoCliente;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_outline_rounded,
                size: 96,
                color: theme.colorScheme.primary.withValues(alpha: 0.7),
              ),

              const SizedBox(height: 24),

              Text(
                'No hay clientes registrados',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Comienza registrando tu primer cliente para poder administrar préstamos, pagos y deudas.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 32),

              FilledButton.icon(
                onPressed: onNuevoCliente,
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text('Registrar cliente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
