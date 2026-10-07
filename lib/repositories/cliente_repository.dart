import 'package:isar/isar.dart';

import '../models/cliente.dart';

class ClienteRepository {
  ClienteRepository(this.isar);

  final Isar isar;

  Future<List<Cliente>> obtenerTodos() {
    return isar.clientes.where().sortByNombre().findAll();
  }

  Future<List<Cliente>> obtenerActivos() {
    return isar.clientes.filter().activoEqualTo(true).sortByNombre().findAll();
  }

  Future<List<Cliente>> obtenerInactivos() {
    return isar.clientes.filter().activoEqualTo(false).sortByNombre().findAll();
  }

  Future<Cliente?> obtenerPorId(Id id) {
    return isar.clientes.get(id);
  }

  Future<Cliente?> obtenerPorUuid(String uuid) {
    return isar.clientes.filter().uuidEqualTo(uuid).findFirst();
  }

  Future<Cliente?> obtenerPorNombre(String nombre) {
    return isar.clientes
        .filter()
        .nombreEqualTo(nombre, caseSensitive: false)
        .findFirst();
  }

  Future<Cliente?> obtenerPorTelefono(String telefono) {
    return isar.clientes
        .filter()
        .telefonoEqualTo(telefono, caseSensitive: false)
        .findFirst();
  }

  Future<List<Cliente>> buscar(String texto) {
    return isar.clientes
        .filter()
        .group(
          (q) => q
              .nombreContains(texto, caseSensitive: false)
              .or()
              .telefonoContains(texto, caseSensitive: false),
        )
        .sortByNombre()
        .findAll();
  }

  Future<List<Cliente>> filtrar({
    String? nombre,
    String? telefono,
    bool? activo,
  }) {
    return isar.clientes
        .filter()
        .optional(
          nombre != null && nombre.trim().isNotEmpty,
          (q) => q.nombreContains(nombre!.trim(), caseSensitive: false),
        )
        .optional(
          telefono != null && telefono.trim().isNotEmpty,
          (q) => q.telefonoContains(telefono!.trim(), caseSensitive: false),
        )
        .optional(activo != null, (q) => q.activoEqualTo(activo!))
        .sortByNombre()
        .findAll();
  }

  Future<int> contar() {
    return isar.clientes.count();
  }

  Future<int> contarActivos() {
    return isar.clientes.filter().activoEqualTo(true).count();
  }

  Future<int> contarInactivos() {
    return isar.clientes.filter().activoEqualTo(false).count();
  }

  Future<void> guardar(Cliente cliente) async {
    await isar.writeTxn(() async {
      await isar.clientes.put(cliente);
    });
  }

  Future<void> guardarTodos(List<Cliente> clientes) async {
    await isar.writeTxn(() async {
      await isar.clientes.putAll(clientes);
    });
  }

  Future<void> eliminar(Id id) async {
    await isar.writeTxn(() async {
      await isar.clientes.delete(id);
    });
  }

  Future<void> eliminarTodos(List<Id> ids) async {
    await isar.writeTxn(() async {
      await isar.clientes.deleteAll(ids);
    });
  }

  Future<void> limpiar() async {
    await isar.writeTxn(() async {
      await isar.clientes.clear();
    });
  }
}
