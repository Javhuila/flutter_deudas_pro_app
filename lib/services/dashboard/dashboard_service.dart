import '../../core/enums/estado_deuda.dart';
import '../../models/deuda.dart';
import '../../models/respaldo.dart';
import '../cliente/cliente_service.dart';
import '../deuda/deuda_service.dart';
import '../pago/pago_service.dart';
import '../respaldo/respaldo_service.dart';
import 'dashboard_backup_summary.dart';
import 'dashboard_recent_debt.dart';
import 'dashboard_statistics_data.dart';
import 'dashboard_summary.dart';

class DashboardService {
  DashboardService({
    required this._clienteService,
    required this._deudaService,
    required this._pagoService,
    required this._respaldoService,
  });

  final ClienteService _clienteService;
  final DeudaService _deudaService;
  final PagoService _pagoService;
  final RespaldoService _respaldoService;

  //==========================================================
  // RESUMEN
  //==========================================================

  Future<DashboardSummary> obtenerResumen() async {
    final clientes = await _clienteService.obtenerTodos();

    final deudas = await _deudaService.obtenerTodas();

    final pendientes = deudas.where((d) => d.estado == EstadoDeuda.pendiente);

    final pagadas = deudas.where((d) => d.estado == EstadoDeuda.pagada);

    return DashboardSummary(
      totalClientes: clientes.length,
      totalDeudas: deudas.length,
      deudasPendientes: pendientes.length,
      deudasPagadas: pagadas.length,
    );
  }

  //==========================================================
  // ESTADÍSTICAS
  //==========================================================

  Future<DashboardStatisticsData> obtenerEstadisticas() async {
    final deudas = await _deudaService.obtenerTodas();

    final pagos = await _pagoService.obtenerTodos();

    double totalPrestado = 0;

    double totalRecuperado = 0;

    double saldoPendiente = 0;

    double interesesGenerados = 0;

    for (final deuda in deudas) {
      totalPrestado += deuda.capital;
      totalRecuperado += deuda.totalPagado;
      saldoPendiente += deuda.saldoPendiente;
      interesesGenerados += deuda.interesCalculado;
    }

    final double promedioPrestamo = deudas.isEmpty
        ? 0
        : totalPrestado / deudas.length;

    return DashboardStatisticsData(
      totalPrestado: totalPrestado,
      totalRecuperado: totalRecuperado,
      saldoPendiente: saldoPendiente,
      interesesGenerados: interesesGenerados,
      totalPagos: pagos.length,
      promedioPrestamo: promedioPrestamo,
    );
  }

  //==========================================================
  // ÚLTIMAS DEUDAS
  //==========================================================

  Future<List<DashboardRecentDebt>> obtenerUltimasDeudas({
    int limite = 5,
  }) async {
    final deudas = await _deudaService.obtenerTodas();

    deudas.sort((a, b) => b.fechaRegistro.compareTo(a.fechaRegistro));

    return deudas.take(limite).map(_mapRecentDebt).toList();
  }

  //==========================================================
  // ÚLTIMO RESPALDO
  //==========================================================

  Future<DashboardBackupSummary> obtenerUltimoRespaldo() async {
    final respaldos = await _respaldoService.obtenerTodos();

    if (respaldos.isEmpty) {
      return DashboardBackupSummary.empty();
    }

    final respaldo = respaldos.first;

    return _mapBackup(respaldo);
  }

  //==========================================================
  // ACTUALIZAR DASHBOARD
  //==========================================================

  Future<void> actualizar() async {
    await Future.wait([
      obtenerResumen(),
      obtenerEstadisticas(),
      obtenerUltimasDeudas(),
      obtenerUltimoRespaldo(),
    ]);
  }

  //==========================================================
  // MAPPERS
  //==========================================================

  DashboardRecentDebt _mapRecentDebt(Deuda deuda) {
    return DashboardRecentDebt(
      id: deuda.id,
      uuid: deuda.uuid,
      nombreCliente: deuda.cliente.value?.nombre ?? '',
      capital: deuda.capital,
      total: deuda.total,
      saldoPendiente: deuda.saldoPendiente,
      fechaPrestamo: deuda.fechaPrestamo,
      fechaVencimiento: deuda.fechaVencimiento,
      estado: deuda.estado,
    );
  }

  DashboardBackupSummary _mapBackup(Respaldo respaldo) {
    return DashboardBackupSummary(
      existeRespaldo: true,
      id: respaldo.id,
      uuid: respaldo.uuid,
      tipo: respaldo.tipo,
      estado: respaldo.estado,
      fecha: respaldo.fecha,
      nombreArchivo: respaldo.nombreArchivo,
      rutaArchivo: respaldo.rutaArchivo,
      tamanoBytes: respaldo.tamanoBytes,
      versionAplicacion: respaldo.versionAplicacion,
      cantidadClientes: respaldo.cantidadClientes,
      cantidadDeudas: respaldo.cantidadDeudas,
      cantidadPagos: respaldo.cantidadPagos,
      duracionMs: respaldo.duracionMs,
      observacion: respaldo.observacion,
    );
  }
}
