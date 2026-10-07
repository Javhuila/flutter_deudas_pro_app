import '../../core/enums/estado_deuda.dart';

class DeudaFilter {
  /// Texto de búsqueda (nombre del cliente).
  final String? texto;

  /// Número visible de la deuda.
  final String? numeroDeuda;

  /// Cliente específico.
  final int? clienteId;

  /// Estado de la deuda.
  final EstadoDeuda? estado;

  /// Mostrar únicamente archivadas o activas.
  /// null = todas.
  final bool? archivada;

  /// Fecha inicial del préstamo.
  final DateTime? desde;

  /// Fecha final del préstamo.
  final DateTime? hasta;

  /// Mostrar orden ascendente.
  final bool ascendente;

  const DeudaFilter({
    this.texto,
    this.numeroDeuda,
    this.clienteId,
    this.estado,
    this.archivada,
    this.desde,
    this.hasta,
    this.ascendente = false,
  });

  ///==========================================================
  /// GETTERS
  ///==========================================================

  bool get tieneFiltros {
    return (texto?.trim().isNotEmpty ?? false) ||
        (numeroDeuda?.trim().isNotEmpty ?? false) ||
        clienteId != null ||
        estado != null ||
        archivada != null ||
        desde != null ||
        hasta != null;
  }

  ///==========================================================
  /// COPY WITH
  ///==========================================================

  DeudaFilter copyWith({
    String? texto,
    String? numeroDeuda,
    int? clienteId,
    EstadoDeuda? estado,
    bool? archivada,
    DateTime? desde,
    DateTime? hasta,
    bool? ascendente,
    bool clearNumeroDeuda = false,
    bool clearCliente = false,
    bool clearEstado = false,
    bool clearArchivada = false,
    bool clearDesde = false,
    bool clearHasta = false,
  }) {
    return DeudaFilter(
      texto: texto ?? this.texto,
      numeroDeuda: clearNumeroDeuda ? null : (numeroDeuda ?? this.numeroDeuda),
      clienteId: clearCliente ? null : (clienteId ?? this.clienteId),
      estado: clearEstado ? null : (estado ?? this.estado),
      archivada: clearArchivada ? null : (archivada ?? this.archivada),
      desde: clearDesde ? null : (desde ?? this.desde),
      hasta: clearHasta ? null : (hasta ?? this.hasta),
      ascendente: ascendente ?? this.ascendente,
    );
  }

  ///==========================================================
  /// LIMPIAR FILTROS
  ///==========================================================

  DeudaFilter clear() {
    return DeudaFilter(ascendente: ascendente);
  }

  @override
  String toString() {
    return '''
DeudaFilter(
  texto: $texto,
  numeroDeuda: $numeroDeuda,
  clienteId: $clienteId,
  estado: $estado,
  archivada: $archivada,
  desde: $desde,
  hasta: $hasta,
  ascendente: $ascendente
)
''';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DeudaFilter &&
            runtimeType == other.runtimeType &&
            texto == other.texto &&
            numeroDeuda == other.numeroDeuda &&
            clienteId == other.clienteId &&
            estado == other.estado &&
            archivada == other.archivada &&
            desde == other.desde &&
            hasta == other.hasta &&
            ascendente == other.ascendente;
  }

  @override
  int get hashCode => Object.hash(
    texto,
    numeroDeuda,
    clienteId,
    estado,
    archivada,
    desde,
    hasta,
    ascendente,
  );
}
