import '../../core/enums/estado_respaldo.dart';
import '../../core/enums/tipo_respaldo.dart';
import '../../models/respaldo.dart';
import '../../repositories/respaldo_repository.dart';

class RespaldoService {
  RespaldoService(this._repository);

  final RespaldoRepository _repository;

  //==========================================================
  // CONSULTAS
  //==========================================================

  Future<List<Respaldo>> obtenerTodos() {
    return _repository.obtenerTodos();
  }

  Future<Respaldo> obtenerPorId(int id) async {
    final respaldo = await _repository.obtenerPorId(id);

    if (respaldo == null) {
      throw Exception('El respaldo no existe.');
    }

    return respaldo;
  }

  Future<Respaldo> obtenerPorUuid(String uuid) async {
    final respaldo = await _repository.obtenerPorUuid(uuid);

    if (respaldo == null) {
      throw Exception('El respaldo no existe.');
    }

    return respaldo;
  }

  Future<Respaldo?> obtenerUltimo() {
    return _repository.obtenerUltimo();
  }

  Future<List<Respaldo>> obtenerExitosos() {
    return _repository.obtenerExitosos();
  }

  Future<List<Respaldo>> obtenerConErrores() {
    return _repository.obtenerConErrores();
  }

  Future<List<Respaldo>> obtenerManuales() {
    return _repository.obtenerManuales();
  }

  Future<List<Respaldo>> obtenerAutomaticos() {
    return _repository.obtenerAutomaticos();
  }

  Future<List<Respaldo>> obtenerRestauraciones() {
    return _repository.obtenerRestauraciones();
  }

  //==========================================================
  // BÚSQUEDA
  //==========================================================

  Future<List<Respaldo>> buscar(String texto) {
    return _repository.buscar(texto);
  }

  //==========================================================
  // FILTROS
  //==========================================================

  Future<List<Respaldo>> filtrar({
    TipoRespaldo? tipo,
    EstadoRespaldo? estado,
    DateTime? desde,
    DateTime? hasta,
  }) {
    return _repository.filtrar(
      tipo: tipo,
      estado: estado,
      desde: desde,
      hasta: hasta,
    );
  }

  //==========================================================
  // CRUD
  //==========================================================

  Future<void> guardar(Respaldo respaldo) async {
    await _repository.guardar(respaldo);
  }

  Future<void> eliminar(int id) async {
    final existe = await _repository.existe(id);

    if (!existe) {
      throw Exception('El respaldo no existe.');
    }

    await _repository.eliminar(id);
  }

  Future<void> eliminarTodos() async {
    await _repository.eliminarTodos();
  }

  //==========================================================
  // CONTADORES
  //==========================================================

  Future<int> contar() {
    return _repository.contar();
  }

  Future<int> contarExitosos() {
    return _repository.contarExitosos();
  }

  Future<int> contarErrores() {
    return _repository.contarErrores();
  }

  Future<int> contarManuales() {
    return _repository.contarManuales();
  }

  Future<int> contarAutomaticos() {
    return _repository.contarAutomaticos();
  }

  Future<int> contarRestauraciones() {
    return _repository.contarRestauraciones();
  }

  //==========================================================
  // EXISTENCIA
  //==========================================================

  Future<bool> existe(int id) {
    return _repository.existe(id);
  }

  Future<bool> existeUuid(String uuid) {
    return _repository.existeUuid(uuid);
  }

  Future eliminarAnterioresA(DateTime fecha) async {
    await _repository.eliminarAnterioresA(fecha);
  }

  Future conservarUltimos(int cantidad) async {
    await _repository.conservarUltimos(cantidad);
  }

  //==========================================================
  // REGISTROS
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
    final respaldo = Respaldo()
      ..tipo = tipo
      ..estado = estado
      ..fecha = DateTime.now()
      ..nombreArchivo = nombreArchivo
      ..rutaArchivo = rutaArchivo
      ..tamanoBytes = tamanoBytes
      ..versionAplicacion = versionAplicacion
      ..observacion = observacion
      ..cantidadClientes = cantidadClientes
      ..cantidadDeudas = cantidadDeudas
      ..cantidadPagos = cantidadPagos
      ..duracionMs = duracionMs;

    await guardar(respaldo);
  }

  Future<void> registrarError({
    required TipoRespaldo tipo,
    required String observacion,
  }) async {
    await registrarRespaldo(
      tipo: tipo,
      estado: EstadoRespaldo.error,
      nombreArchivo: '',
      rutaArchivo: '',
      tamanoBytes: 0,
      versionAplicacion: '',
      observacion: observacion,
    );
  }

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
    await registrarRespaldo(
      tipo: TipoRespaldo.restauracion,
      estado: EstadoRespaldo.exitoso,
      nombreArchivo: nombreArchivo,
      rutaArchivo: rutaArchivo,
      tamanoBytes: tamanoBytes,
      versionAplicacion: versionAplicacion,
      cantidadClientes: cantidadClientes,
      cantidadDeudas: cantidadDeudas,
      cantidadPagos: cantidadPagos,
      duracionMs: duracionMs,
    );
  }
}
