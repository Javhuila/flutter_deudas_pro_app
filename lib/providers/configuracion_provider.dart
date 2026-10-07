import 'package:flutter_deudas_pro_app/services/configuracion/configuracion_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/isar_provider.dart';
import '../core/enums/frecuencia_backup.dart';
import '../models/configuracion.dart';
import '../repositories/configuracion_repository.dart';

final configuracionRepositoryProvider = Provider<ConfiguracionRepository>((
  ref,
) {
  return ConfiguracionRepository(ref.watch(isarProvider));
});

final configuracionServiceProvider = Provider<ConfiguracionService>((ref) {
  return ConfiguracionService(ref.watch(configuracionRepositoryProvider));
});

final configuracionProvider =
    StateNotifierProvider<ConfiguracionNotifier, ConfiguracionState>((ref) {
      return ConfiguracionNotifier(ref.watch(configuracionServiceProvider));
    });

class ConfiguracionState {
  const ConfiguracionState({
    this.configuracion,
    this.loading = false,
    this.error,
  });

  final Configuracion? configuracion;
  final bool loading;
  final String? error;

  bool get cargada => configuracion != null;

  bool get hayError => error != null;

  ConfiguracionState copyWith({
    Configuracion? configuracion,
    bool? loading,
    String? error,
    bool clearError = false,
  }) {
    return ConfiguracionState(
      configuracion: configuracion ?? this.configuracion,
      loading: loading ?? this.loading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class ConfiguracionNotifier extends StateNotifier<ConfiguracionState> {
  ConfiguracionNotifier(this._service)
    : super(const ConfiguracionState(loading: true)) {
    cargar();
  }

  final ConfiguracionService _service;

  //==========================================================
  // CARGA
  //==========================================================

  Future<void> cargar() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      final configuracion = await _service.obtener();

      state = state.copyWith(
        configuracion: configuracion,
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
  // TEMA
  //==========================================================

  Future<void> cambiarTemaOscuro(bool activar) async {
    try {
      await _service.cambiarTemaOscuro(activar);
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  //==========================================================
  // NOTIFICACIONES
  //==========================================================

  Future<void> cambiarNotificaciones(bool activar) async {
    try {
      await _service.cambiarEstadoNotificaciones(activar);
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> actualizarDiasAnticipacion(int dias) async {
    try {
      await _service.actualizarDiasAnticipacion(dias);
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> actualizarHoraNotificacion(int hora, int minuto) async {
    try {
      await _service.actualizarHoraNotificacion(hora, minuto);
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> cambiarAvisoDeudasVencidas(bool activar) async {
    try {
      if (activar) {
        await _service.activarAvisoDeudasVencidas();
      } else {
        await _service.desactivarAvisoDeudasVencidas();
      }

      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> cambiarAvisoPagosPendientes(bool activar) async {
    try {
      if (activar) {
        await _service.activarAvisoPagosPendientes();
      } else {
        await _service.desactivarAvisoPagosPendientes();
      }

      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  //==========================================================
  // BACKUP
  //==========================================================

  Future<void> cambiarBackupAutomatico(bool activar) async {
    try {
      await _service.cambiarBackupAutomatico(activar);
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> cambiarFrecuenciaBackup(FrecuenciaBackup frecuencia) async {
    try {
      await _service.cambiarFrecuenciaBackup(frecuencia);
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> actualizarHoraBackup(int hora, int minuto) async {
    try {
      await _service.actualizarHoraBackup(hora, minuto);

      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> actualizarCarpetaBackup(
    String? carpeta,
    String? carpetaUri,
  ) async {
    try {
      await _service.actualizarCarpetaBackup(carpeta, carpetaUri);

      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> actualizarMaximoBackups(int cantidad) async {
    try {
      await _service.actualizarMaximoBackups(cantidad);

      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> registrarUltimoBackup() async {
    try {
      await _service.registrarUltimoBackup();
      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  //==========================================================
  // EXPORTACIONES
  //==========================================================

  Future<void> cambiarExportarPdf(bool activar) async {
    try {
      if (activar) {
        await _service.activarExportarPdf();
      } else {
        await _service.desactivarExportarPdf();
      }

      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> cambiarExportarExcel(bool activar) async {
    try {
      if (activar) {
        await _service.activarExportarExcel();
      } else {
        await _service.desactivarExportarExcel();
      }

      await cargar();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  //==========================================================
  // RESTAURAR CONFIGURACIÓN
  //==========================================================

  Future<void> restaurarValores() async {
    try {
      state = state.copyWith(loading: true, clearError: true);

      await _service.restaurarValores();

      await cargar();
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
