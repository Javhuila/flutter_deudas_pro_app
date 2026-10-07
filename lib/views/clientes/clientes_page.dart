import 'package:flutter/material.dart';
import 'package:flutter_deudas_pro_app/views/clientes/cliente_form_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cliente.dart';
import '../../providers/cliente_provider.dart';
import 'dialog/cliente_delete_dialog.dart';
import 'sheets/cliente_filter_sheet.dart';
import 'widgets/cliente_empty.dart';
import 'widgets/cliente_error.dart';
import 'widgets/cliente_fab.dart';
import 'widgets/cliente_filter_bar.dart';
import 'widgets/cliente_list.dart';
import 'widgets/cliente_loading.dart';
import 'widgets/cliente_search_bar.dart';

class ClientesPage extends ConsumerStatefulWidget {
  const ClientesPage({super.key});
  @override
  ConsumerState<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends ConsumerState<ClientesPage> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clienteProvider);
    final notifier = ref.read(clienteProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: ClienteFab(
          onPressed: () {
            _searchFocusNode.unfocus();
            _abrirRegistrarCliente(context);
          },
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => _refresh(ref),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: const Text('Clientes'),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Text(
                      'Gestiona los clientes registrados.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ClienteSearchBar(
                    textoInicial: state.filter.texto ?? '',
                    focoNode: _searchFocusNode,
                    onChanged: (texto) {
                      final filter = state.filter.copyWith(texto: texto);
                      notifier.actualizarFiltro(filter);
                    },
                    onClear: () {
                      final filter = state.filter.copyWith(texto: '');

                      notifier.actualizarFiltro(filter);
                    },
                  ),
                ),

                SliverToBoxAdapter(
                  child: ClienteFilterBar(
                    visibles: state.clientes.length,
                    total: state.totalClientes,
                    hayFiltros: state.filter.tieneFiltros,
                    onFilterPressed: () async {
                      final filter = await ClienteFilterSheet.mostrar(
                        context,
                        filter: state.filter,
                      );

                      if (filter == null) {
                        return;
                      }

                      notifier.actualizarFiltro(filter);
                    },
                  ),
                ),

                const SliverPadding(padding: EdgeInsets.only(top: 8)),

                _buildContent(context, ref, state),

                const SliverPadding(padding: EdgeInsets.only(bottom: 90)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _abrirRegistrarCliente(BuildContext context) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ClienteFormPage()),
    );

    if (resultado == true && context.mounted) {
      // Actualizar/cargar la lista si es necesario.
    }
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ClienteState state,
  ) {
    final notifier = ref.read(clienteProvider.notifier);

    if (state.loading) {
      return const ClienteLoading();
    }

    if (state.error != null) {
      return ClienteError(
        message: state.error!,
        onRetry: () {
          notifier.cargar();
        },
      );
    }

    if (state.clientes.isEmpty) {
      return const ClienteEmpty();
    }

    return ClienteList(
      clientes: state.clientes,
      resumenes: state.resumenes,
      // Estos callbacks quedan centralizados aquí.
      onTap: (cliente) {
        // Abrir detalle del cliente.
      },

      onEdit: (cliente) async {
        _searchFocusNode.unfocus();
        _abrirEditarCliente(context, ref, cliente);
      },

      onDelete: (cliente) async {
        // Mostrar diálogo de eliminación.
        final confirmar = await ClienteDeleteDialog.mostrar(context, cliente);

        if (!confirmar) {
          return;
        }

        try {
          await ref.read(clienteProvider.notifier).eliminar(cliente);
        } catch (_) {
          if (!context.mounted) {
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudo eliminar el cliente.')),
          );
        }
      },

      onToggleActivo: (cliente) async {
        try {
          await ref.read(clienteProvider.notifier).cambiarEstadoActivo(cliente);

          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                cliente.activo
                    ? 'Cliente activado correctamente.'
                    : 'Cliente desactivado correctamente.',
              ),
            ),
          );
        } catch (_) {
          if (!context.mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo cambiar el estado del cliente.'),
            ),
          );
        }
      },
    );
  }

  Future<void> _refresh(WidgetRef ref) async {
    await ref.read(clienteProvider.notifier).refrescar();
  }

  Future<void> _abrirEditarCliente(
    BuildContext context,
    WidgetRef ref,
    Cliente cliente,
  ) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => ClienteFormPage(cliente: cliente)),
    );
    if (!context.mounted) {
      return;
    }

    if (resultado == true) {
      await _refresh(ref);
    }
  }
}
