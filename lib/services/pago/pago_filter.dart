import '../../core/enums/metodo_pago.dart';
import '../../core/enums/pago_orden.dart';

class PagoFilter {
  const PagoFilter({
    this.deudaId,
    this.metodoPago,
    this.desde,
    this.hasta,
    this.eliminado,
    this.texto,
    this.numeroPago,
    this.numeroDeuda,
    this.orden = PagoOrden.fechaDesc,
  });

  /// Deuda asociada
  final int? deudaId;

  /// Método de pago
  final MetodoPago? metodoPago;

  /// Fecha inicial
  final DateTime? desde;

  /// Fecha final
  final DateTime? hasta;

  /// Eliminado lógico
  final bool? eliminado;

  /// Búsqueda libre
  final String? texto;

  /// Número visible de la deuda.
  final String? numeroPago;
  final String? numeroDeuda;

  final PagoOrden orden;

  bool get tieneFiltros {
    return deudaId != null ||
        metodoPago != null ||
        desde != null ||
        hasta != null ||
        eliminado != null ||
        (texto?.trim().isNotEmpty ?? false) ||
        (numeroPago?.trim().isNotEmpty ?? false) ||
        (numeroDeuda?.trim().isNotEmpty ?? false) ||
        orden != PagoOrden.fechaDesc;
  }

  bool get tieneFiltroFecha {
    return desde != null || hasta != null;
  }

  bool get tieneBusqueda {
    return texto?.trim().isNotEmpty ?? false;
  }

  PagoFilter copyWith({
    int? deudaId,
    MetodoPago? metodoPago,
    DateTime? desde,
    DateTime? hasta,
    bool? eliminado,
    String? texto,
    String? numeroPago,
    String? numeroDeuda,
    PagoOrden? orden,

    bool clearDeuda = false,
    bool clearMetodoPago = false,
    bool clearDesde = false,
    bool clearHasta = false,
    bool clearEliminado = false,
    bool clearTexto = false,
    bool clearNumeroPago = false,
    bool clearNumeroDeuda = false,
  }) {
    return PagoFilter(
      deudaId: clearDeuda ? null : (deudaId ?? this.deudaId),
      metodoPago: clearMetodoPago ? null : (metodoPago ?? this.metodoPago),
      desde: clearDesde ? null : (desde ?? this.desde),
      hasta: clearHasta ? null : (hasta ?? this.hasta),
      eliminado: clearEliminado ? null : (eliminado ?? this.eliminado),
      numeroPago: clearNumeroPago ? null : (numeroPago ?? this.numeroPago),
      numeroDeuda: clearNumeroDeuda ? null : (numeroDeuda ?? this.numeroDeuda),
      texto: clearTexto ? null : (texto ?? this.texto),
      orden: orden ?? this.orden,
    );
  }

  PagoFilter limpiar() {
    return const PagoFilter();
  }

  @override
  String toString() {
    return '''
PagoFilter(
  deudaId: $deudaId,
  metodoPago: $metodoPago,
  desde: $desde,
  hasta: $hasta,
  eliminado: $eliminado,
  texto: $texto,
  numeroPago: $numeroPago,
  numeroDeuda: $numeroDeuda,
  orden: $orden
)
''';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PagoFilter &&
            runtimeType == other.runtimeType &&
            deudaId == other.deudaId &&
            metodoPago == other.metodoPago &&
            desde == other.desde &&
            hasta == other.hasta &&
            eliminado == other.eliminado &&
            texto == other.texto &&
            numeroPago == other.numeroPago &&
            numeroDeuda == other.numeroDeuda &&
            orden == other.orden;
  }

  @override
  int get hashCode => Object.hash(
    deudaId,
    metodoPago,
    desde,
    hasta,
    eliminado,
    texto,
    numeroPago,
    numeroDeuda,
    orden,
  );
}
