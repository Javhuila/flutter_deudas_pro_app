import 'package:flutter/material.dart';

import '../../../core/enums/frecuencia_backup.dart';

class RespaldoAutomaticoCard extends StatelessWidget {
  const RespaldoAutomaticoCard({
    super.key,
    required this.activado,
    required this.frecuencia,
    required this.hora,
    this.guardando = false,
    this.onActivarChanged,
    this.onFrecuenciaChanged,
    this.onHoraChanged,
  });

  /// Indica si las copias automáticas están activadas.
  final bool activado;

  /// Frecuencia actualmente seleccionada.
  final FrecuenciaBackup frecuencia;

  /// Hora programada para la copia.
  final TimeOfDay hora;

  /// Indica si se está guardando la configuración.
  final bool guardando;

  final ValueChanged<bool>? onActivarChanged;

  final ValueChanged<FrecuenciaBackup>? onFrecuenciaChanged;

  final ValueChanged<TimeOfDay>? onHoraChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Copias automáticas',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Programa copias de seguridad automáticas '
              'de la información de la aplicación.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: activado,
              secondary: Icon(
                activado ? Icons.autorenew : Icons.pause_circle_outline,
              ),
              title: const Text('Activar copias automáticas'),
              subtitle: Text(
                activado
                    ? 'Las copias se realizarán según la programación.'
                    : 'Las copias automáticas están desactivadas.',
              ),
              onChanged: guardando ? null : onActivarChanged,
            ),

            const Divider(),

            const SizedBox(height: 8),

            Text(
              'Frecuencia',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            RadioGroup<FrecuenciaBackup>(
              groupValue: frecuencia,
              onChanged: (value) {
                if (guardando || value == null) {
                  return;
                }

                onFrecuenciaChanged?.call(value);
              },
              child: Column(
                children: [
                  RadioListTile<FrecuenciaBackup>(
                    contentPadding: EdgeInsets.zero,
                    value: FrecuenciaBackup.diaria,
                    title: const Text('Diaria'),
                    subtitle: const Text('Realizar una copia todos los días.'),
                  ),

                  RadioListTile<FrecuenciaBackup>(
                    contentPadding: EdgeInsets.zero,
                    value: FrecuenciaBackup.semanal,
                    title: const Text('Semanal'),
                    subtitle: const Text(
                      'Realizar una copia una vez por semana.',
                    ),
                  ),

                  RadioListTile<FrecuenciaBackup>(
                    contentPadding: EdgeInsets.zero,
                    value: FrecuenciaBackup.mensual,
                    title: const Text('Mensual'),
                    subtitle: const Text('Realizar una copia una vez al mes.'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            ListTile(
              contentPadding: EdgeInsets.zero,
              enabled: !guardando,
              leading: const Icon(Icons.schedule_outlined),
              title: const Text('Hora'),
              subtitle: Text(_formatearHora(hora)),
              trailing: const Icon(Icons.chevron_right),
              onTap: guardando
                  ? null
                  : () async {
                      final nuevaHora = await _seleccionarHora(context, hora);

                      if (nuevaHora != null) {
                        onHoraChanged?.call(nuevaHora);
                      }
                    },
            ),

            if (guardando) ...[
              const SizedBox(height: 8),

              const LinearProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }

  Future<TimeOfDay?> _seleccionarHora(
    BuildContext context,
    TimeOfDay horaActual,
  ) {
    return showTimePicker(context: context, initialTime: horaActual);
  }

  static String _formatearHora(TimeOfDay hora) {
    final hora12 = hora.hourOfPeriod == 0 ? 12 : hora.hourOfPeriod;

    final minuto = hora.minute.toString().padLeft(2, '0');

    final periodo = hora.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hora12:$minuto $periodo';
  }
}
