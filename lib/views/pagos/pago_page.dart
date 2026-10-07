import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/views/pagos/info_pago_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/deuda.dart';
import '../../models/pago.dart';
import '../../providers/configuracion_provider.dart';
import '../../providers/deuda_provider.dart';
import '../../providers/file_share_provider.dart';
import '../../providers/pago_provider.dart';
import 'dialog/pago_delete_dialog.dart';
import 'pago_form_page.dart';
import 'sheets/pago_filter_sheet.dart';
import 'widgets/pago_empty.dart';
import 'widgets/pago_error.dart';
import 'widgets/pago_fab.dart';
import 'widgets/pago_filter_bar.dart';
import 'widgets/pago_list.dart';
import 'widgets/pago_loading.dart';
import 'widgets/pago_search_bar.dart';

class PagoPage extends ConsumerStatefulWidget {
  const PagoPage({super.key});

  @override
  ConsumerState<PagoPage> createState() => _PagoPageState();
}

class _PagoPageState extends ConsumerState<PagoPage> {
  bool _exportando = false;
  late final TextEditingController _busquedaController;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _busquedaController = TextEditingController();
  }

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

      tooltip: 'Exportar pagos',

      onSelected: (opcion) {
        switch (opcion) {
          case 'pdf':
            _exportarTodosPdf();
            break;

          case 'excel':
            _exportarTodosExcel();
            break;
        }
      },

      itemBuilder: (_) {
        return opcionesDisponibles;
      },
    );
  }

  Future<void> _exportarTodosPdf() async {
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

    final pagos = ref.read(pagoProvider).pagos;

    if (pagos.isEmpty) {
      _mostrarMensaje('No existen pagos para exportar.');
      return;
    }

    setState(() {
      _exportando = true;
    });

    try {
      final service = ref.read(pagoExportServiceProvider);

      final archivo = await service.exportarTodosPdf();

      if (!mounted) {
        return;
      }

      await _mostrarResultadoExportacion(
        archivo,
        'PDF generado correctamente.',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL EXPORTAR PAGOS A PDF: $e');
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

  Future<void> _exportarTodosExcel() async {
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

    final pagos = ref.read(pagoProvider).pagos;

    if (pagos.isEmpty) {
      _mostrarMensaje('No existen pagos para exportar.');
      return;
    }

    setState(() {
      _exportando = true;
    });

    try {
      final service = ref.read(pagoExportServiceProvider);

      final archivo = await service.exportarTodosExcel();

      if (!mounted) {
        return;
      }

      await _mostrarResultadoExportacion(
        archivo,
        'Excel generado correctamente.',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL EXPORTAR PAGOS A EXCEL: $e');
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

  Future<void> _compartirArchivo(File archivo) async {
    try {
      final shareService = ref.read(fileShareServiceProvider);

      await shareService.compartirArchivo(
        archivo: archivo,
        titulo: 'Exportación de pagos',
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

  void _mostrarMensaje(String mensaje) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pagoProvider);
    final notifier = ref.read(pagoProvider.notifier);
    final configuracionState = ref.watch(configuracionProvider);
    final deudaState = ref.watch(deudaProvider);

    final configuracion = configuracionState.configuracion;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: PagoFab(
          onPressed: () {
            _searchFocusNode.unfocus();
            _abrirRegistrarPago(context, deudaState.deudas);
          },
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _refrescar,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),

              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: const Text('Pagos'),
                  // leading: IconButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   icon: Icon(Icons.arrow_back),
                  // ),
                  actions: [
                    if (configuracion != null &&
                        !_exportando &&
                        state.pagos.isNotEmpty)
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
                    child: Text(
                      'Gestiona los pagos registrados.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: PagoSearchBar(
                    controller: _busquedaController,
                    onChanged: (value) {
                      notifier.actualizarBusqueda(value);
                    },
                    onClear: () {
                      _busquedaController.clear();
                      notifier.limpiarBusqueda();
                    },
                    focoNode: _searchFocusNode,
                  ),
                ),

                SliverToBoxAdapter(
                  child: PagoFilterBar(
                    totalPagos: state.totalPagos,
                    pagosMostrados: state.pagos.length,
                    hayFiltros: state.filter.tieneFiltros,
                    onFilterPressed: _mostrarFiltros,
                  ),
                ),

                const SliverPadding(padding: EdgeInsets.only(top: 8)),

                if (state.loading)
                  PagoLoading()
                else if (state.error != null)
                  PagoError(
                    mensaje: state.error!,
                    onRetry: () {
                      ref.read(pagoProvider.notifier).cargar();
                    },
                  )
                else if (state.isEmpty)
                  PagoEmpty(
                    hayFiltros: state.filter.tieneFiltros,
                    onClearFilters: () {
                      ref.read(pagoProvider.notifier).limpiarFiltro();
                    },
                    onCreate: () {
                      _searchFocusNode.unfocus();
                      _abrirRegistrarPago(context, deudaState.deudas);
                    },
                  )
                else
                  PagoList(
                    pagos: state.pagos,

                    onTap: (pago) async {
                      _searchFocusNode.unfocus();
                      final resultado = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InfoPagoPage(
                            pago: pago,
                            deudas: deudaState.deudas,
                          ),
                        ),
                      );

                      if (!context.mounted) {
                        return;
                      }

                      if (resultado == true) {
                        await _actualizarDatosDespuesDeCambio();
                      }
                    },

                    onEdit: (pago) {
                      // Navegar a PagoFormPage.
                      _searchFocusNode.unfocus();
                      _abrirEditarPago(context, pago, deudaState.deudas);
                    },

                    onDelete: _eliminarPago,
                  ),

                const SliverPadding(padding: EdgeInsets.only(bottom: 90)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refrescar() async {
    await Future.wait([
      ref.read(pagoProvider.notifier).refrescar(),
      ref.read(deudaProvider.notifier).cargar(),
    ]);
  }

  Future<void> _abrirRegistrarPago(
    BuildContext context,
    List<Deuda> deudas,
  ) async {
    if (deudas.isEmpty) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No existen deudas disponibles para registrar un pago.',
          ),
        ),
      );

      return;
    }

    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => PagoFormPage(deudas: deudas)),
    );

    if (!mounted) {
      return;
    }

    if (resultado == true) {
      await _actualizarDatosDespuesDeCambio();
    }
  }

  Future<void> _abrirEditarPago(
    BuildContext context,
    Pago pago,
    List<Deuda> deudas,
  ) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PagoFormPage(pago: pago, deudas: deudas),
      ),
    );
    if (!mounted) {
      return;
    }

    if (resultado == true) {
      await _actualizarDatosDespuesDeCambio();
    }
  }

  Future<void> _actualizarDatosDespuesDeCambio() async {
    await Future.wait([
      ref.read(pagoProvider.notifier).refrescar(),
      ref.read(deudaProvider.notifier).cargar(),
    ]);
  }

  Future<void> _mostrarFiltros() async {
    final filtro = await PagoFilterSheet.mostrar(
      context,
      filter: ref.read(pagoProvider).filter,
    );

    if (filtro == null || !mounted) {
      return;
    }

    ref.read(pagoProvider.notifier).actualizarFiltro(filtro);
  }

  Future<void> _eliminarPago(Pago pago) async {
    final confirmado = await PagoDeleteDialog.mostrar(context, pago);

    if (!confirmado || !mounted) {
      return;
    }

    try {
      await ref.read(pagoProvider.notifier).eliminar(pago);
      await ref.read(deudaProvider.notifier).cargar();
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pago eliminado correctamente.')),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
