import 'package:isar/isar.dart';

import '../core/enums/estado_deuda.dart';
import '../models/cliente.dart';
import '../models/cuota_deuda.dart';
import '../models/deuda.dart';
import '../models/interes_deuda.dart';
import '../models/pago.dart';

class DeudaRepository {
  DeudaRepository(this.isar);

  final Isar isar;

  Future<List<Deuda>> obtenerTodas() async {
    final deudas = await isar.deudas
        .where()
        .sortByFechaPrestamoDesc()
        .findAll();

    for (final deuda in deudas) {
      await deuda.cliente.load();
    }

    return deudas;
  }

  Future<List<Deuda>> obtenerActivas() {
    return isar.deudas
        .filter()
        .archivadaEqualTo(false)
        .sortByFechaPrestamoDesc()
        .findAll();
  }

  Future<List<Deuda>> obtenerArchivadas() {
    return isar.deudas
        .filter()
        .archivadaEqualTo(true)
        .sortByFechaPrestamoDesc()
        .findAll();
  }

  Future<List<Deuda>> obtenerPendientes() {
    return isar.deudas
        .filter()
        .estadoEqualTo(EstadoDeuda.pendiente)
        .and()
        .archivadaEqualTo(false)
        .sortByFechaPrestamoDesc()
        .findAll();
  }

  Future<List<Deuda>> obtenerPagadas() {
    return isar.deudas
        .filter()
        .estadoEqualTo(EstadoDeuda.pagada)
        .sortByFechaPrestamoDesc()
        .findAll();
  }

  Future<List<Deuda>> obtenerVencidas() {
    return isar.deudas
        .filter()
        .estadoEqualTo(EstadoDeuda.vencida)
        .sortByFechaPrestamoDesc()
        .findAll();
  }

  Future<Deuda?> obtenerPorId(Id id) {
    return isar.deudas.get(id);
  }

  Future<Deuda?> obtenerPorUuid(String uuid) {
    return isar.deudas.filter().uuidEqualTo(uuid).findFirst();
  }

  Future<List<Deuda>> obtenerPorCliente(Id clienteId) {
    return isar.deudas
        .filter()
        .cliente((q) => q.idEqualTo(clienteId))
        .sortByFechaPrestamoDesc()
        .findAll();
  }

  Future<List<Deuda>> buscar(String texto) async {
    final value = texto.trim();

    if (value.isEmpty) {
      return obtenerTodas();
    }

    return isar.deudas
        .filter()
        .cliente((q) => q.nombreContains(value, caseSensitive: false))
        .sortByFechaPrestamoDesc()
        .findAll();
  }

  Future<List<Deuda>> filtrar({
    Id? clienteId,
    EstadoDeuda? estado,
    bool? archivada,
    DateTime? desde,
    DateTime? hasta,
  }) {
    return isar.deudas
        .filter()
        .optional(
          clienteId != null,
          (q) => q.cliente((q) => q.idEqualTo(clienteId!)),
        )
        .optional(estado != null, (q) => q.estadoEqualTo(estado!))
        .optional(archivada != null, (q) => q.archivadaEqualTo(archivada!))
        .optional(
          desde != null,
          (q) => q.fechaPrestamoGreaterThan(desde!, include: true),
        )
        .optional(
          hasta != null,
          (q) => q.fechaPrestamoLessThan(hasta!, include: true),
        )
        .sortByFechaPrestamoDesc()
        .findAll();
  }

  //==========================================================
  // DASHBOARD
  //==========================================================

  Future<List<Deuda>> obtenerVencenHoy() {
    final hoy = DateTime.now();

    final inicio = DateTime(hoy.year, hoy.month, hoy.day);

    final fin = inicio.add(const Duration(days: 1));

    return isar.deudas
        .filter()
        .fechaVencimientoBetween(inicio, fin, includeUpper: false)
        .and()
        .estadoEqualTo(EstadoDeuda.pendiente)
        .findAll();
  }

  Future<List<Deuda>> obtenerVencenEstaSemana() {
    final hoy = DateTime.now();

    final inicio = DateTime(hoy.year, hoy.month, hoy.day);

    final fin = inicio.add(const Duration(days: 7));

    return isar.deudas
        .filter()
        .fechaVencimientoBetween(inicio, fin)
        .and()
        .estadoEqualTo(EstadoDeuda.pendiente)
        .findAll();
  }

  Future<List<Deuda>> obtenerVencidasSinPagar() {
    final hoy = DateTime.now();

    return isar.deudas
        .filter()
        .fechaVencimientoLessThan(hoy)
        .and()
        .estadoEqualTo(EstadoDeuda.pendiente)
        .findAll();
  }

  //==========================================================
  // CONTADORES
  //==========================================================

  Future<int> contar() {
    return isar.deudas.count();
  }

  Future<int> contarPendientes() {
    return isar.deudas.filter().estadoEqualTo(EstadoDeuda.pendiente).count();
  }

  Future<int> contarPagadas() {
    return isar.deudas.filter().estadoEqualTo(EstadoDeuda.pagada).count();
  }

  Future<int> contarVencidas() {
    return isar.deudas.filter().estadoEqualTo(EstadoDeuda.vencida).count();
  }

  //==========================================================
  // TOTALES
  //==========================================================

  Future<double> totalCapital() async {
    final lista = await obtenerTodas();

    return lista.fold<double>(0, (total, deuda) => total + deuda.capital);
  }

  Future<double> totalPrestado() async {
    final lista = await obtenerTodas();

    return lista.fold<double>(0, (total, deuda) => total + deuda.total);
  }

  Future<double> totalPagado() async {
    final lista = await obtenerTodas();

    return lista.fold<double>(0, (total, deuda) => total + deuda.totalPagado);
  }

  Future<double> totalPendiente() async {
    final lista = await obtenerTodas();

    return lista.fold<double>(
      0,
      (total, deuda) => total + deuda.saldoPendiente,
    );
  }

  //==========================================================
  // ESCRITURA
  //==========================================================

  Future<void> guardar(Deuda deuda) async {
    await isar.writeTxn(() async {
      await isar.deudas.put(deuda);
      await deuda.cliente.save();
    });
  }

  Future<void> guardarTodas(List<Deuda> deudas) async {
    await isar.writeTxn(() async {
      await isar.deudas.putAll(deudas);

      for (final deuda in deudas) {
        await deuda.cliente.save();
      }
    });
  }

  Future<void> eliminar(Id id) async {
    await isar.writeTxn(() async {
      await isar.deudas.delete(id);
    });
  }

  Future<void> eliminarConRelaciones(Id deudaId) async {
    await isar.writeTxn(() async {
      final pagos = await isar.pagos
          .filter()
          .deuda((q) => q.idEqualTo(deudaId))
          .findAll();

      final intereses = await isar.interesDeudas
          .filter()
          .deuda((q) => q.idEqualTo(deudaId))
          .findAll();

      final cuotas = await isar.cuotaDeudas
          .filter()
          .deuda((q) => q.idEqualTo(deudaId))
          .findAll();

      await isar.pagos.deleteAll(pagos.map((pago) => pago.id).toList());

      await isar.interesDeudas.deleteAll(
        intereses.map((interes) => interes.id).toList(),
      );

      await isar.cuotaDeudas.deleteAll(
        cuotas.map((cuota) => cuota.id).toList(),
      );

      await isar.deudas.delete(deudaId);
    });
  }

  Future<void> eliminarTodas(List<Id> ids) async {
    await isar.writeTxn(() async {
      await isar.deudas.deleteAll(ids);
    });
  }

  Future<void> limpiar() async {
    await isar.writeTxn(() async {
      await isar.deudas.clear();
    });
  }
}
