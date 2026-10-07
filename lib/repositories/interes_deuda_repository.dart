import 'package:isar/isar.dart';

import '../models/deuda.dart';
import '../models/interes_deuda.dart';

class InteresDeudaRepository {
  InteresDeudaRepository(this.isar);

  final Isar isar;

  //==========================================================
  // CONSULTAS
  //==========================================================

  Future<List<InteresDeuda>> obtenerTodos() {
    return isar.interesDeudas.where().sortByFechaInicio().findAll();
  }

  Future<InteresDeuda?> obtenerPorId(Id id) {
    return isar.interesDeudas.get(id);
  }

  Future<InteresDeuda?> obtenerPorUuid(String uuid) {
    return isar.interesDeudas.filter().uuidEqualTo(uuid).findFirst();
  }

  Future<List<InteresDeuda>> obtenerPorDeuda(Id deudaId) {
    return isar.interesDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .sortByNumeroPeriodo()
        .findAll();
  }

  Future<InteresDeuda?> obtenerPorPeriodo(Id deudaId, int numeroPeriodo) {
    return isar.interesDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .numeroPeriodoEqualTo(numeroPeriodo)
        .findFirst();
  }

  Future<List<InteresDeuda>> obtenerPendientes(Id deudaId) {
    return isar.interesDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .pagadoEqualTo(false)
        .sortByNumeroPeriodo()
        .findAll();
  }

  Future<List<InteresDeuda>> obtenerPagados(Id deudaId) {
    return isar.interesDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .pagadoEqualTo(true)
        .sortByNumeroPeriodo()
        .findAll();
  }

  //==========================================================
  // ESCRITURA
  //==========================================================

  Future<void> guardar(InteresDeuda interes) async {
    await isar.writeTxn(() async {
      await isar.interesDeudas.put(interes);
      await interes.deuda.save();
    });
  }

  Future<void> guardarTodos(List<InteresDeuda> intereses) async {
    if (intereses.isEmpty) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.interesDeudas.putAll(intereses);

      for (final interes in intereses) {
        await interes.deuda.save();
      }
    });
  }

  Future<void> eliminar(Id id) async {
    await isar.writeTxn(() async {
      await isar.interesDeudas.delete(id);
    });
  }

  Future<void> eliminarTodos(List<Id> ids) async {
    if (ids.isEmpty) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.interesDeudas.deleteAll(ids);
    });
  }

  Future<void> limpiar() async {
    await isar.writeTxn(() async {
      await isar.interesDeudas.clear();
    });
  }
}
