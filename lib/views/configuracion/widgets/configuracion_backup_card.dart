import 'package:flutter/material.dart';

import '../../../core/enums/frecuencia_backup.dart';
import '../../../models/configuracion.dart';

class ConfiguracionBackupCard extends StatelessWidget {
  const ConfiguracionBackupCard({
    super.key,
    required this.configuracion,
    required this.onBackupAutomaticoChanged,
    required this.onFrecuenciaChanged,
    required this.onHoraChanged,
    required this.onMaximoBackupsChanged,
    required this.onSeleccionarCarpeta,
  });

  final Configuracion configuracion;

  final ValueChanged<bool> onBackupAutomaticoChanged;
  final ValueChanged<FrecuenciaBackup> onFrecuenciaChanged;
  final ValueChanged<TimeOfDay> onHoraChanged;
  final ValueChanged<int> onMaximoBackupsChanged;
  final VoidCallback onSeleccionarCarpeta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final hora = TimeOfDay(
      hour: configuracion.horaBackup,
      minute: configuracion.minutoBackup,
    );

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.backup_outlined,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Copias de seguridad',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Controla cuándo y dónde se realizan las copias.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: configuracion.backupAutomatico,
              secondary: const Icon(Icons.autorenew_outlined),
              title: const Text('Copia automática'),
              subtitle: const Text(
                'Realizar copias según la programación configurada.',
              ),
              onChanged: onBackupAutomaticoChanged,
            ),

            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              enabled: configuracion.backupAutomatico,
              leading: const Icon(Icons.repeat_outlined),
              title: const Text('Frecuencia'),
              subtitle: Text(
                _formatearFrecuencia(configuracion.frecuenciaBackup),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: configuracion.backupAutomatico
                  ? () => _seleccionarFrecuencia(context)
                  : null,
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              enabled: configuracion.backupAutomatico,
              leading: const Icon(Icons.schedule_outlined),
              title: const Text('Hora'),
              subtitle: Text(_formatearHora(context, hora)),
              trailing: const Icon(Icons.chevron_right),
              onTap: configuracion.backupAutomatico
                  ? () => _seleccionarHora(context, hora)
                  : null,
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.folder_outlined),
              title: const Text('Carpeta de destino'),
              subtitle: Text(
                configuracion.carpetaBackup?.trim().isNotEmpty == true
                    ? configuracion.carpetaBackup!.trim()
                    : 'No configurada',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: onSeleccionarCarpeta,
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.storage_outlined),
              title: const Text('Máximo de respaldos'),
              subtitle: Text(
                '${configuracion.maximoBackups} '
                '${configuracion.maximoBackups == 1 ? 'copia' : 'copias'}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _seleccionarMaximoBackups(context),
            ),

            if (configuracion.ultimoBackup != null) ...[
              const Divider(),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.history_outlined),
                title: const Text('Última copia'),
                subtitle: Text(
                  _formatearFechaHora(configuracion.ultimoBackup!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _seleccionarFrecuencia(BuildContext context) async {
    final resultado = await showDialog<FrecuenciaBackup>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Frecuencia de copia'),

          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(FrecuenciaBackup.diaria);
              },
              child: const Text('Diaria'),
            ),

            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(FrecuenciaBackup.semanal);
              },
              child: const Text('Semanal'),
            ),

            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop(FrecuenciaBackup.mensual);
              },
              child: const Text('Mensual'),
            ),
          ],
        );
      },
    );

    if (resultado == null) {
      return;
    }

    onFrecuenciaChanged(resultado);
  }

  Future<void> _seleccionarHora(
    BuildContext context,
    TimeOfDay horaInicial,
  ) async {
    final resultado = await showTimePicker(
      context: context,
      initialTime: horaInicial,
      helpText: 'Seleccione el tiempo para la copia',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (resultado == null) {
      return;
    }

    onHoraChanged(resultado);
  }

  Future<void> _seleccionarMaximoBackups(BuildContext context) async {
    final opciones = [3, 5, 10, 15, 20, 30, 50];

    final resultado = await showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Máximo de respaldos'),

          children: [
            for (final cantidad in opciones)
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(cantidad);
                },
                child: Text('$cantidad ${cantidad == 1 ? 'copia' : 'copias'}'),
              ),
          ],
        );
      },
    );

    if (resultado == null) {
      return;
    }

    onMaximoBackupsChanged(resultado);
  }

  String _formatearFrecuencia(FrecuenciaBackup frecuencia) {
    switch (frecuencia) {
      case FrecuenciaBackup.diaria:
        return 'Diaria';

      case FrecuenciaBackup.semanal:
        return 'Semanal';

      case FrecuenciaBackup.mensual:
        return 'Mensual';
    }
  }

  String _formatearHora(BuildContext context, TimeOfDay hora) {
    return hora.format(context);
  }

  String _formatearFechaHora(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    final anio = fecha.year;

    final hora12 = fecha.hour % 12 == 0 ? 12 : fecha.hour % 12;

    final minuto = fecha.minute.toString().padLeft(2, '0');

    final periodo = fecha.hour >= 12 ? 'PM' : 'AM';

    return '$dia/$mes/$anio - '
        '$hora12:$minuto $periodo';
  }
}
