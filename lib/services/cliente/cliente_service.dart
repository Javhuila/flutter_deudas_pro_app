import '../../models/cliente.dart';
import '../../repositories/cliente_repository.dart';
import '../deuda/deuda_service.dart';
import 'cliente_exception.dart';
import 'cliente_filter.dart';
import 'cliente_summary.dart';
import 'cliente_validator.dart';

class ClienteService {
  ClienteService({required this._repository, required this._deudaService})
    : _validator = ClienteValidator(_repository);

  final ClienteRepository _repository;
  final ClienteValidator _validator;
  final DeudaService _deudaService;

  //==========================================================
  // CRUD
  //==========================================================

  Future<Cliente> crear(Cliente cliente) async {
    await _validator.validar(cliente);

    cliente.nombre = cliente.nombre.trim();
    cliente.telefono = cliente.telefono?.trim();
    cliente.direccion = cliente.direccion?.trim();
    cliente.observacion = cliente.observacion?.trim();

    cliente.fechaActualizacion = DateTime.now();

    await _repository.guardar(cliente);

    return cliente;
  }

  Future<Cliente> editar(Cliente cliente) async {
    final actual = await _repository.obtenerPorId(cliente.id);

    if (actual == null) {
      throw const ClienteException('El cliente no existe.');
    }

    await _validator.validar(cliente);

    cliente.nombre = cliente.nombre.trim();
    cliente.telefono = cliente.telefono?.trim();
    cliente.direccion = cliente.direccion?.trim();
    cliente.observacion = cliente.observacion?.trim();

    cliente.fechaActualizacion = DateTime.now();

    await _repository.guardar(cliente);

    return cliente;
  }

  Future<void> eliminar(int id) async {
    final cliente = await _repository.obtenerPorId(id);

    if (cliente == null) {
      throw const ClienteException('El cliente no existe.');
    }

    final puede = await puedeEliminar(id);

    if (!puede) {
      throw const ClienteException('El cliente posee deudas registradas.');
    }

    await _repository.eliminar(id);
  }

  Future<void> activar(int id) async {
    final cliente = await _repository.obtenerPorId(id);

    if (cliente == null) {
      throw const ClienteException('El cliente no existe.');
    }

    cliente.activo = true;
    cliente.fechaActualizacion = DateTime.now();

    await _repository.guardar(cliente);
  }

  Future<void> desactivar(int id) async {
    final cliente = await _repository.obtenerPorId(id);

    if (cliente == null) {
      throw const ClienteException('El cliente no existe.');
    }

    cliente.activo = false;
    cliente.fechaActualizacion = DateTime.now();

    await _repository.guardar(cliente);
  }

  //==========================================================
  // CONSULTAS
  //==========================================================

  Future<List<Cliente>> obtenerTodos() {
    return _repository.obtenerTodos();
  }

  Future<List<Cliente>> obtenerActivos() {
    return _repository.obtenerActivos();
  }

  Future<List<Cliente>> obtenerInactivos() {
    return _repository.obtenerInactivos();
  }

  Future<Cliente?> obtenerPorId(int id) {
    return _repository.obtenerPorId(id);
  }

  Future<Cliente?> obtenerPorUuid(String uuid) {
    return _repository.obtenerPorUuid(uuid);
  }

  Future<List<Cliente>> buscar(String texto) {
    return _repository.buscar(texto.trim());
  }

  //==========================================================
  // FILTROS
  //==========================================================

  Future<List<Cliente>> filtrar(ClienteFilter filter) {
    if (!filter.tieneFiltros) {
      return _repository.obtenerTodos();
    }

    return _repository.filtrar(
      nombre: filter.nombre ?? filter.texto,
      telefono: filter.telefono ?? filter.texto,
      activo: filter.activo,
    );
  }

  //==========================================================
  // VALIDACIONES
  //==========================================================

  Future<void> validar(Cliente cliente) {
    return _validator.validar(cliente);
  }

  Future<bool> existeNombre(String nombre) {
    return _validator.existeNombre(nombre);
  }

  Future<bool> existeTelefono(String telefono) {
    return _validator.existeTelefono(telefono);
  }

  //==========================================================
  // ESTADÍSTICAS
  //==========================================================

  Future<int> contarClientes() {
    return _repository.contar();
  }

  Future<int> contarClientesActivos() {
    return _repository.contarActivos();
  }

  Future<int> contarClientesInactivos() {
    return _repository.contarInactivos();
  }

  //==========================================================
  // RESUMEN
  //==========================================================

  Future<ClienteSummary> obtenerResumen(int clienteId) async {
    final cliente = await _repository.obtenerPorId(clienteId);

    if (cliente == null) {
      throw const ClienteException('El cliente no existe.');
    }

    final resumenes = await _deudaService.obtenerResumenCliente(clienteId);

    final cantidadDeudas = resumenes.length;

    final saldoPendiente = resumenes.fold<double>(
      0,
      (total, resumen) => total + resumen.saldoPendiente,
    );

    return ClienteSummary(
      cliente: cliente,
      cantidadDeudas: cantidadDeudas,
      saldoPendiente: saldoPendiente,
    );
  }

  Future<List<ClienteSummary>> obtenerResumenes(List<Cliente> clientes) async {
    return Future.wait(clientes.map((cliente) => obtenerResumen(cliente.id)));
  }

  //==========================================================
  // UTILIDADES
  //==========================================================

  Future<bool> tieneDeudas(int clienteId) async {
    // Será implementado cuando exista DeudaRepository.
    return false;
  }

  Future<bool> puedeEliminar(int clienteId) async {
    return !(await tieneDeudas(clienteId));
  }

  //==========================================================
  // EXPORTACIÓN
  //==========================================================

  Future<List<Cliente>> obtenerParaExportar() {
    return _repository.obtenerTodos();
  }

  //==========================================================
  // IMPORTACIÓN
  //==========================================================

  Future<void> importar(List<Cliente> clientes) async {
    for (final cliente in clientes) {
      await _validator.validar(cliente);
    }

    await _repository.guardarTodos(clientes);
  }

  //==========================================================
  // MANTENIMIENTO
  //==========================================================

  Future<void> eliminarTodos() {
    return _repository.limpiar();
  }
}
