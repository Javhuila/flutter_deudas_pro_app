import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/notifications/notification_sync_service.dart';
import 'configuracion_provider.dart';
import 'deuda_provider.dart';

final notificationSyncServiceProvider = Provider<NotificationSyncService>((
  ref,
) {
  return NotificationSyncService(
    deudaRepository: ref.watch(deudaRepositoryProvider),
    configuracionService: ref.watch(configuracionServiceProvider),
  );
});
