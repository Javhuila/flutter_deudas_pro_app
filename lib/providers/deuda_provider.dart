import 'package:flutter_deudas_pro_app/services/deuda/deuda_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/isar_provider.dart';
import '../models/deuda.dart';
import '../repositories/deuda_repository.dart';
import '../services/deuda/deuda_filter.dart';
import '../services/deuda/deuda_validator.dart';
import '../services/export/deuda_export_service.dart';
import '../services/notifications/notification_sync_service.dart';
import 'configuracion_provider.dart';
import 'cuota_deuda_provider.dart';
import 'interes_deuda_provider.dart';
import 'pago_provider.dart';

final deudaRepositoryProvider = Provider<DeudaRepository>((ref) {
  return DeudaRepository(ref.watch(isarProvider));
});

final deudaValidatorProvider = Provider<DeudaValidator>((ref) {
  return DeudaValidator(ref.watch(deudaRepositoryProvider));
});

final deudaServiceProvider = Provider<DeudaService>((ref) {
  return DeudaService(
    repository: ref.watch(deudaRepositoryProvider),
    validator: ref.watch(deudaValidatorProvider),
    pagoRepository: ref.watch(pagoRepositoryProvider),
    interesRepository: ref.watch(interesDeudaRepositoryProvider),
    cuotaRepository: ref.watch(cuotaDeudaRepositoryProvider),
    configuracionService: ref.watch(configuracionServiceProvider),
  );
});

final deudaExportServiceProvider = Provider<DeudaExportService>((ref) {
  return DeudaExportService(ref.watch(deudaRepositoryProvider));
});

final notificationSyncServiceProvider = Provider<NotificationSyncService>((
  ref,
) {
  return NotificationSyncService(
    deudaRepository: ref.watch(deudaRepositoryProvider),
    configuracionService: ref.watch(configuracionServiceProvider),
  );
});

final deudaProvider = StateNotifierProvider<DeudaNotifier, DeudaState>((ref) {
  return DeudaNotifier(ref.watch(deudaServiceProvider));
});

class DeudaState {
  const DeudaState({
    this.deudas = const [],
    this.totalDeudas = 0,
    this.loading = false,
    this.error,
    this.search = '',
    this.filter = const DeudaFilter(),
  });

  final List<Deuda> deudas;
  final int totalDeudas;
  final bool loading;
  final String? error;
  final String search;
  final DeudaFilter filter;

  bool get isEmpty {
    return !loading && error == null && deudas.isEmpty;
  }

  bool get tieneFiltros {
    return search.trim().isNotEmpty || filter.tieneFiltros;
  }

  DeudaState copyWith({
    List<Deuda>? deudas,
    int? totalDeudas,
    bool? loading,
    String? error,
    bool clearError = false,
    String? search,
    DeudaFilter? filter,
  }) {
    return DeudaState(
      deudas: deudas ?? this.deudas,
      totalDeudas: totalDeudas ?? this.totalDeudas,
      loading: loading ?? this.loading,
      error: clearError ? null : error ?? this.error,
      search: search ?? this.search,
      filter: filter ?? this.filter,
    );
  }
}

class DeudaNotifier extends StateNotifier<DeudaState> {
  DeudaNotifier(this._service) : super(const DeudaState(loading: true)) {
    _todas = [];
    cargar();
  }

  final DeudaService _service;

  List<Deuda> _todas = [];

  // ==========================================================
  // CARGA
  // ==========================================================

  Future<void> cargar() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final deudas = await _service.obtenerTodas();

      _todas = List<Deuda>.from(deudas);

      _aplicarFiltros();

      state = state.copyWith(loading: false, clearError: true);
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

  // ==========================================================
  // BÚSQUEDA
  // ==========================================================

  void actualizarBusqueda(String texto) {
    state = state.copyWith(search: texto);

    _aplicarFiltros();
  }

  void limpiarBusqueda() {
    state = state.copyWith(search: '');

    _aplicarFiltros();
  }

  // ==========================================================
  // FILTROS
  // ==========================================================

  void actualizarFiltro(DeudaFilter filter) {
    state = state.copyWith(filter: filter);

    _aplicarFiltros();
  }

  void limpiarFiltro() {
    state = state.copyWith(filter: const DeudaFilter());

    _aplicarFiltros();
  }

  // ==========================================================
  // APLICAR FILTROS
  // ==========================================================

  void _aplicarFiltros() {
    Iterable<Deuda> lista = _todas;
    final filter = state.filter;

    final texto = state.search.trim().toLowerCase();

    if (texto.isNotEmpty) {
      lista = lista.where((deuda) {
        final cliente = deuda.cliente.value;

        final nombreCliente = cliente?.nombre.toLowerCase() ?? '';

        return nombreCliente.contains(texto);
      });
    }

    // --------------------------------------------------------
    // Número visible de la deuda
    // --------------------------------------------------------

    final numeroDeuda = filter.numeroDeuda?.trim();

    if (numeroDeuda != null && numeroDeuda.isNotEmpty) {
      lista = lista.where((deuda) {
        // El número visible se muestra con seis dígitos,
        // por ejemplo: 000045.
        final numeroFormateado = deuda.numeroDeuda.toString().padLeft(6, '0');

        return numeroFormateado.contains(numeroDeuda);
      });
    }

    // --------------------------------------------------------
    // Cliente
    // --------------------------------------------------------

    if (filter.clienteId != null) {
      lista = lista.where((deuda) {
        return deuda.cliente.value?.id == filter.clienteId;
      });
    }

    // --------------------------------------------------------
    // Estado
    // --------------------------------------------------------

    if (filter.estado != null) {
      lista = lista.where((deuda) {
        return deuda.estado == filter.estado;
      });
    }

    // --------------------------------------------------------
    // Archivadas
    // --------------------------------------------------------

    if (filter.archivada == true) {
      // Incluir deudas archivadas.
      // No se filtran: se muestran archivadas y no archivadas.
    } else {
      // Por defecto, ocultar las deudas archivadas.
      lista = lista.where((deuda) => !deuda.archivada);
    }

    // --------------------------------------------------------
    // Fecha desde
    // --------------------------------------------------------

    if (filter.desde != null) {
      final desde = DateTime(
        filter.desde!.year,
        filter.desde!.month,
        filter.desde!.day,
      );

      lista = lista.where((deuda) {
        final fecha = DateTime(
          deuda.fechaPrestamo.year,
          deuda.fechaPrestamo.month,
          deuda.fechaPrestamo.day,
        );

        return !fecha.isBefore(desde);
      });
    }

    // --------------------------------------------------------
    // Fecha hasta
    // --------------------------------------------------------

    if (filter.hasta != null) {
      final hasta = DateTime(
        filter.hasta!.year,
        filter.hasta!.month,
        filter.hasta!.day,
      );

      lista = lista.where((deuda) {
        final fecha = DateTime(
          deuda.fechaPrestamo.year,
          deuda.fechaPrestamo.month,
          deuda.fechaPrestamo.day,
        );

        return !fecha.isAfter(hasta);
      });
    }

    // --------------------------------------------------------
    // Ordenamiento
    // --------------------------------------------------------

    final listaOrdenada = lista.toList();

    listaOrdenada.sort((a, b) {
      final resultado = a.fechaPrestamo.compareTo(b.fechaPrestamo);

      if (filter.ascendente) {
        return resultado;
      }

      return -resultado;
    });

    state = state.copyWith(deudas: listaOrdenada, totalDeudas: _todas.length);
  }

  // ==========================================================
  // CRUD
  // ==========================================================

  Future<void> guardar(Deuda deuda) async {
    try {
      // await _service.recalcular(deuda);

      await _service.crear(deuda);

      _todas.add(deuda);

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> actualizar(Deuda deuda) async {
    try {
      await _service.editar(deuda);

      final index = _todas.indexWhere((d) => d.id == deuda.id);

      if (index != -1) {
        _todas[index] = deuda;
      }

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> eliminar(Deuda deuda) async {
    try {
      await _service.eliminar(deuda.id);

      _todas.removeWhere((d) => d.id == deuda.id);

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> cancelar(Deuda deuda) async {
    try {
      await _service.cancelar(deuda.id);

      _todas.removeWhere((d) => d.id == deuda.id);

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> archivar(Deuda deuda) async {
    try {
      await _service.archivar(deuda.id);

      deuda.archivada = true;

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> desarchivar(Deuda deuda) async {
    try {
      await _service.desarchivar(deuda.id);

      deuda.archivada = false;

      _aplicarFiltros();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  // ==========================================================
  // CONSULTAS
  // ==========================================================

  Deuda? obtenerPorId(int id) {
    try {
      return _todas.firstWhere((deuda) => deuda.id == id);
    } catch (_) {
      return null;
    }
  }

  Deuda? obtenerPorUuid(String uuid) {
    try {
      return _todas.firstWhere((deuda) => deuda.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  List<Deuda> obtenerPorCliente(int clienteId) {
    return _todas.where((deuda) {
      return deuda.cliente.value?.id == clienteId;
    }).toList();
  }

  // ==========================================================
  // LIMPIAR
  // ==========================================================

  void limpiar() {
    _todas.clear();

    state = state.copyWith(
      deudas: const [],
      totalDeudas: 0,
      search: '',
      filter: const DeudaFilter(),
      clearError: true,
    );
  }
}
