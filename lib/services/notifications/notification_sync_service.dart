import '../../repositories/deuda_repository.dart';
import '../configuracion/configuracion_service.dart';
import 'deuda_notification_service.dart';

class NotificationSyncService {
  NotificationSyncService({
    required this.deudaRepository,
    required this.configuracionService,
  });

  final DeudaRepository deudaRepository;
  final ConfiguracionService configuracionService;

  final DeudaNotificationService _deudaNotificationService =
      DeudaNotificationService.instance;

  Future<void> sincronizar() async {
    final configuracion = await configuracionService.obtener();

    final deudas = await deudaRepository.obtenerTodas();

    await _deudaNotificationService.sincronizar(
      deudas: deudas,
      configuracion: configuracion,
    );
  }

  Future<void> sincronizarDeuda(int deudaId) async {
    final configuracion = await configuracionService.obtener();

    final deuda = await deudaRepository.obtenerPorId(deudaId);

    if (deuda == null) {
      await _deudaNotificationService.cancelarParaDeuda(deudaId);
      return;
    }

    await deuda.cliente.load();

    await _deudaNotificationService.programarParaDeuda(
      deuda: deuda,
      configuracion: configuracion,
    );
  }

  Future<void> cancelarTodas() async {
    final deudas = await deudaRepository.obtenerTodas();

    await _deudaNotificationService.cancelarParaDeudas(deudas);
  }
}
