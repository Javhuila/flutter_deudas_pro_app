import 'dart:io';

import 'package:intl/intl.dart';

class BackupUtils {
  BackupUtils._();

  static String generateFileName() {
    final formatter = DateFormat('yyyyMMdd_HHmmss');

    return 'backup_${formatter.format(DateTime.now())}.isar';
  }

  static Future<void> ensureDirectory(Directory directory) async {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }

  static Future<bool> fileExists(String filePath) async {
    final file = File(filePath);
    return file.exists();
  }

  static Future<int> getFileSize(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      return 0;
    }
    return file.length();
  }

  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      return;
    }
    await file.delete();
  }

  static bool hasValidExtension(String filePath) {
    return filePath.toLowerCase().endsWith('.isar');
  }

  static Future<bool> isValidBackupFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      return false;
    }
    if (!hasValidExtension(filePath)) {
      return false;
    }
    final size = await file.length();
    return size > 0;
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      final kb = bytes / 1024;
      return '${kb.toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      final mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(1)} MB';
    }
    final gb = bytes / (1024 * 1024 * 1024);
    return '${gb.toStringAsFixed(2)} GB';
  }
}
