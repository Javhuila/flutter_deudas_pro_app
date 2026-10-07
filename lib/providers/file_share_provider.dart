import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/archive/file_share_service.dart';

final fileShareServiceProvider = Provider<FileShareService>((ref) {
  return FileShareService();
});
