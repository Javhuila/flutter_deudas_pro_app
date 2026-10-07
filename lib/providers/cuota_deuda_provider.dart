import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/isar_provider.dart';
import '../repositories/cuota_deuda_repository.dart';

final cuotaDeudaRepositoryProvider = Provider<CuotaDeudaRepository>((ref) {
  return CuotaDeudaRepository(ref.watch(isarProvider));
});
