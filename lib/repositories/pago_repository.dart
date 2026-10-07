import 'package:isar/isar.dart';

import '../core/enums/metodo_pago.dart';
import '../models/cuota_deuda.dart';
import '../models/deuda.dart';
import '../models/pago.dart';

// import '../models/pago.dart';

class PagoRepository {
  final Isar isar;

  PagoRepository(this.isar);

  Future<List<Pago>> obtenerTodos() {
    return isar.pagos
        .filter()
        .eliminadoEqualTo(false)
        .sortByFechaPagoDesc()
        .findAll();
  }

  Future<List<Pago>> obtenerActivos() {
    return isar.pagos
        .filter()
        .eliminadoEqualTo(false)
        .sortByFechaPagoDesc()
        .findAll();
  }

  Future<List<Pago>> obtenerEliminados() {
    return isar.pagos
        .filter()
        .eliminadoEqualTo(true)
        .sortByFechaPagoDesc()
        .findAll();
  }

  Future<Pago?> obtenerPorId(Id id) {
    return isar.pagos.get(id);
  }

  Future<Pago?> obtenerPorUuid(String uuid) {
    return isar.pagos.filter().uuidEqualTo(uuid).findFirst();
  }

  Future<List<Pago>> obtenerPorDeuda(Id deudaId) {
    return isar.pagos
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .sortByFechaPagoDesc()
        .findAll();
  }

  //==========================================================
  // RELACIÓN PAGO <-> CUOTA
  //==========================================================
  Future<List<CuotaDeuda>> obtenerCuotas(int pagoId) async {
    final pago = await obtenerPorId(pagoId);
    if (pago == null) {
      return [];
    }
    await pago.cuotas.load();
    return pago.cuotas.toList();
  }

  Future<void> asignarCuotas(Pago pago, List<CuotaDeuda> cuotas) async {
    await isar.writeTxn(() async {
      final pagoActual = await isar.pagos.get(pago.id);
      if (pagoActual == null) {
        return;
      }
      await pagoActual.cuotas.load();
      pagoActual.cuotas.clear();
      pagoActual.cuotas.addAll(cuotas);
      await pagoActual.cuotas.save();
    });
  }

  Future<void> quitarCuotas(Pago pago) async {
    await isar.writeTxn(() async {
      final pagoActual = await isar.pagos.get(pago.id);
      if (pagoActual == null) {
        return;
      }
      await pagoActual.cuotas.load();
      pagoActual.cuotas.clear();
      await pagoActual.cuotas.save();
    });
  }

  //==========================================================
  // BÚSQUEDA
  //==========================================================

  Future<List<Pago>> buscar(String texto) {
    final value = texto.trim();

    if (value.isEmpty) {
      return obtenerTodos();
    }

    return isar.pagos
        .filter()
        .referenciaContains(value, caseSensitive: false)
        .or()
        .observacionContains(value, caseSensitive: false)
        .sortByFechaPagoDesc()
        .findAll();
  }

  //==========================================================
  // FILTROS
  //==========================================================

  Future<List<Pago>> filtrar({
    Id? deudaId,
    MetodoPago? metodoPago,
    bool? eliminado,
    DateTime? desde,
    DateTime? hasta,
  }) {
    return isar.pagos
        .filter()
        .optional(deudaId != null, (q) => q.deuda((q) => q.idEqualTo(deudaId!)))
        .optional(metodoPago != null, (q) => q.metodoPagoEqualTo(metodoPago!))
        .optional(eliminado != null, (q) => q.eliminadoEqualTo(eliminado!))
        .optional(
          desde != null,
          (q) => q.fechaPagoGreaterThan(desde!, include: true),
        )
        .optional(
          hasta != null,
          (q) => q.fechaPagoLessThan(hasta!, include: true),
        )
        .sortByFechaPagoDesc()
        .findAll();
  }

  //==========================================================
  // DASHBOARD
  //==========================================================

  Future<List<Pago>> obtenerHoy() {
    final hoy = DateTime.now();

    final inicio = DateTime(hoy.year, hoy.month, hoy.day);

    final fin = inicio.add(const Duration(days: 1));

    return isar.pagos
        .filter()
        .fechaPagoBetween(inicio, fin, includeUpper: false)
        .sortByFechaPagoDesc()
        .findAll();
  }

  Future<List<Pago>> obtenerEstaSemana() {
    final hoy = DateTime.now();

    final inicio = DateTime(hoy.year, hoy.month, hoy.day);

    final fin = inicio.add(const Duration(days: 7));

    return isar.pagos
        .filter()
        .fechaPagoBetween(inicio, fin)
        .sortByFechaPagoDesc()
        .findAll();
  }

  Future<List<Pago>> obtenerEsteMes() {
    final hoy = DateTime.now();

    final inicio = DateTime(hoy.year, hoy.month, 1);

    final fin = DateTime(hoy.year, hoy.month + 1, 1);

    return isar.pagos
        .filter()
        .fechaPagoBetween(inicio, fin, includeUpper: false)
        .sortByFechaPagoDesc()
        .findAll();
  }

  Future<List<Pago>> obtenerUltimos(int cantidad) {
    return isar.pagos.where().sortByFechaPagoDesc().limit(cantidad).findAll();
  }

  //==========================================================
  // CONTADORES
  //==========================================================

  Future<int> contar() {
    return isar.pagos.count();
  }

  Future<int> contarHoy() async {
    return (await obtenerHoy()).length;
  }

  Future<int> contarEsteMes() async {
    return (await obtenerEsteMes()).length;
  }

  //==========================================================
  // ESCRITURA
  //==========================================================

  Future<void> guardar(Pago pago) async {
    await isar.writeTxn(() async {
      await isar.pagos.put(pago);
      await pago.deuda.save();
      await pago.interes.save();
      await pago.cuotas.save();
    });
  }

  Future<void> guardarTodos(List<Pago> pagos) async {
    await isar.writeTxn(() async {
      await isar.pagos.putAll(pagos);

      for (final pago in pagos) {
        await pago.deuda.save();
        await pago.interes.save();
        await pago.cuotas.save();
      }
    });
  }

  Future<void> eliminar(Id id) async {
    await isar.writeTxn(() async {
      final pago = await isar.pagos.get(id);

      if (pago == null) {
        return;
      }

      pago.eliminado = true;
      pago.fechaActualizacion = DateTime.now();

      await isar.pagos.put(pago);
    });
  }

  Future<void> eliminarTodos(List<Id> ids) async {
    await isar.writeTxn(() async {
      await isar.pagos.deleteAll(ids);
    });
  }

  Future<void> limpiar() async {
    await isar.writeTxn(() async {
      await isar.pagos.clear();
    });
  }
}
