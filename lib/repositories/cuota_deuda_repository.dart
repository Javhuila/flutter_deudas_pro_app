import 'package:isar/isar.dart';

import '../core/enums/estado_cuota.dart';
import '../models/cuota_deuda.dart';
import '../models/deuda.dart';
import '../models/pago.dart';

class CuotaDeudaRepository {
  final Isar isar;

  CuotaDeudaRepository(this.isar);

  //==========================================================
  // CONSULTAS GENERALES
  //==========================================================

  Future<List<CuotaDeuda>> obtenerTodas() {
    return isar.cuotaDeudas.where().sortByNumeroCuota().findAll();
  }

  Future<CuotaDeuda?> obtenerPorId(Id id) {
    return isar.cuotaDeudas.get(id);
  }

  Future<CuotaDeuda?> obtenerPorUuid(String uuid) {
    return isar.cuotaDeudas.filter().uuidEqualTo(uuid).findFirst();
  }

  //==========================================================
  // CONSULTAS POR DEUDA
  //==========================================================

  Future<List<CuotaDeuda>> obtenerPorDeuda(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .sortByNumeroCuota()
        .findAll();
  }

  Future<List<CuotaDeuda>> obtenerPendientesPorDeuda(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .estadoEqualTo(EstadoCuota.pendiente)
        .sortByNumeroCuota()
        .findAll();
  }

  Future<List<CuotaDeuda>> obtenerParcialesPorDeuda(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .estadoEqualTo(EstadoCuota.parcial)
        .sortByNumeroCuota()
        .findAll();
  }

  Future<List<CuotaDeuda>> obtenerPagadasPorDeuda(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .estadoEqualTo(EstadoCuota.pagada)
        .sortByNumeroCuota()
        .findAll();
  }

  //==========================================================
  // CONSULTAS POR ESTADO
  //==========================================================

  Future<List<CuotaDeuda>> obtenerPendientes() {
    return isar.cuotaDeudas
        .filter()
        .estadoEqualTo(EstadoCuota.pendiente)
        .sortByNumeroCuota()
        .findAll();
  }

  Future<List<CuotaDeuda>> obtenerParciales() {
    return isar.cuotaDeudas
        .filter()
        .estadoEqualTo(EstadoCuota.parcial)
        .sortByNumeroCuota()
        .findAll();
  }

  Future<List<CuotaDeuda>> obtenerPagadas() {
    return isar.cuotaDeudas
        .filter()
        .estadoEqualTo(EstadoCuota.pagada)
        .sortByNumeroCuota()
        .findAll();
  }

  //==========================================================
  // BÚSQUEDA
  //==========================================================

  Future<List<CuotaDeuda>> buscar(String texto) {
    final value = texto.trim();

    if (value.isEmpty) {
      return obtenerTodas();
    }

    return isar.cuotaDeudas
        .filter()
        .uuidContains(value, caseSensitive: false)
        .sortByNumeroCuota()
        .findAll();
  }

  //==========================================================
  // FILTROS
  //==========================================================

  Future<List<CuotaDeuda>> filtrar({
    Id? deudaId,
    EstadoCuota? estado,
    int? numeroCuota,
  }) {
    return isar.cuotaDeudas
        .filter()
        .optional(deudaId != null, (q) => q.deuda((q) => q.idEqualTo(deudaId!)))
        .optional(estado != null, (q) => q.estadoEqualTo(estado!))
        .optional(
          numeroCuota != null,
          (q) => q.numeroCuotaEqualTo(numeroCuota!),
        )
        .sortByNumeroCuota()
        .findAll();
  }

  //==========================================================
  // CONSULTAS ESPECÍFICAS
  //==========================================================

  Future<CuotaDeuda?> obtenerPorNumero(Id deudaId, int numeroCuota) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .numeroCuotaEqualTo(numeroCuota)
        .findFirst();
  }

  Future<CuotaDeuda?> obtenerPrimeraPendiente(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .estadoEqualTo(EstadoCuota.pendiente)
        .sortByNumeroCuota()
        .findFirst();
  }

  Future<CuotaDeuda?> obtenerPrimeraNoPagada(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        // .estadoNotEqualTo(EstadoCuota.pagada)
        .estadoLessThan(EstadoCuota.pagada)
        .sortByNumeroCuota()
        .findFirst();
  }

  //==========================================================
  // RESUMEN POR DEUDA
  //==========================================================

  Future<int> contarPorDeuda(Id deudaId) {
    return isar.cuotaDeudas.filter().deuda((q) => q.idEqualTo(deudaId)).count();
  }

  Future<int> contarPendientesPorDeuda(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .estadoEqualTo(EstadoCuota.pendiente)
        .count();
  }

  Future<int> contarParcialesPorDeuda(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .estadoEqualTo(EstadoCuota.parcial)
        .count();
  }

  Future<int> contarPagadasPorDeuda(Id deudaId) {
    return isar.cuotaDeudas
        .filter()
        .deuda((q) => q.idEqualTo(deudaId))
        .estadoEqualTo(EstadoCuota.pagada)
        .count();
  }

  //==========================================================
  // PAGOS ASOCIADOS
  //==========================================================

  Future<List<Pago>> obtenerPagos(int cuotaId) async {
    final cuota = await obtenerPorId(cuotaId);

    if (cuota == null) {
      return [];
    }

    await cuota.pagos.load();
    return cuota.pagos.toList();
  }

  //==========================================================
  // SUMATORIAS
  //==========================================================

  Future<double> obtenerValorTotalPorDeuda(Id deudaId) async {
    final cuotas = await obtenerPorDeuda(deudaId);

    return cuotas.fold<double>(0, (total, cuota) => total + cuota.valor);
  }

  Future<double> obtenerValorPagadoPorDeuda(Id deudaId) async {
    final cuotas = await obtenerPorDeuda(deudaId);

    return cuotas.fold<double>(0, (total, cuota) => total + cuota.valorPagado);
  }

  Future<double> obtenerSaldoPendientePorDeuda(Id deudaId) async {
    final cuotas = await obtenerPorDeuda(deudaId);

    return cuotas.fold<double>(
      0,
      (total, cuota) => total + cuota.saldoPendiente,
    );
  }

  //==========================================================
  // PERSISTENCIA
  //==========================================================

  Future<Id> guardar(CuotaDeuda cuota) async {
    return isar.writeTxn(() async {
      final id = await isar.cuotaDeudas.put(cuota);
      await cuota.deuda.save();

      return id;
    });
  }

  Future<void> guardarTodas(List<CuotaDeuda> cuotas) async {
    if (cuotas.isEmpty) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.cuotaDeudas.putAll(cuotas);
      for (final cuota in cuotas) {
        await cuota.deuda.save();
      }
    });
  }

  //==========================================================
  // ELIMINACIÓN
  //==========================================================

  Future<bool> eliminar(Id id) async {
    return isar.writeTxn(() async {
      return await isar.cuotaDeudas.delete(id);
    });
  }

  Future<int> eliminarPorDeuda(Id deudaId) async {
    final cuotas = await obtenerPorDeuda(deudaId);

    if (cuotas.isEmpty) {
      return 0;
    }

    final ids = cuotas.map((cuota) => cuota.id).toList();

    return isar.writeTxn(() async {
      return await isar.cuotaDeudas.deleteAll(ids);
    });
  }

  Future<void> limpiar() async {
    await isar.writeTxn(() async {
      await isar.cuotaDeudas.clear();
    });
  }
}
