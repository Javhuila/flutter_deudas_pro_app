import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'database_service.dart';

final isarProvider = Provider<Isar>((ref) {
  return DatabaseService.instance.isar;
});
