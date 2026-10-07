import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/configuracion_provider.dart';
import 'widgets/configuracion_backup_card.dart';
import 'widgets/configuracion_error.dart';
import 'widgets/configuracion_exportaciones_card.dart';
import 'widgets/configuracion_general_card.dart';
import 'widgets/configuracion_loading.dart';
import 'widgets/configuracion_notificaciones_card.dart';
import 'widgets/configuracion_restaurar_card.dart';

class ConfiguracionPage extends ConsumerWidget {
  const ConfiguracionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(configuracionProvider);

    if (state.loading && !state.cargada) {
      return Scaffold(
        appBar: AppBar(title: Text('Configuración')),
        body: ConfiguracionLoading(),
      );
    }

    if (state.hayError && !state.cargada) {
      return Scaffold(
        appBar: AppBar(title: const Text('Configuración')),
        body: ConfiguracionError(
          mensaje: state.error,
          onRetry: () {
            ref.read(configuracionProvider.notifier).refrescar();
          },
        ),
      );
    }

    final configuracion = state.configuracion;

    if (configuracion == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Configuración')),
        body: ConfiguracionError(
          mensaje: 'No se pudo obtener la configuración.',
          onRetry: () {
            ref.read(configuracionProvider.notifier).refrescar();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return ref.read(configuracionProvider.notifier).refrescar();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              ConfiguracionGeneralCard(
                configuracion: configuracion,
                onTemaOscuroChanged: (valor) {
                  ref
                      .read(configuracionProvider.notifier)
                      .cambiarTemaOscuro(valor);
                },
              ),

              const SizedBox(height: 16),

              ConfiguracionNotificacionesCard(
                configuracion: configuracion,
                onNotificacionesChanged: (valor) {
                  ref
                      .read(configuracionProvider.notifier)
                      .cambiarNotificaciones(valor);
                },
                onHoraNotificacionChanged: (hora) {
                  ref
                      .read(configuracionProvider.notifier)
                      .actualizarHoraNotificacion(hora.hour, hora.minute);
                },
                onDiasAnticipacionChanged: (dias) {
                  ref
                      .read(configuracionProvider.notifier)
                      .actualizarDiasAnticipacion(dias);
                },
                onDeudasVencidasChanged: (valor) {
                  ref
                      .read(configuracionProvider.notifier)
                      .cambiarAvisoDeudasVencidas(valor);
                },
                onPagosPendientesChanged: (valor) {
                  ref
                      .read(configuracionProvider.notifier)
                      .cambiarAvisoPagosPendientes(valor);
                },
              ),

              const SizedBox(height: 16),

              ConfiguracionBackupCard(
                configuracion: configuracion,
                onBackupAutomaticoChanged: (valor) {
                  ref
                      .read(configuracionProvider.notifier)
                      .cambiarBackupAutomatico(valor);
                },
                onFrecuenciaChanged: (frecuencia) {
                  ref
                      .read(configuracionProvider.notifier)
                      .cambiarFrecuenciaBackup(frecuencia);
                },
                onHoraChanged: (hora) {
                  ref
                      .read(configuracionProvider.notifier)
                      .actualizarHoraBackup(hora.hour, hora.minute);
                },
                onMaximoBackupsChanged: (cantidad) {
                  ref
                      .read(configuracionProvider.notifier)
                      .actualizarMaximoBackups(cantidad);
                },
                onSeleccionarCarpeta: () {
                  _seleccionarCarpeta(context, ref);
                },
              ),

              const SizedBox(height: 16),

              ConfiguracionExportacionesCard(
                configuracion: configuracion,
                onExportarPdfChanged: (valor) {
                  ref
                      .read(configuracionProvider.notifier)
                      .cambiarExportarPdf(valor);
                },
                onExportarExcelChanged: (valor) {
                  ref
                      .read(configuracionProvider.notifier)
                      .cambiarExportarExcel(valor);
                },
              ),

              const SizedBox(height: 16),

              ConfiguracionRestaurarCard(
                onRestaurar: () {
                  _mostrarDialogoRestaurar(context, ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _seleccionarCarpeta(BuildContext context, WidgetRef ref) async {
    final directorio = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Seleccionar carpeta para copias de seguridad',
    );

    if (directorio == null || directorio.trim().isEmpty) {
      return;
    }

    await ref
        .read(configuracionProvider.notifier)
        .actualizarCarpetaBackup(directorio, null);
  }

  Future<void> _mostrarDialogoRestaurar(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Restaurar configuración'),
          content: const Text(
            'Se restablecerán todas las opciones de configuración '
            'a sus valores predeterminados. '
            'Esta acción no elimina tus clientes, deudas ni pagos.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Restaurar'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    await ref.read(configuracionProvider.notifier).restaurarValores();
  }
}
