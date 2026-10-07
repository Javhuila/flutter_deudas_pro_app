import 'package:flutter_deudas_pro_app/services/respaldo/respaldo_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/backups/backup_result.dart';
import '../core/backups/backup_service.dart';
import '../core/database/database_service.dart';
import '../core/database/isar_provider.dart';
import '../core/enums/estado_respaldo.dart';
import '../core/enums/tipo_respaldo.dart';
import '../models/respaldo.dart';
import '../repositories/respaldo_repository.dart';
import '../services/configuracion/configuracion_service.dart';
import 'cliente_provider.dart';
import 'configuracion_provider.dart';
import 'deuda_provider.dart';
import 'pago_provider.dart';

final respaldoRepositoryProvider = Provider<RespaldoRepository>((ref) {
  return RespaldoRepository(ref.watch(isarProvider));
});

final respaldoServiceProvider = Provider<RespaldoService>((ref) {
  return RespaldoService(ref.watch(respaldoRepositoryProvider));
});

final respaldoProvider = StateNotifierProvider<RespaldoNotifier, RespaldoState>(
  (ref) {
    return RespaldoNotifier(
      ref: ref,
      backupService: ref.watch(backupServiceProvider),
    );
  },
);

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(databaseService: DatabaseService.instance);
});

class RespaldoState {
  const RespaldoState({
    this.respaldos = const [],
    this.ultimo,
    this.total = 0,
    this.exitosos = 0,
    this.errores = 0,
    this.manuales = 0,
    this.automaticos = 0,
    this.restauraciones = 0,
    this.loading = false,
    this.error,
  });

  final List<Respaldo> respaldos;

  final Respaldo? ultimo;

  final int total;
  final int exitosos;
  final int errores;
  final int manuales;
  final int automaticos;
  final int restauraciones;

  final bool loading;

  final String? error;

  bool get isEmpty => !loading && error == null && respaldos.isEmpty;

  bool get hayError => error != null;

  RespaldoState copyWith({
    List<Respaldo>? respaldos,
    Respaldo? ultimo,
    bool clearUltimo = false,
    int? total,
    int? exitosos,
    int? errores,
    int? manuales,
    int? automaticos,
    int? restauraciones,
    bool? loading,
    String? error,
    bool clearError = false,
  }) {
    return RespaldoState(
      respaldos: respaldos ?? this.respaldos,
      ultimo: clearUltimo ? null : ultimo ?? this.ultimo,
      total: total ?? this.total,
      exitosos: exitosos ?? this.exitosos,
      errores: errores ?? this.errores,
      manuales: manuales ?? this.manuales,
      automaticos: automaticos ?? this.automaticos,
      restauraciones: restauraciones ?? this.restauraciones,
      loading: loading ?? this.loading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class RespaldoNotifier extends StateNotifier<RespaldoState> {
  RespaldoNotifier({required this.ref, required this.backupService})
    : super(const RespaldoState(loading: true)) {
    cargar();
  }

  final Ref ref;
  final BackupService backupService;
  RespaldoService get _service => ref.read(respaldoServiceProvider);
  ConfiguracionService get _configuracionService =>
      ref.read(configuracionServiceProvider);

  //==========================================================
  // CARGA
  //==========================================================

  Future<void> cargar() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final respaldos = await _service.obtenerTodos();

      final ultimo = await _service.obtenerUltimo();

      final total = await _service.contar();

      final exitosos = await _service.contarExitosos();

      final errores = await _service.contarErrores();

      final manuales = await _service.contarManuales();

      final automaticos = await _service.contarAutomaticos();

      final restauraciones = await _service.contarRestauraciones();

      state = state.copyWith(
        respaldos: respaldos,
        ultimo: ultimo,
        total: total,
        exitosos: exitosos,
        errores: errores,
        manuales: manuales,
        automaticos: automaticos,
        restauraciones: restauraciones,
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

  //==========================================================
  // ERROR
  //==========================================================

  void limpiarError() {
    state = state.copyWith(clearError: true);
  }

  //==========================================================
  // BÚSQUEDA
  //==========================================================

  Future<void> buscar(String texto) async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final resultado = await _service.buscar(texto);

      state = state.copyWith(respaldos: resultado, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  //==========================================================
  // CONSULTAS
  //==========================================================

  Future<void> cargarExitosos() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final resultado = await _service.obtenerExitosos();

      state = state.copyWith(respaldos: resultado, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> cargarConErrores() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final resultado = await _service.obtenerConErrores();

      state = state.copyWith(respaldos: resultado, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> cargarManuales() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final resultado = await _service.obtenerManuales();

      state = state.copyWith(respaldos: resultado, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> cargarAutomaticos() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final resultado = await _service.obtenerAutomaticos();

      state = state.copyWith(respaldos: resultado, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> cargarRestauraciones() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final resultado = await _service.obtenerRestauraciones();

      state = state.copyWith(respaldos: resultado, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  //==========================================================
  // CREAR BACKUP
  //==========================================================

  Future<BackupResult> crearBackup({String? destinationDirectory}) async {
    try {
      state = state.copyWith(loading: true, clearError: true);
      final configuracion = await _configuracionService.obtener();
      final resultado = await backupService.createBackup(
        destinationDirectory: destinationDirectory,
        maximoBackups: configuracion.maximoBackups,
      );

      if (resultado.success) {
        await _service.registrarRespaldo(
          tipo: TipoRespaldo.manual,
          estado: EstadoRespaldo.exitoso,
          nombreArchivo: resultado.fileName ?? '',
          rutaArchivo: resultado.filePath ?? '',
          tamanoBytes: resultado.fileSizeBytes,
          versionAplicacion: '1.0.0',
          cantidadClientes: resultado.cantidadClientes,
          cantidadDeudas: resultado.cantidadDeudas,
          cantidadPagos: resultado.cantidadPagos,
          duracionMs: resultado.durationMs,
        );
        await _configuracionService.registrarUltimoBackup();
      } else {
        await _service.registrarError(
          tipo: TipoRespaldo.manual,
          observacion: resultado.message ?? 'No se pudo crear el respaldo.',
        );
      }

      await cargar();

      if (!resultado.success) {
        state = state.copyWith(loading: false, error: resultado.message);
      }

      return resultado;
    } catch (e) {
      try {
        await _service.registrarError(
          tipo: TipoRespaldo.manual,
          observacion: e.toString(),
        );
      } catch (_) {}

      state = state.copyWith(loading: false, error: e.toString());

      rethrow;
    }
  }

  //==========================================================
  // RESTAURAR BACKUP
  //==========================================================

  Future<BackupResult> restaurarBackup(String backupPath) async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final resultado = await backupService.restoreBackup(backupPath);

      if (!resultado.success) {
        // La restauración no se completó. Registramos el error
        // utilizando el servicio actual, si todavía está disponible.
        try {
          await _service.registrarError(
            tipo: TipoRespaldo.restauracion,
            observacion:
                resultado.message ?? 'No se pudo restaurar el respaldo.',
          );
        } catch (_) {
          // No reemplazamos el resultado original por un error
          // secundario al intentar guardar el historial.
        }

        state = state.copyWith(
          loading: false,
          error: resultado.message ?? 'No se pudo restaurar el respaldo.',
        );

        return resultado;
      }

      // ----------------------------------------------------------
      // ACTUALIZAR PROVIDERS QUE USAN LA INSTANCIA DE ISAR
      // ----------------------------------------------------------
      // Primero, invalidar el provider que entrega la instancia de Isar.
      ref.invalidate(isarProvider);

      // Clientes
      ref.invalidate(clienteRepositoryProvider);
      ref.invalidate(clienteServiceProvider);
      ref.invalidate(clienteProvider);

      // Deudas
      ref.invalidate(deudaRepositoryProvider);
      ref.invalidate(deudaServiceProvider);
      ref.invalidate(deudaProvider);

      // Pagos
      ref.invalidate(pagoRepositoryProvider);
      ref.invalidate(pagoValidatorProvider);
      ref.invalidate(pagoServiceProvider);
      ref.invalidate(pagoProvider);

      // Configuración
      ref.invalidate(configuracionRepositoryProvider);
      ref.invalidate(configuracionServiceProvider);
      ref.invalidate(configuracionProvider);

      // El historial también debe usar un repositorio nuevo,
      // porque el anterior podría conservar la instancia cerrada.
      ref.invalidate(respaldoRepositoryProvider);
      ref.invalidate(respaldoServiceProvider);

      // Obtener el servicio recién construido con el Isar actual.
      final respaldoServiceActual = ref.read(respaldoServiceProvider);

      await respaldoServiceActual.registrarRestauracion(
        nombreArchivo: resultado.fileName ?? '',
        rutaArchivo: resultado.filePath ?? backupPath,
        tamanoBytes: resultado.fileSizeBytes,
        versionAplicacion: '1.0.0',
        cantidadClientes: resultado.cantidadClientes,
        cantidadDeudas: resultado.cantidadDeudas,
        cantidadPagos: resultado.cantidadPagos,
        duracionMs: resultado.durationMs,
      );

      // Este notifier conserva una referencia al servicio anterior.
      // Lo invalidamos para que Riverpod lo reconstruya con
      // dependencias nuevas cuando vuelva a ser solicitado.
      state = state.copyWith(loading: false, clearError: true);
      return resultado;
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
      rethrow;
    }
  }

  //==========================================================
  // FILTROS
  //==========================================================

  Future<void> filtrar({
    TipoRespaldo? tipo,
    EstadoRespaldo? estado,
    DateTime? desde,
    DateTime? hasta,
  }) async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final resultado = await _service.filtrar(
        tipo: tipo,
        estado: estado,
        desde: desde,
        hasta: hasta,
      );

      state = state.copyWith(respaldos: resultado, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  //==========================================================
  // REGISTRAR RESPALDO
  //==========================================================

  Future<void> registrarRespaldo({
    required TipoRespaldo tipo,
    required EstadoRespaldo estado,
    required String nombreArchivo,
    required String rutaArchivo,
    required int tamanoBytes,
    required String versionAplicacion,
    String? observacion,
    int cantidadClientes = 0,
    int cantidadDeudas = 0,
    int cantidadPagos = 0,
    int duracionMs = 0,
  }) async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      await _service.registrarRespaldo(
        tipo: tipo,
        estado: estado,
        nombreArchivo: nombreArchivo,
        rutaArchivo: rutaArchivo,
        tamanoBytes: tamanoBytes,
        versionAplicacion: versionAplicacion,
        observacion: observacion,
        cantidadClientes: cantidadClientes,
        cantidadDeudas: cantidadDeudas,
        cantidadPagos: cantidadPagos,
        duracionMs: duracionMs,
      );

      await cargar();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());

      rethrow;
    }
  }

  //==========================================================
  // REGISTRAR ERROR
  //==========================================================

  Future<void> registrarError({
    required TipoRespaldo tipo,
    required String observacion,
  }) async {
    try {
      await _service.registrarError(tipo: tipo, observacion: observacion);

      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  //==========================================================
  // REGISTRAR RESTAURACIÓN
  //==========================================================

  Future<void> registrarRestauracion({
    required String nombreArchivo,
    required String rutaArchivo,
    required int tamanoBytes,
    required String versionAplicacion,
    int cantidadClientes = 0,
    int cantidadDeudas = 0,
    int cantidadPagos = 0,
    int duracionMs = 0,
  }) async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      await _service.registrarRestauracion(
        nombreArchivo: nombreArchivo,
        rutaArchivo: rutaArchivo,
        tamanoBytes: tamanoBytes,
        versionAplicacion: versionAplicacion,
        cantidadClientes: cantidadClientes,
        cantidadDeudas: cantidadDeudas,
        cantidadPagos: cantidadPagos,
        duracionMs: duracionMs,
      );

      await cargar();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());

      rethrow;
    }
  }

  //==========================================================
  // ELIMINAR
  //==========================================================

  Future<void> eliminar(int id) async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      await _service.eliminar(id);

      await cargar();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());

      rethrow;
    }
  }

  Future<void> eliminarTodos() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      await _service.eliminarTodos();

      await cargar();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());

      rethrow;
    }
  }

  //==========================================================
  // MANTENIMIENTO
  //==========================================================

  Future<void> conservarUltimos(int cantidad) async {
    try {
      await _service.conservarUltimos(cantidad);
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  Future<void> eliminarAnterioresA(DateTime fecha) async {
    try {
      await _service.eliminarAnterioresA(fecha);
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());

      rethrow;
    }
  }

  //==========================================================
  // LIMPIAR
  //==========================================================

  void limpiar() {
    state = const RespaldoState();
  }
}
