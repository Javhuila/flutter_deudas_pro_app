import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enums/frecuencia_backup.dart';
import '../../models/configuracion.dart';
import '../../models/respaldo.dart';
import '../../providers/configuracion_provider.dart';
import '../../providers/respaldo_provider.dart';
import 'respaldo_restore_page.dart';
import 'widgets/respaldo_automatico_card.dart';
import 'widgets/respaldo_backup_card.dart';
import 'widgets/respaldo_destino_card.dart';
import 'widgets/respaldo_empty.dart';
import 'widgets/respaldo_error.dart';
import 'widgets/respaldo_fab.dart';
import 'widgets/respaldo_historial_card.dart';
import 'widgets/respaldo_info_card.dart';
import 'widgets/respaldo_loading.dart';
import 'widgets/respaldo_restore_card.dart';

class RespaldoPage extends ConsumerStatefulWidget {
  const RespaldoPage({super.key});

  @override
  ConsumerState<RespaldoPage> createState() => _RespaldoPageState();
}

class _RespaldoPageState extends ConsumerState<RespaldoPage> {
  bool _backupAutomatico = false;
  FrecuenciaBackup _frecuenciaBackup = FrecuenciaBackup.semanal;
  TimeOfDay _horaBackup = const TimeOfDay(hour: 22, minute: 0);

  String? _carpetaBackup;

  String? _carpetaBackupUri;
  bool _guardandoConfiguracion = false;

  bool _seleccionandoCarpeta = false;

  @override
  void initState() {
    super.initState();
    // RespaldoNotifier ya ejecuta cargar() en su constructor.
    //
    // Por lo tanto, no necesitamos llamar manualmente:
    //
    // ref.read(respaldoProvider.notifier).cargar();
    //
    // Aquí posteriormente podremos cargar la configuración
    // desde ConfiguracionProvider.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cargarConfiguracionInicial();
    });
  }

  Future<void> _cargarConfiguracionInicial() async {
    final configuracionState = ref.read(configuracionProvider);

    if (configuracionState.configuracion != null) {
      _aplicarConfiguracion(configuracionState.configuracion!);
      return;
    }

    // ConfiguracionProvider todavía está cargando.
    // Esperamos a que termine antes de sincronizar los valores locales.
    try {
      await ref.read(configuracionProvider.notifier).cargar();

      if (!mounted) {
        return;
      }

      final configuracion = ref.read(configuracionProvider).configuracion;

      if (configuracion == null) {
        return;
      }

      _aplicarConfiguracion(configuracion);
    } catch (_) {
      // El error ya queda registrado en ConfiguracionProvider.
    }
  }

  void _aplicarConfiguracion(Configuracion configuracion) {
    if (!mounted) {
      return;
    }

    setState(() {
      _backupAutomatico = configuracion.backupAutomatico;

      _frecuenciaBackup = configuracion.frecuenciaBackup;

      _horaBackup = TimeOfDay(
        hour: configuracion.horaBackup,
        minute: configuracion.minutoBackup,
      );

      _carpetaBackup = configuracion.carpetaBackup;

      _carpetaBackupUri = configuracion.carpetaBackupUri;
    });
  }

  @override
  Widget build(BuildContext context) {
    final estado = ref.watch(respaldoProvider);
    final theme = Theme.of(context);
    final configuracionState = ref.watch(configuracionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguridad y respaldo'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: _buildBody(context, theme, estado, configuracionState),
      floatingActionButton: RespaldoFab(
        onCrearCopia: estado.loading ? null : _crearCopiaAhora,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ThemeData theme,
    RespaldoState estado,
    ConfiguracionState configuracionState,
  ) {
    if (estado.loading && estado.respaldos.isEmpty) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: const [RespaldoLoading()],
      );
    }

    if (estado.hayError && estado.respaldos.isEmpty) {
      return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [RespaldoError(mensaje: estado.error, onRetry: _refrescar)],
      );
    }

    if (estado.isEmpty) {
      return RefreshIndicator(
        onRefresh: _refrescar,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [RespaldoEmpty(onCreateBackup: _crearCopiaAhora)],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refrescar,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ==================================================
                // COPIA MANUAL
                // ==================================================
                RespaldoBackupCard(
                  ultimaCopia: estado.ultimo?.fecha,
                  creando: estado.loading,
                  onCrearCopia: _crearCopiaAhora,
                ),

                const SizedBox(height: 24),

                // ==================================================
                // COPIAS AUTOMÁTICAS
                // ==================================================
                RespaldoAutomaticoCard(
                  activado: _backupAutomatico,
                  frecuencia: _frecuenciaBackup,
                  hora: _horaBackup,
                  guardando: _guardandoConfiguracion,
                  onActivarChanged: _cambiarBackupAutomatico,
                  onFrecuenciaChanged: _cambiarFrecuencia,
                  onHoraChanged: _cambiarHora,
                ),

                const SizedBox(height: 24),

                // ==================================================
                // DESTINO
                // ==================================================
                RespaldoDestinoCard(
                  carpeta: _carpetaBackup,
                  carpetaUri: _carpetaBackupUri,
                  seleccionando: _seleccionandoCarpeta,
                  onSeleccionarCarpeta: _seleccionarCarpeta,
                  onRestablecerCarpeta: _restablecerCarpeta,
                ),

                const SizedBox(height: 24),

                // ==================================================
                // RESTAURAR
                // ==================================================
                RespaldoRestoreCard(
                  restaurando: estado.loading,
                  onSeleccionarCopia: _seleccionarCopia,
                  onRestaurar: _restaurarCopia,
                ),

                const SizedBox(height: 24),

                // ==================================================
                // INFORMACIÓN DE LA ÚLTIMA COPIA
                // ==================================================
                RespaldoInfoCard(respaldo: estado.ultimo),

                const SizedBox(height: 24),

                // ==================================================
                // HISTORIAL
                // ==================================================
                RespaldoHistorialCard(
                  respaldos: estado.respaldos,
                  onVerDetalle: _verDetalleRespaldo,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  //Crear Copia
  Future<void> _crearCopiaAhora() async {
    final configuracion = ref.read(configuracionProvider).configuracion;

    final destino = configuracion?.carpetaBackup;
    if (!mounted) {
      return;
    }

    try {
      final resultado = await ref
          .read(respaldoProvider.notifier)
          .crearBackup(destinationDirectory: destino);

      if (resultado.success) {
        await ref.read(configuracionProvider.notifier).refrescar();
      }

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            resultado.success
                ? 'La copia de seguridad se creó correctamente.'
                : resultado.message ??
                      'No se pudo crear la copia de seguridad.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al crear la copia: $e')));
    }
  }

  // ==========================================================
  // RESTAURAR COPIA
  // ==========================================================
  // Future<void> _abrirCarpetaBackup() async {
  //   final carpeta = _carpetaBackup;

  //   if (carpeta == null || carpeta.trim().isEmpty) {
  //     return;
  //   }

  //   try {
  //     await OpenFilex.open(carpeta);
  //   } catch (e) {
  //     if (!mounted) {
  //       return;
  //     }

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('No se pudo abrir la carpeta: $e')),
  //     );
  //   }
  // }

  Future<void> _seleccionarCopia() async {
    await _restaurarCopia();
  }

  Future<void> _restaurarCopia() async {
    // Esta acción se ejecutará realmente desde
    // RespaldoRestorePage, que ya contiene:
    //
    // - selección del archivo
    // - confirmación
    // - llamada a restaurar
    // - manejo del resultado
    //
    // Por eso aquí no debemos duplicar esa lógica.
    await _abrirRestauracion();
  }

  Future<void> _abrirRestauracion() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => RespaldoRestorePage(
          onRestaurar: (rutaArchivo) {
            return ref
                .read(respaldoProvider.notifier)
                .restaurarBackup(rutaArchivo);
          },
        ),
      ),
    );

    if (resultado != true || !mounted) {
      return;
    }

    await ref.read(respaldoProvider.notifier).refrescar();

    await ref.read(configuracionProvider.notifier).refrescar();

    if (!mounted) {
      return;
    }

    final cerrarAplicacion = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Restauración completada'),
          content: const Text(
            'La copia de seguridad se restauró correctamente. '
            'Para aplicar todos los cambios, debes cerrar la aplicación '
            'y volver a abrirla.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Más tarde'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Cerrar aplicación'),
            ),
          ],
        );
      },
    );

    if (cerrarAplicacion == true) {
      await SystemNavigator.pop();
    }
  }

  // ==========================================================
  // DESTINO
  // ==========================================================

  Future<void> _seleccionarCarpeta() async {
    if (_seleccionandoCarpeta) {
      return;
    }

    setState(() {
      _seleccionandoCarpeta = true;
    });

    try {
      //  TUDO-LIST-SELECT
      // Aquí se debe conectar el selector de carpetas
      // y posteriormente ConfiguracionProvider.
      final directorio = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Seleccionar carpeta para copias de seguridad',
      );

      if (directorio == null || directorio.trim().isEmpty) {
        return;
      }

      await ref
          .read(configuracionProvider.notifier)
          .actualizarCarpetaBackup(directorio, null);

      if (!mounted) {
        return;
      }

      setState(() {
        _carpetaBackup = directorio;
        _carpetaBackupUri = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Carpeta de respaldo actualizada.')),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo seleccionar la carpeta: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _seleccionandoCarpeta = false;
        });
      }
    }
  }

  Future<void> _restablecerCarpeta() async {
    // TUDO:
    // Actualizar ConfiguracionProvider
    // para eliminar el destino configurado.
    if (_guardandoConfiguracion) {
      return;
    }

    setState(() {
      _guardandoConfiguracion = true;
    });

    try {
      await ref
          .read(configuracionProvider.notifier)
          .actualizarCarpetaBackup(null, null);

      if (!mounted) {
        return;
      }

      setState(() {
        _carpetaBackup = null;
        _carpetaBackupUri = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se restableció la carpeta de respaldo.')),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo restablecer la carpeta: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _guardandoConfiguracion = false;
        });
      }
    }
  }

  Future<void> _refrescar() async {
    await Future.wait([
      ref.read(respaldoProvider.notifier).refrescar(),
      ref.read(configuracionProvider.notifier).refrescar(),
    ]);

    if (!mounted) {
      return;
    }

    final configuracion = ref.read(configuracionProvider).configuracion;

    if (configuracion != null) {
      _aplicarConfiguracion(configuracion);
    }
  }

  Future<void> _cambiarBackupAutomatico(bool valor) async {
    // TUDO:
    // Aquí debe llamarse al ConfiguracionProvider.
    // No invento el método porque todavía no tenemos
    // el código de ConfiguracionProvider.
    if (_guardandoConfiguracion) {
      return;
    }

    setState(() {
      _backupAutomatico = valor;
      _guardandoConfiguracion = true;
    });

    try {
      await ref
          .read(configuracionProvider.notifier)
          .cambiarBackupAutomatico(valor);
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _backupAutomatico = !valor;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo actualizar la copia automática: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _guardandoConfiguracion = false;
        });
      }
    }
  }

  Future<void> _cambiarFrecuencia(FrecuenciaBackup frecuencia) async {
    // TUDO:
    // Actualizar mediante ConfiguracionProvider.
    if (_guardandoConfiguracion) {
      return;
    }

    final frecuenciaAnterior = _frecuenciaBackup;

    setState(() {
      _frecuenciaBackup = frecuencia;
      _guardandoConfiguracion = true;
    });

    try {
      await ref
          .read(configuracionProvider.notifier)
          .cambiarFrecuenciaBackup(frecuencia);
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _frecuenciaBackup = frecuenciaAnterior;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo actualizar la frecuencia: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _guardandoConfiguracion = false;
        });
      }
    }
  }

  Future<void> _cambiarHora(TimeOfDay hora) async {
    setState(() {
      _horaBackup = hora;
    });
    // TUDO:
    // Actualizar mediante ConfiguracionProvider.
    if (_guardandoConfiguracion) {
      return;
    }

    final horaAnterior = _horaBackup;

    setState(() {
      _horaBackup = hora;
      _guardandoConfiguracion = true;
    });

    try {
      await ref
          .read(configuracionProvider.notifier)
          .actualizarHoraBackup(hora.hour, hora.minute);
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _horaBackup = horaAnterior;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo actualizar la hora: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _guardandoConfiguracion = false;
        });
      }
    }
  }

  // ==========================================================
  // HISTORIAL
  // ==========================================================

  void _verDetalleRespaldo(Respaldo respaldo) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Detalle del respaldo'),
          content: SingleChildScrollView(
            child: RespaldoInfoCard(respaldo: respaldo),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
