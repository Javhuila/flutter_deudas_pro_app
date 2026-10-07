import 'package:isar/isar.dart';

import '../core/enums/estado_respaldo.dart';
import '../core/enums/tipo_respaldo.dart';
import '../models/respaldo.dart';

class RespaldoRepository {
  final Isar isar;

  RespaldoRepository(this.isar);

  //==========================================================
  // CONSULTAS
  //==========================================================

  Future<List<Respaldo>> obtenerTodos() {
    return isar.respaldos.where().sortByFechaDesc().findAll();
  }

  Future<Respaldo?> obtenerPorId(Id id) {
    return isar.respaldos.get(id);
  }

  Future<Respaldo?> obtenerPorUuid(String uuid) {
    return isar.respaldos.filter().uuidEqualTo(uuid).findFirst();
  }

  Future<Respaldo?> obtenerUltimo() {
    return isar.respaldos.where().sortByFechaDesc().findFirst();
  }

  Future<List<Respaldo>> obtenerExitosos() {
    return isar.respaldos
        .filter()
        .estadoEqualTo(EstadoRespaldo.exitoso)
        .sortByFechaDesc()
        .findAll();
  }

  Future<List<Respaldo>> obtenerConErrores() {
    return isar.respaldos
        .filter()
        .estadoEqualTo(EstadoRespaldo.error)
        .sortByFechaDesc()
        .findAll();
  }

  Future<List<Respaldo>> obtenerManuales() {
    return isar.respaldos
        .filter()
        .tipoEqualTo(TipoRespaldo.manual)
        .sortByFechaDesc()
        .findAll();
  }

  Future<List<Respaldo>> obtenerAutomaticos() {
    return isar.respaldos
        .filter()
        .tipoEqualTo(TipoRespaldo.automatico)
        .sortByFechaDesc()
        .findAll();
  }

  Future<List<Respaldo>> obtenerRestauraciones() {
    return isar.respaldos
        .filter()
        .tipoEqualTo(TipoRespaldo.restauracion)
        .sortByFechaDesc()
        .findAll();
  }

  //==========================================================
  // BÚSQUEDA
  //==========================================================

  Future<List<Respaldo>> buscar(String texto) {
    return isar.respaldos
        .filter()
        .group(
          (q) => q
              .nombreArchivoContains(texto, caseSensitive: false)
              .or()
              .rutaArchivoContains(texto, caseSensitive: false)
              .or()
              .versionAplicacionContains(texto, caseSensitive: false)
              .or()
              .observacionContains(texto, caseSensitive: false),
        )
        .sortByFechaDesc()
        .findAll();
  }

  //==========================================================
  // FILTROS
  //==========================================================

  Future<List<Respaldo>> filtrar({
    TipoRespaldo? tipo,
    EstadoRespaldo? estado,
    DateTime? desde,
    DateTime? hasta,
  }) async {
    return isar.respaldos
        .filter()
        .optional(tipo != null, (q) => q.tipoEqualTo(tipo!))
        .optional(estado != null, (q) => q.estadoEqualTo(estado!))
        .optional(
          desde != null,
          (q) => q.fechaGreaterThan(desde!, include: true),
        )
        .optional(hasta != null, (q) => q.fechaLessThan(hasta!, include: true))
        .sortByFechaDesc()
        .findAll();
  }

  //==========================================================
  // CRUD
  //==========================================================

  Future<void> guardar(Respaldo respaldo) async {
    await isar.writeTxn(() async {
      await isar.respaldos.put(respaldo);
    });
  }

  Future<void> guardarTodos(List<Respaldo> respaldos) async {
    await isar.writeTxn(() async {
      await isar.respaldos.putAll(respaldos);
    });
  }

  Future<void> eliminar(Id id) async {
    await isar.writeTxn(() async {
      await isar.respaldos.delete(id);
    });
  }

  Future<void> eliminarTodos() async {
    await isar.writeTxn(() async {
      await isar.respaldos.clear();
    });
  }

  //==========================================================
  // CONTADORES
  //==========================================================

  Future<int> contar() {
    return isar.respaldos.count();
  }

  Future<int> contarExitosos() {
    return isar.respaldos
        .filter()
        .estadoEqualTo(EstadoRespaldo.exitoso)
        .count();
  }

  Future<int> contarErrores() {
    return isar.respaldos.filter().estadoEqualTo(EstadoRespaldo.error).count();
  }

  Future<int> contarManuales() {
    return isar.respaldos.filter().tipoEqualTo(TipoRespaldo.manual).count();
  }

  Future<int> contarAutomaticos() {
    return isar.respaldos.filter().tipoEqualTo(TipoRespaldo.automatico).count();
  }

  Future<int> contarRestauraciones() {
    return isar.respaldos
        .filter()
        .tipoEqualTo(TipoRespaldo.restauracion)
        .count();
  }

  //==========================================================
  // EXISTENCIA
  //==========================================================

  Future<bool> existe(Id id) async {
    return await isar.respaldos.get(id) != null;
  }

  Future<bool> existeUuid(String uuid) async {
    return await obtenerPorUuid(uuid) != null;
  }

  //==========================================================
  // MANTENIMIENTO
  //==========================================================

  Future<void> eliminarAnterioresA(DateTime fecha) async {
    final registros = await isar.respaldos
        .filter()
        .fechaLessThan(fecha)
        .findAll();

    if (registros.isEmpty) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.respaldos.deleteAll(registros.map((e) => e.id).toList());
    });
  }

  Future<void> conservarUltimos(int cantidad) async {
    final registros = await obtenerTodos();

    if (registros.length <= cantidad) {
      return;
    }

    final eliminar = registros.skip(cantidad);

    await isar.writeTxn(() async {
      await isar.respaldos.deleteAll(eliminar.map((e) => e.id).toList());
    });
  }
}
