import 'dart:io';

import 'package:path/path.dart' as path;

import '../../models/cliente.dart';
import '../../models/deuda.dart';
import '../../models/pago.dart';
import '../constants/app_constants.dart';
import '../database/database_service.dart';
import 'backup_exception.dart';
import 'backup_result.dart';
import 'backup_utils.dart';

class BackupService {
  BackupService({required this._databaseService});

  final DatabaseService _databaseService;

  //==========================================================
  // CREAR BACKUP
  //==========================================================

  Future<BackupResult> createBackup({
    String? destinationDirectory,
    int? maximoBackups,
  }) async {
    final inicio = DateTime.now();

    try {
      final isar = _databaseService.isar;

      if (!isar.isOpen) {
        throw const BackupException('La base de datos no está abierta.');
      }

      final backupDirectory = await _obtenerDirectorioBackup(
        destinationDirectory,
      );

      await BackupUtils.ensureDirectory(backupDirectory);

      final fileName = BackupUtils.generateFileName();

      final destination = path.join(backupDirectory.path, fileName);

      // -------------------------------------------------------
      // Isar genera una copia compactada y consistente.
      // -------------------------------------------------------

      await isar.copyToFile(destination);

      final file = File(destination);

      if (!await file.exists()) {
        throw const BackupException('No se pudo crear el archivo de respaldo.');
      }

      final tamano = await file.length();

      if (tamano <= 0) {
        throw const BackupException('El archivo de respaldo está vacío.');
      }

      // -------------------------------------------------------
      // APLICAR MÁXIMO DE BACKUPS
      // -------------------------------------------------------

      if (maximoBackups != null) {
        await aplicarMaximoBackups(
          directorio: backupDirectory.path,
          maximoBackups: maximoBackups,
        );
      }

      final duracion = DateTime.now().difference(inicio).inMilliseconds;

      final cantidades = await _obtenerCantidades();

      return BackupResult(
        success: true,
        filePath: destination,
        fileName: fileName,
        fileSizeBytes: tamano,
        durationMs: duracion,
        cantidadClientes: cantidades.clientes,
        cantidadDeudas: cantidades.deudas,
        cantidadPagos: cantidades.pagos,
        restored: false,
      );
    } on BackupException catch (e) {
      return BackupResult(
        success: false,
        message: e.message,
        durationMs: DateTime.now().difference(inicio).inMilliseconds,
        restored: false,
      );
    } catch (e) {
      return BackupResult(
        success: false,
        message: 'No se pudo crear el respaldo: $e',
        durationMs: DateTime.now().difference(inicio).inMilliseconds,
        restored: false,
      );
    }
  }

  //==========================================================
  // RESTAURAR BACKUP
  //==========================================================

  Future<BackupResult> restoreBackup(String backupPath) async {
    final inicio = DateTime.now();

    String? databasePath;
    String? temporaryPath;

    try {
      // -------------------------------------------------------
      // VALIDAR BACKUP
      // -------------------------------------------------------

      final valido = await BackupUtils.isValidBackupFile(backupPath);

      if (!valido) {
        throw const BackupException(
          'El archivo seleccionado no es un respaldo válido.',
        );
      }

      final backupFile = File(backupPath);
      final existeBackup = await backupFile.exists();

      if (!existeBackup) {
        throw const BackupException('El archivo de respaldo no existe.');
      }

      final tamanoBackup = await backupFile.length();

      if (tamanoBackup <= 0) {
        throw const BackupException('El archivo de respaldo está vacío.');
      }
      final isar = _databaseService.isar;

      if (!isar.isOpen) {
        throw const BackupException('La base de datos no está abierta.');
      }

      databasePath = isar.path;

      // databasePath == null ||
      if (databasePath!.trim().isEmpty) {
        throw const BackupException(
          'No se pudo determinar la ubicación de la base de datos.',
        );
      }

      // -------------------------------------------------------
      // EVITAR RESTAURAR SOBRE EL MISMO ARCHIVO
      // -------------------------------------------------------

      final backupAbsolutePath = path.normalize(path.absolute(backupPath));

      final databaseAbsolutePath = path.normalize(path.absolute(databasePath));

      if (backupAbsolutePath == databaseAbsolutePath) {
        throw const BackupException(
          'El archivo seleccionado corresponde a la base de datos actual.',
        );
      }

      // -------------------------------------------------------
      // CREAR COPIA DE SEGURIDAD DE LA BASE ACTUAL
      // -------------------------------------------------------
      //
      // Esto permite recuperar la base actual si la restauración
      // falla al volver a abrir Isar.
      // -------------------------------------------------------

      temporaryPath = path.join(
        path.dirname(databasePath),
        '.restore_previous_${DateTime.now().millisecondsSinceEpoch}.isar',
      );

      await isar.copyToFile(temporaryPath);

      // -------------------------------------------------------
      // CERRAR ISAR
      // -------------------------------------------------------

      await _databaseService.close();

      // -------------------------------------------------------
      // REEMPLAZAR BASE ACTUAL
      // -------------------------------------------------------

      final databaseFile = File(databasePath);

      if (await databaseFile.exists()) {
        await databaseFile.delete();
      }

      await backupFile.copy(databasePath);

      // -------------------------------------------------------
      // REABRIR ISAR
      // -------------------------------------------------------

      try {
        await _databaseService.reopen();
      } catch (e) {
        // -----------------------------------------------------
        // LA COPIA NO PUDO ABRIRSE.
        //
        // Intentamos recuperar la base anterior.
        // -----------------------------------------------------

        await _restaurarBaseAnterior(
          databasePath: databasePath,
          previousPath: temporaryPath,
        );

        throw BackupException(
          'No se pudo abrir el respaldo restaurado. '
          'Se recuperó la base de datos anterior. Detalle: $e',
        );
      }
      // -------------------------------------------------------
      // OBTENER CANTIDADES RESTAURADAS
      // -------------------------------------------------------

      final cantidades = await _obtenerCantidades();

      final duracion = DateTime.now().difference(inicio).inMilliseconds;

      final fileName = path.basename(backupPath);

      // -------------------------------------------------------
      // ELIMINAR COPIA TEMPORAL
      // -------------------------------------------------------

      await _eliminarTemporal(temporaryPath);

      return BackupResult(
        success: true,
        filePath: backupPath,
        fileName: fileName,
        fileSizeBytes: tamanoBackup,
        durationMs: duracion,
        cantidadClientes: cantidades.clientes,
        cantidadDeudas: cantidades.deudas,
        cantidadPagos: cantidades.pagos,
        restored: true,
      );
    } on BackupException catch (e) {
      return BackupResult(
        success: false,
        message: e.message,
        filePath: backupPath,
        fileName: path.basename(backupPath),
        durationMs: DateTime.now().difference(inicio).inMilliseconds,
        restored: false,
      );
    } catch (e) {
      // -------------------------------------------------------
      // Si la restauración falló y la instancia quedó cerrada,
      // intentamos recuperar la base anterior.
      // -------------------------------------------------------

      if (databasePath != null && temporaryPath != null) {
        try {
          if (!_databaseService.estaInicializada) {
            await _restaurarBaseAnterior(
              databasePath: databasePath,
              previousPath: temporaryPath,
            );
          }
        } catch (_) {
          // Conservamos el error original de la restauración.
        }
      }

      return BackupResult(
        success: false,
        message: 'No se pudo restaurar el respaldo: $e',
        filePath: backupPath,
        fileName: path.basename(backupPath),
        durationMs: DateTime.now().difference(inicio).inMilliseconds,
        restored: false,
      );
    }
  }

  //==========================================================
  // MANTENIMIENTO DE BACKUPS
  //==========================================================

  /// Conserva únicamente los últimos [maximoBackups]
  /// archivos físicos de respaldo.
  ///
  /// Los backups se ordenan por fecha de modificación,
  /// conservando los más recientes.
  ///
  /// No elimina archivos temporales de restauración ni
  /// archivos que no correspondan al formato de backup.
  Future<void> aplicarMaximoBackups({
    required String directorio,
    required int maximoBackups,
  }) async {
    if (maximoBackups < 1) {
      throw const BackupException(
        'El máximo de backups debe ser mayor que cero.',
      );
    }

    final directory = Directory(directorio);

    if (!await directory.exists()) {
      return;
    }

    final archivos = await _obtenerArchivosBackup(directory);

    if (archivos.length <= maximoBackups) {
      return;
    }

    archivos.sort(
      (a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()),
    );

    final archivosAEliminar = archivos.skip(maximoBackups);

    for (final archivo in archivosAEliminar) {
      try {
        if (await archivo.exists()) {
          await archivo.delete();
        }
      } catch (e) {
        throw BackupException(
          'No se pudo eliminar el backup antiguo '
          '${path.basename(archivo.path)}: $e',
        );
      }
    }
  }

  /// Obtiene únicamente los archivos físicos que representan
  /// backups de la aplicación.
  Future<List<File>> _obtenerArchivosBackup(Directory directory) async {
    final archivos = <File>[];

    await for (final entidad in directory.list(
      recursive: false,
      followLinks: false,
    )) {
      if (entidad is! File) {
        continue;
      }

      final nombre = path.basename(entidad.path);

      // Solo consideramos archivos generados por BackupUtils.
      if (!nombre.startsWith('backup_')) {
        continue;
      }

      if (!nombre.endsWith('.isar')) {
        continue;
      }

      archivos.add(entidad);
    }

    return archivos;
  }

  //==========================================================
  // DIRECTORIO
  //==========================================================

  Future<Directory> _obtenerDirectorioBackup(
    String? destinationDirectory,
  ) async {
    if (destinationDirectory != null &&
        destinationDirectory.trim().isNotEmpty) {
      return Directory(destinationDirectory.trim());
    }

    final documents = await _obtenerDirectorioDocumentos();

    return Directory(path.join(documents.path, AppConstants.backupFolder));
  }

  Future<Directory> _obtenerDirectorioDocumentos() async {
    final databasePath = _databaseService.isar.path;

    if (databasePath != null && databasePath.trim().isNotEmpty) {
      return Directory(path.dirname(databasePath));
    }

    throw const BackupException(
      'No se pudo determinar el directorio de la aplicación.',
    );
  }

  //==========================================================
  // CANTIDADES
  //==========================================================

  Future<_BackupCounts> _obtenerCantidades() async {
    final isar = _databaseService.isar;

    return _BackupCounts(
      clientes: await isar.clientes.count(),
      deudas: await isar.deudas.count(),
      pagos: await isar.pagos.count(),
    );
  }

  //==========================================================
  // RECUPERACIÓN
  //==========================================================

  Future<void> _restaurarBaseAnterior({
    required String databasePath,
    required String previousPath,
  }) async {
    final previousFile = File(previousPath);

    if (!await previousFile.exists()) {
      throw const BackupException(
        'No fue posible encontrar la copia temporal de recuperación.',
      );
    }

    final databaseFile = File(databasePath);

    // Si Isar estuviera abierto, lo cerramos antes
    // de reemplazar físicamente el archivo.
    if (_databaseService.estaInicializada) {
      await _databaseService.close();
    }

    if (await databaseFile.exists()) {
      await databaseFile.delete();
    }

    await previousFile.copy(databasePath);

    await _databaseService.initialize();

    await _eliminarTemporal(previousPath);
  }

  Future<void> _eliminarTemporal(String? filePath) async {
    if (filePath == null || filePath.trim().isEmpty) {
      return;
    }

    final file = File(filePath);

    if (await file.exists()) {
      await file.delete();
    }
  }
}

//============================================================
// CANTIDADES
//============================================================

class _BackupCounts {
  const _BackupCounts({
    required this.clientes,
    required this.deudas,
    required this.pagos,
  });

  final int clientes;
  final int deudas;
  final int pagos;
}
