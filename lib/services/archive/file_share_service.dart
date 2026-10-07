import 'dart:io';

import 'package:share_plus/share_plus.dart';

class FileShareService {
  //==========================================================
  // COMPARTIR ARCHIVO
  //==========================================================

  Future<ShareResult> compartirArchivo({
    required File archivo,
    String? titulo,
    String? texto,
  }) async {
    if (!await archivo.exists()) {
      throw Exception('El archivo que se desea compartir no existe.');
    }

    final params = ShareParams(
      files: [XFile(archivo.path)],
      title: titulo,
      text: texto,
    );

    return SharePlus.instance.share(params);
  }
}
