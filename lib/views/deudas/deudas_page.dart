import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/configuracion_provider.dart';
import '../../providers/deuda_provider.dart';
import '../../providers/file_share_provider.dart';
import 'deuda_form_page.dart';
import 'dialog/deuda_archive_dialog.dart';
import 'dialog/deuda_cancel_dialog.dart';
import 'dialog/deuda_delete_dialog.dart';
import 'info_deuda.dart';
import 'sheets/deuda_filter_sheet.dart';
import 'widgets/deuda_empty.dart';
import 'widgets/deuda_error.dart';
import 'widgets/deuda_fab.dart';
import 'widgets/deuda_filter_bar.dart';
import 'widgets/deuda_list.dart';
import 'widgets/deuda_loading.dart';
import 'widgets/deuda_search_bar.dart';

class DeudasPage extends ConsumerStatefulWidget {
  const DeudasPage({super.key});

  @override
  ConsumerState<DeudasPage> createState() => _DeudasPageState();
}

class _DeudasPageState extends ConsumerState<DeudasPage>
    with SingleTickerProviderStateMixin {
  bool _exportando = false;
  late final AnimationController _controller;
  late final TextEditingController _busquedaController;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _iniciarAnimacion();
    _busquedaController = TextEditingController();
  }

  Future<void> _iniciarAnimacion() async {
    while (mounted) {
      // Espera inicial.
      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;

      // Se mueve hacia la derecha.
      await _controller.forward();

      if (!mounted) return;

      // Permanece 3 segundos en la posición final.
      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;

      // Regresa a la posición inicial.
      await _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchFocusNode.dispose();
    _busquedaController.dispose();
    super.dispose();
  }
  //==========================================================
  // MENÚ DE EXPORTACIÓN
  //==========================================================

  PopupMenuButton<String> _construirMenuExportacion(
    BuildContext context,
    bool exportarPdf,
    bool exportarExcel,
  ) {
    final opcionesDisponibles = <PopupMenuEntry<String>>[];

    if (exportarPdf) {
      opcionesDisponibles.add(
        const PopupMenuItem<String>(
          value: 'pdf',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.picture_as_pdf_outlined),
            title: Text('Exportar PDF'),
          ),
        ),
      );
    }

    if (exportarExcel) {
      opcionesDisponibles.add(
        const PopupMenuItem<String>(
          value: 'excel',
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.table_chart_outlined),
            title: Text('Exportar Excel'),
          ),
        ),
      );
    }

    // Si ambos formatos están desactivados,
    // no mostramos el menú.
    if (opcionesDisponibles.isEmpty) {
      return PopupMenuButton<String>(
        enabled: false,
        icon: const Icon(Icons.file_download_outlined),
        itemBuilder: (_) => const [],
      );
    }

    return PopupMenuButton<String>(
      icon: const Icon(Icons.file_download_outlined),

      tooltip: 'Exportar deudas',

      onSelected: (opcion) {
        switch (opcion) {
          case 'pdf':
            _exportarTodasPdf();
            break;

          case 'excel':
            _exportarTodasExcel();
            break;
        }
      },

      itemBuilder: (_) {
        return opcionesDisponibles;
      },
    );
  }

  //==========================================================
  // EXPORTAR TODAS - PDF
  //==========================================================

  Future<void> _exportarTodasPdf() async {
    if (_exportando) {
      return;
    }

    final configuracion = ref.read(configuracionProvider).configuracion;

    if (configuracion == null) {
      _mostrarMensaje('No se pudo obtener la configuración.');
      return;
    }

    if (!configuracion.exportarPdf) {
      _mostrarMensaje('La exportación a PDF está desactivada.');
      return;
    }

    final deudas = ref.read(deudaProvider).deudas;

    if (deudas.isEmpty) {
      _mostrarMensaje('No existen deudas para exportar.');
      return;
    }

    setState(() {
      _exportando = true;
    });

    try {
      final exportService = ref.read(deudaExportServiceProvider);

      final archivo = await exportService.exportarTodasPdf();

      if (!mounted) {
        return;
      }

      await _mostrarResultadoExportacion(
        archivo,
        'PDF generado correctamente.',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL EXPORTAR DEUDAS A PDF: $e');

      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) {
        return;
      }

      _mostrarMensaje('No se pudo generar el PDF: $e');
    } finally {
      if (mounted) {
        setState(() {
          _exportando = false;
        });
      }
    }
  }

  //==========================================================
  // EXPORTAR TODAS - EXCEL
  //==========================================================

  Future<void> _exportarTodasExcel() async {
    if (_exportando) {
      return;
    }

    final configuracion = ref.read(configuracionProvider).configuracion;

    if (configuracion == null) {
      _mostrarMensaje('No se pudo obtener la configuración.');
      return;
    }

    if (!configuracion.exportarExcel) {
      _mostrarMensaje('La exportación a Excel está desactivada.');
      return;
    }

    final deudas = ref.read(deudaProvider).deudas;

    if (deudas.isEmpty) {
      _mostrarMensaje('No existen deudas para exportar.');
      return;
    }

    setState(() {
      _exportando = true;
    });

    try {
      final exportService = ref.read(deudaExportServiceProvider);

      final archivo = await exportService.exportarTodasExcel();

      if (!mounted) {
        return;
      }

      await _mostrarResultadoExportacion(
        archivo,
        'Excel generado correctamente.',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL EXPORTAR DEUDAS A EXCEL: $e');

      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) {
        return;
      }

      _mostrarMensaje('No se pudo generar el Excel: $e');
    } finally {
      if (mounted) {
        setState(() {
          _exportando = false;
        });
      }
    }
  }

  //==========================================================
  // RESULTADO DE EXPORTACIÓN
  //==========================================================

  Future<void> _mostrarResultadoExportacion(
    File archivo,
    String mensaje,
  ) async {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        action: SnackBarAction(
          label: 'Compartir',
          onPressed: () {
            _compartirArchivo(archivo);
          },
        ),
      ),
    );
  }

  //==========================================================
  // COMPARTIR
  //==========================================================

  Future<void> _compartirArchivo(File archivo) async {
    try {
      final shareService = ref.read(fileShareServiceProvider);

      await shareService.compartirArchivo(
        archivo: archivo,
        titulo: 'Exportación de deudas',
        texto: 'Archivo exportado desde la aplicación.',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL COMPARTIR ARCHIVO: $e');

      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) {
        return;
      }

      _mostrarMensaje('No se pudo compartir el archivo: $e');
    }
  }

  //==========================================================
  // MENSAJE
  //==========================================================

  void _mostrarMensaje(String mensaje) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    final deudaState = ref.watch(deudaProvider);
    final configuracionState = ref.watch(configuracionProvider);

    final configuracion = configuracionState.configuracion;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: DeudaFab(
          onPressed: () {
            _searchFocusNode.unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DeudaFormPage()),
            );
          },
        ),

        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => ref.read(deudaProvider.notifier).refrescar(),

            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),

              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: const Text('Deudas'),
                  actions: [
                    if (configuracion != null &&
                        !_exportando &&
                        deudaState.deudas.isNotEmpty)
                      _construirMenuExportacion(
                        context,
                        configuracion.exportarPdf,
                        configuracion.exportarExcel,
                      ),

                    if (_exportando)
                      const Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: ClipRect(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(66 * _controller.value, 0),
                            child: child,
                          );
                        },
                        child: Text(
                          'Gestiona los prestamos registrados.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DeudaSearchBar(
                    controller: _busquedaController,
                    onChanged: (texto) {
                      ref
                          .read(deudaProvider.notifier)
                          .actualizarBusqueda(texto);
                    },
                    onClear: () {
                      _busquedaController.clear();
                      ref.read(deudaProvider.notifier).limpiarBusqueda();
                    },
                    focoNode: _searchFocusNode,
                  ),
                ),

                SliverToBoxAdapter(
                  child: DeudaFilterBar(
                    totalDeudas: deudaState.totalDeudas,
                    deudasMostradas: deudaState.deudas.length,
                    hayFiltros: deudaState.filter.tieneFiltros,
                    onFilterPressed: () async {
                      final filtro = await DeudaFilterSheet.mostrar(
                        context,
                        filter: deudaState.filter,
                      );

                      if (filtro == null || !mounted) {
                        return;
                      }

                      ref.read(deudaProvider.notifier).actualizarFiltro(filtro);
                    },
                  ),
                ),

                const SliverPadding(padding: EdgeInsets.only(top: 8)),

                if (deudaState.loading)
                  DeudaLoading()
                else if (deudaState.error != null)
                  DeudaError(
                    mensaje: deudaState.error!,
                    onRetry: () {
                      ref.read(deudaProvider.notifier).cargar();
                    },
                  )
                else if (deudaState.isEmpty)
                  DeudaEmpty()
                else
                  DeudaList(
                    deudas: deudaState.deudas,
                    onTap: (deuda) async {
                      // Se implementará posteriormente.
                      _searchFocusNode.unfocus();
                      final resultado = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InfoDeudaPage(deuda: deuda),
                        ),
                      );

                      if (resultado == true && context.mounted) {
                        await ref.read(deudaProvider.notifier).refrescar();
                      }
                    },
                    onEdit: (deuda) {
                      // Navegar a DeudaFormPage.
                      _searchFocusNode.unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DeudaFormPage(deuda: deuda),
                        ),
                      );
                    },

                    onDelete: (deuda) async {
                      // Mostrar DeudaDeleteDialog.
                      final confirmar = await DeudaDeleteDialog.mostrar(
                        context,
                        deuda,
                      );

                      if (!confirmar) {
                        return;
                      }

                      try {
                        await ref.read(deudaProvider.notifier).eliminar(deuda);
                      } catch (_) {
                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No se pudo eliminar la deuda.'),
                          ),
                        );
                      }
                    },
                    onCancel: (deuda) async {
                      final confirmar = await DeudaCancelDialog.mostrar(
                        context,
                        deuda,
                      );

                      if (!confirmar || !context.mounted) {
                        return;
                      }

                      try {
                        await ref.read(deudaProvider.notifier).cancelar(deuda);
                      } catch (e) {
                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },

                    onArchive: (deuda) async {
                      final confirmar = await DeudaArchiveDialog.mostrar(
                        context,
                        deuda,
                      );

                      if (!confirmar || !context.mounted) {
                        return;
                      }

                      try {
                        if (deuda.archivada) {
                          await ref
                              .read(deudaProvider.notifier)
                              .desarchivar(deuda);
                        } else {
                          await ref
                              .read(deudaProvider.notifier)
                              .archivar(deuda);
                        }
                      } catch (e) {
                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                  ),

                const SliverPadding(padding: EdgeInsets.only(bottom: 90)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
