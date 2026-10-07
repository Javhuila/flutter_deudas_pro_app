import 'package:flutter_deudas_pro_app/services/pago/pago_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/isar_provider.dart';
import '../core/enums/pago_orden.dart';
import '../models/cuota_deuda.dart';
import '../models/pago.dart';
import '../repositories/pago_repository.dart';
import '../services/export/pago_export_service.dart';
import '../services/pago/pago_filter.dart';
import '../services/pago/pago_validator.dart';
import 'configuracion_provider.dart';
import 'cuota_deuda_provider.dart';
import 'deuda_provider.dart';
import 'interes_deuda_provider.dart';

final pagoRepositoryProvider = Provider<PagoRepository>((ref) {
  return PagoRepository(ref.watch(isarProvider));
});

final pagoValidatorProvider = Provider<PagoValidator>((ref) {
  return PagoValidator(ref.watch(pagoRepositoryProvider));
});

final pagoServiceProvider = Provider<PagoService>((ref) {
  return PagoService(
    repository: ref.watch(pagoRepositoryProvider),
    validator: ref.watch(pagoValidatorProvider),
    deudaService: ref.watch(deudaServiceProvider),
    interesRepository: ref.watch(interesDeudaRepositoryProvider),
    cuotaRepository: ref.watch(cuotaDeudaRepositoryProvider),
    configuracionService: ref.watch(configuracionServiceProvider),
  );
});

final pagoExportServiceProvider = Provider<PagoExportService>((ref) {
  return PagoExportService(ref.watch(pagoRepositoryProvider));
});

final pagoProvider = StateNotifierProvider<PagoNotifier, PagoState>((ref) {
  return PagoNotifier(ref.watch(pagoServiceProvider));
});

class PagoState {
  const PagoState({
    this.pagos = const [],
    this.totalPagos = 0,
    this.loading = false,
    this.error,
    this.search = '',
    this.filter = const PagoFilter(),
  });

  final List<Pago> pagos;

  final int totalPagos;

  final bool loading;

  final String? error;
  final String search;
  final PagoFilter filter;

  bool get isEmpty => !loading && error == null && pagos.isEmpty;

  bool get tieneFiltros => filter.tieneFiltros;

  PagoState copyWith({
    List<Pago>? pagos,
    int? totalPagos,
    bool? loading,
    String? error,
    bool clearError = false,
    String? search,
    PagoFilter? filter,
  }) {
    return PagoState(
      pagos: pagos ?? this.pagos,
      totalPagos: totalPagos ?? this.totalPagos,
      loading: loading ?? this.loading,
      error: clearError ? null : error ?? this.error,
      search: search ?? this.search,
      filter: filter ?? this.filter,
    );
  }
}

class PagoNotifier extends StateNotifier<PagoState> {
  PagoNotifier(this._service) : super(const PagoState(loading: true)) {
    _todos = [];
    cargar();
  }

  final PagoService _service;

  late List<Pago> _todos;

  //==========================================================
  // CARGA
  //==========================================================

  Future<void> cargar() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final pagos = await _service.obtenerTodos();

      _todos = pagos;

      _aplicarFiltros();

      state = state.copyWith(loading: false, clearError: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> refrescar() async {
    await cargar();
  }

  //==========================================================
  // ERRORES
  //==========================================================

  void limpiarError() {
    state = state.copyWith(clearError: true);
  }

  //==========================================================
  // BÚSQUEDA
  //==========================================================

  void actualizarBusqueda(String texto) {
    state = state.copyWith(search: texto);

    _aplicarFiltros();
  }

  void limpiarBusqueda() {
    state = state.copyWith(search: '');

    _aplicarFiltros();
  }

  //==========================================================
  // FILTROS
  //==========================================================

  void actualizarFiltro(PagoFilter filter) {
    state = state.copyWith(filter: filter);

    _aplicarFiltros();
  }

  void limpiarFiltro() {
    state = state.copyWith(filter: const PagoFilter());

    _aplicarFiltros();
  }

  void _aplicarFiltros() {
    Iterable<Pago> lista = _todos;
    final filter = state.filter;
    //========================================================
    // BÚSQUEDA
    //========================================================

    final texto = state.search.trim().toLowerCase();
    if (texto.isNotEmpty) {
      lista = lista.where((pago) {
        final referencia = (pago.referencia ?? '').toLowerCase();
        final observacion = (pago.observacion ?? '').toLowerCase();

        final numeroPago = pago.numeroPago.toString();
        final valor = pago.valor.toString();
        final deuda = pago.deuda.value;
        final numeroDeuda = deuda?.numeroDeuda.toString() ?? '';
        final cliente = deuda?.cliente.value;
        final nombreCliente = (cliente?.nombre ?? '').toLowerCase();

        return referencia.contains(texto) ||
            observacion.contains(texto) ||
            numeroPago.contains(texto) ||
            valor.contains(texto) ||
            numeroDeuda.contains(texto) ||
            nombreCliente.contains(texto);
      });
    }

    // --------------------------------------------------------
    // Número visible del Pago
    // --------------------------------------------------------

    final numeroPaga = filter.numeroPago?.trim();

    if (numeroPaga != null && numeroPaga.isNotEmpty) {
      lista = lista.where((pago) {
        // El número visible se muestra con seis dígitos,
        // por ejemplo: 000045.
        final numeroFormateado = pago.numeroPago.toString().padLeft(6, '0');

        return numeroFormateado.contains(numeroPaga);
      });
    }

    // --------------------------------------------------------
    // Número visible de la Deuda
    // --------------------------------------------------------

    final numeroDeudaFiltro = filter.numeroDeuda?.trim();

    if (numeroDeudaFiltro != null && numeroDeudaFiltro.isNotEmpty) {
      lista = lista.where((pago) {
        final deuda = pago.deuda.value;

        if (deuda == null) {
          return false;
        }

        final numeroFormateado = deuda.numeroDeuda.toString().padLeft(6, '0');

        return numeroFormateado.contains(numeroDeudaFiltro);
      });
    }

    //========================================================
    // FILTRO POR DEUDA
    //========================================================
    if (filter.deudaId != null) {
      lista = lista.where((pago) {
        return pago.deuda.value?.id == filter.deudaId;
      });
    }

    //========================================================
    // FILTRO POR MÉTODO DE PAGO
    //========================================================

    if (filter.metodoPago != null) {
      lista = lista.where((pago) {
        return pago.metodoPago == filter.metodoPago;
      });
    }

    //========================================================
    // FILTRO POR ELIMINADO
    //========================================================

    if (filter.eliminado != null) {
      lista = lista.where((pago) {
        return pago.eliminado == filter.eliminado;
      });
    } else {
      lista = lista.where((pago) {
        return !pago.eliminado;
      });
    }

    //========================================================
    // FILTRO POR FECHA INICIAL
    //========================================================

    if (filter.desde != null) {
      lista = lista.where((pago) {
        return !pago.fechaPago.isBefore(filter.desde!);
      });
    }

    //========================================================
    // FILTRO POR FECHA FINAL
    //========================================================

    if (filter.hasta != null) {
      lista = lista.where((pago) {
        return !pago.fechaPago.isAfter(filter.hasta!);
      });
    }

    //========================================================
    // ORDEN
    //========================================================

    final resultado = lista.toList();

    switch (filter.orden) {
      case PagoOrden.fechaDesc:
        resultado.sort((a, b) => b.fechaPago.compareTo(a.fechaPago));
        break;

      case PagoOrden.fechaAsc:
        resultado.sort((a, b) => a.fechaPago.compareTo(b.fechaPago));
        break;

      case PagoOrden.valorDesc:
        resultado.sort((a, b) => b.valor.compareTo(a.valor));
        break;

      case PagoOrden.valorAsc:
        resultado.sort((a, b) => a.valor.compareTo(b.valor));
        break;
    }

    state = state.copyWith(pagos: resultado, totalPagos: resultado.length);
  }

  //==========================================================
  // REGISTRAR
  //==========================================================

  Future<void> registrar(
    Pago pago, {
    List<CuotaDeuda> cuotasSeleccionadas = const [],
  }) async {
    try {
      state = state.copyWith(loading: true, clearError: true);
      final pagoGuardado = await _service.registrarPago(
        pago,
        cuotasSeleccionadas: cuotasSeleccionadas,
      );
      _todos.add(pagoGuardado);
      _aplicarFiltros();
      state = state.copyWith(loading: false, clearError: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
      rethrow;
    }
  }

  //==========================================================
  // EDITAR
  //==========================================================

  Future<void> actualizar(Pago pago) async {
    try {
      state = state.copyWith(loading: true, clearError: true);
      final pagoActualizado = await _service.editarPago(pago);
      final index = _todos.indexWhere((p) => p.id == pagoActualizado.id);
      if (index != -1) {
        _todos[index] = pagoActualizado;
      }
      _aplicarFiltros();
      state = state.copyWith(loading: false, clearError: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
      rethrow;
    }
  }

  //==========================================================
  // ELIMINACIÓN LÓGICA
  //==========================================================

  Future<void> eliminar(Pago pago) async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      await _service.eliminarPago(pago.id);

      final index = _todos.indexWhere((p) => p.id == pago.id);

      if (index != -1) {
        _todos[index].eliminado = true;
        _todos[index].fechaActualizacion = DateTime.now();
      }

      _aplicarFiltros();

      state = state.copyWith(loading: false, clearError: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());

      rethrow;
    }
  }

  //==========================================================
  // RESTAURAR
  //==========================================================

  Future<void> restaurar(Pago pago) async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      await _service.restaurarPago(pago.id);

      final index = _todos.indexWhere((p) => p.id == pago.id);

      if (index != -1) {
        _todos[index].eliminado = false;
        _todos[index].fechaActualizacion = DateTime.now();
      }

      _aplicarFiltros();

      state = state.copyWith(loading: false, clearError: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());

      rethrow;
    }
  }

  //==========================================================
  // CONSULTAS
  //==========================================================

  Pago? obtenerPorId(int id) {
    try {
      return _todos.firstWhere((pago) => pago.id == id);
    } catch (_) {
      return null;
    }
  }

  Pago? obtenerPorUuid(String uuid) {
    try {
      return _todos.firstWhere((pago) => pago.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  List<Pago> obtenerPorDeuda(int deudaId) {
    return _todos.where((pago) {
      return pago.deuda.value?.id == deudaId;
    }).toList();
  }

  //==========================================================
  // UTILIDADES
  //==========================================================

  void limpiar() {
    _todos.clear();

    state = state.copyWith(
      pagos: const [],
      totalPagos: 0,
      filter: const PagoFilter(),
      clearError: true,
    );
  }
}
