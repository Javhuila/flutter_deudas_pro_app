import 'package:flutter_deudas_pro_app/repositories/interes_deuda_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/isar_provider.dart';

final interesDeudaRepositoryProvider = Provider<InteresDeudaRepository>((ref) {
  return InteresDeudaRepository(ref.watch(isarProvider));
});
