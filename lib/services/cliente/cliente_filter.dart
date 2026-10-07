import '../../views/clientes/sheets/cliente_filter_sheet.dart';

class ClienteFilter {
  /// Texto general para búsqueda.
  /// Se utilizará sobre nombre y teléfono.
  final String? texto;

  /// Filtrar únicamente por nombre.
  final String? nombre;

  /// Filtrar únicamente por teléfono.
  final String? telefono;

  /// Clientes activos/inactivos.
  /// null = todos.
  final bool? activo;

  final ClienteOrden ordenarPor;

  /// Orden ascendente.
  final bool ascendente;

  const ClienteFilter({
    this.texto,
    this.nombre,
    this.telefono,
    this.activo,
    this.ordenarPor = ClienteOrden.nombreAsc,
    this.ascendente = true,
  });

  /// Indica si existe al menos un filtro aplicado.
  bool get tieneFiltros {
    return (texto?.trim().isNotEmpty ?? false) ||
        (nombre?.trim().isNotEmpty ?? false) ||
        (telefono?.trim().isNotEmpty ?? false) ||
        activo != null;
  }

  /// Reinicia todos los filtros.
  ClienteFilter clear() {
    return const ClienteFilter();
  }

  /// Permite actualizar únicamente los filtros necesarios.
  ClienteFilter copyWith({
    String? texto,
    String? nombre,
    String? telefono,
    bool? activo,
    ClienteOrden? ordenarPor,
    bool? ascendente,
    bool clearActivo = false,
  }) {
    return ClienteFilter(
      texto: texto ?? this.texto,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      activo: clearActivo ? null : (activo ?? this.activo),
      ordenarPor: ordenarPor ?? this.ordenarPor,
      ascendente: ascendente ?? this.ascendente,
    );
  }

  @override
  String toString() {
    return '''
ClienteFilter(
  texto: $texto,
  nombre: $nombre,
  telefono: $telefono,
  activo: $activo,
  ordenarPor: $ordenarPor,
  ascendente: $ascendente
)
''';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ClienteFilter &&
            runtimeType == other.runtimeType &&
            texto == other.texto &&
            nombre == other.nombre &&
            telefono == other.telefono &&
            activo == other.activo &&
            ordenarPor == other.ordenarPor &&
            ascendente == other.ascendente;
  }

  @override
  int get hashCode =>
      Object.hash(texto, nombre, telefono, activo, ordenarPor, ascendente);
}
