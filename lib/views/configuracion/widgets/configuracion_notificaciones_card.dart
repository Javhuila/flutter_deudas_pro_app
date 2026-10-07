import 'package:flutter/material.dart';

import '../../../models/configuracion.dart';

class ConfiguracionNotificacionesCard extends StatelessWidget {
  const ConfiguracionNotificacionesCard({
    super.key,
    required this.configuracion,
    required this.onNotificacionesChanged,
    required this.onDiasAnticipacionChanged,
    required this.onDeudasVencidasChanged,
    required this.onPagosPendientesChanged,
    required this.onHoraNotificacionChanged,
  });

  final Configuracion configuracion;

  final ValueChanged<bool> onNotificacionesChanged;
  final ValueChanged<int> onDiasAnticipacionChanged;
  final ValueChanged<bool> onDeudasVencidasChanged;
  final ValueChanged<bool> onPagosPendientesChanged;
  final ValueChanged<TimeOfDay> onHoraNotificacionChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final hora = TimeOfDay(
      hour: configuracion.horaNotificacion,
      minute: configuracion.minutoNotificacion,
    );

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notificaciones',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Controla los avisos relacionados con tus deudas y pagos.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 12),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: configuracion.notificacionesActivas,
              secondary: const Icon(Icons.notifications_outlined),
              title: const Text('Notificaciones'),
              subtitle: const Text('Activar los avisos de la aplicación.'),
              onChanged: onNotificacionesChanged,
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.access_time),
              title: const Text('Hora de notificación'),
              subtitle: Text('Todos los días a las ${hora.format(context)}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _mostrarSelectorHora(context, hora),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text('Anticipación'),
              subtitle: Text(
                '${configuracion.diasAnticipacion} '
                '${configuracion.diasAnticipacion == 1 ? 'día' : 'días'} '
                'antes del vencimiento',
              ),
              trailing: const Icon(Icons.chevron_right),
              enabled: configuracion.notificacionesActivas,
              onTap: configuracion.notificacionesActivas
                  ? () {
                      _mostrarSelectorDias(context);
                    }
                  : null,
            ),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: configuracion.notificarDeudasVencidas,
              secondary: const Icon(Icons.warning_amber_outlined),
              title: const Text('Deudas vencidas'),
              subtitle: const Text('Avisar cuando existan deudas vencidas.'),
              onChanged: configuracion.notificacionesActivas
                  ? onDeudasVencidasChanged
                  : null,
            ),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: configuracion.notificarPagosPendientes,
              secondary: const Icon(Icons.payments_outlined),
              title: const Text('Pagos pendientes'),
              subtitle: const Text('Avisar sobre pagos pendientes.'),
              onChanged: configuracion.notificacionesActivas
                  ? onPagosPendientesChanged
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _mostrarSelectorDias(BuildContext context) async {
    final opciones = [0, 1, 2, 3, 5, 7, 15, 30];

    final resultado = await showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Días de anticipación'),
          children: [
            for (final dias in opciones)
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(dias);
                },
                child: Text(
                  dias == 0
                      ? 'El mismo día'
                      : '$dias ${dias == 1 ? 'día' : 'días'} antes',
                ),
              ),
          ],
        );
      },
    );

    if (resultado == null) {
      return;
    }

    onDiasAnticipacionChanged(resultado);
  }

  Future<void> _mostrarSelectorHora(
    BuildContext context,
    TimeOfDay horaActual,
  ) async {
    final resultado = await showTimePicker(
      context: context,
      initialTime: horaActual,
      helpText: 'Selecciona la hora de los avisos',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (resultado != null) {
      onHoraNotificacionChanged(resultado);
    }
  }
}
