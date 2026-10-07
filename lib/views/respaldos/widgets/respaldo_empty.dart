import 'package:flutter/material.dart';

class RespaldoEmpty extends StatelessWidget {
  const RespaldoEmpty({super.key, this.onCreateBackup});

  final VoidCallback? onCreateBackup;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  Icons.backup_outlined,
                  size: 42,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'No hay copias de seguridad',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Todavía no se ha creado ninguna copia de seguridad de tus datos.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              FilledButton.icon(
                onPressed: onCreateBackup,
                icon: const Icon(Icons.backup_outlined),
                label: const Text('Crear copia ahora'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
