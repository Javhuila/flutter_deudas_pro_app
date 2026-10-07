import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/isar_provider.dart';
import '../models/cliente.dart';
import '../repositories/cliente_repository.dart';
import '../services/cliente/cliente_filter.dart';
import '../services/cliente/cliente_service.dart';
import '../services/cliente/cliente_summary.dart';
import '../views/clientes/sheets/cliente_filter_sheet.dart';
import 'deuda_provider.dart';

final clienteRepositoryProvider = Provider<ClienteRepository>((ref) {
  return ClienteRepository(ref.watch(isarProvider));
});

final clienteServiceProvider = Provider<ClienteService>((ref) {
  return ClienteService(
    repository: ref.watch(clienteRepositoryProvider),
    deudaService: ref.watch(deudaServiceProvider),
  );
});

final clienteProvider = StateNotifierProvider<ClienteNotifier, ClienteState>((
  ref,
) {
  return ClienteNotifier(ref.watch(clienteServiceProvider));
});

class ClienteState {
  const ClienteState({
    this.clientes = const [],
    this.totalClientes = 0,
    this.resumenes = const {},
    this.loading = false,
    this.error,
    this.search = '',
    this.filter = const ClienteFilter(),
  });

  final List<Cliente> clientes;
  final int totalClientes;
  final Map<int, ClienteSummary> resumenes;
  final bool loading;

  final String? error;

  final String search;
  final ClienteFilter filter;

  bool get isEmpty => !loading && error == null && clientes.isEmpty;

  ClienteState copyWith({
    List<Cliente>? clientes,
    int? totalClientes,
    Map<int, ClienteSummary>? resumenes,
    bool? loading,
    String? error,
    bool clearError = false,
    String? search,
    ClienteFilter? filter,
  }) {
    return ClienteState(
      clientes: clientes ?? this.clientes,
      totalClientes: totalClientes ?? this.totalClientes,
      resumenes: resumenes ?? this.resumenes,
      loading: loading ?? this.loading,
      error: clearError ? null : error ?? this.error,
      search: search ?? this.search,
      filter: filter ?? this.filter,
    );
  }
}

class ClienteNotifier extends StateNotifier<ClienteState> {
  ClienteNotifier(this._service) : super(const ClienteState(loading: true)) {
    cargar();
  }

  final ClienteService _service;
  late List<Cliente> _todos = [];

  Future<void> cargar() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final clientes = await _service.obtenerTodos();

      _todos = List<Cliente>.from(clientes);

      final resumenes = await _service.obtenerResumenes(clientes);

      final mapaResumenes = <int, ClienteSummary>{
        for (final resumen in resumenes) resumen.cliente.id: resumen,
      };

      state = state.copyWith(
        clientes: clientes,
        totalClientes: clientes.length,
        resumenes: mapaResumenes,
        loading: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> refrescar() async {
    await cargar();
  }

  void limpiarError() {
    state = state.copyWith(clearError: true);
  }

  void actualizarBusqueda(String texto) {
    state = state.copyWith(search: texto);

    _aplicarFiltros();
  }

  void limpiarBusqueda() {
    state = state.copyWith(search: '');

    _aplicarFiltros();
  }

  void actualizarFiltro(ClienteFilter filter) {
    state = state.copyWith(filter: filter);

    _aplicarFiltros();
  }

  void limpiarFiltro() {
    state = state.copyWith(filter: const ClienteFilter());

    _aplicarFiltros();
  }

  void _aplicarFiltros() {
    Iterable<Cliente> lista = _todos;
    final filter = state.filter;

    final texto = filter.texto?.trim().toLowerCase() ?? '';

    if (texto.isNotEmpty) {
      lista = lista.where((cliente) {
        return cliente.nombre.toLowerCase().contains(texto) ||
            (cliente.telefono ?? '').toLowerCase().contains(texto);
      });
    }

    if (filter.activo != null) {
      lista = lista.where((c) => c.activo == filter.activo);
    }

    switch (filter.ordenarPor) {
      case ClienteOrden.nombreAsc:
        final l = lista.toList()..sort((a, b) => a.nombre.compareTo(b.nombre));
        lista = l;
        break;

      case ClienteOrden.nombreDesc:
        final l = lista.toList()..sort((a, b) => b.nombre.compareTo(a.nombre));
        lista = l;
        break;

      case ClienteOrden.fechaRegistroAsc:
        final l = lista.toList()
          ..sort((a, b) => a.fechaRegistro.compareTo(b.fechaRegistro));
        lista = l;
        break;

      case ClienteOrden.fechaRegistroDesc:
        final l = lista.toList()
          ..sort((a, b) => b.fechaRegistro.compareTo(a.fechaRegistro));
        lista = l;
        break;
    }

    state = state.copyWith(
      clientes: lista.toList(),
      totalClientes: _todos.length,
    );
  }

  Future<void> guardar(Cliente cliente) async {
    try {
      await _service.crear(cliente);

      _todos.add(cliente);

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> actualizar(Cliente cliente) async {
    try {
      await _service.editar(cliente);

      final index = _todos.indexWhere((c) => c.id == cliente.id);

      if (index != -1) {
        _todos[index] = cliente;
      }

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> eliminar(Cliente cliente) async {
    try {
      await _service.eliminar(cliente.id);

      _todos.removeWhere((c) => c.id == cliente.id);

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> cambiarEstadoActivo(Cliente cliente) async {
    try {
      final nuevoEstado = !cliente.activo;

      if (nuevoEstado) {
        await _service.activar(cliente.id);
      } else {
        await _service.desactivar(cliente.id);
      }

      final index = _todos.indexWhere((c) => c.id == cliente.id);

      if (index != -1) {
        _todos[index].activo = nuevoEstado;
        _todos[index].fechaActualizacion = DateTime.now();
      }

      // Recalcular los resúmenes con los datos actualizados.
      final resumenes = await _service.obtenerResumenes(_todos);

      final mapaResumenes = <int, ClienteSummary>{
        for (final resumen in resumenes) resumen.cliente.id: resumen,
      };

      state = state.copyWith(resumenes: mapaResumenes);

      // Mantener la búsqueda y los filtros actuales.
      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Cliente? obtenerPorId(int id) {
    try {
      return _todos.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  Cliente? obtenerPorUuid(String uuid) {
    try {
      return _todos.firstWhere((c) => c.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  void limpiar() {
    _todos.clear();

    state = state.copyWith(
      clientes: const [],
      totalClientes: 0,
      filter: const ClienteFilter(),
      clearError: true,
    );
  }
}
