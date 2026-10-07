import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/cliente.dart';
import '../../models/configuracion.dart';
import '../../models/cuota_deuda.dart';
import '../../models/deuda.dart';
import '../../models/interes_deuda.dart';
import '../../models/pago.dart';
import '../../models/respaldo.dart';
import '../constants/app_constants.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();
  late Isar _isar;
  bool _inicializada = false;

  Isar get isar {
    if (!_inicializada) {
      throw StateError('La base de datos no está inicializada.');
    }

    return _isar;
  }

  Future<void> initialize() async {
    final instanciaExistente = Isar.getInstance(AppConstants.databaseName);
    if (instanciaExistente != null && instanciaExistente.isOpen) {
      _isar = instanciaExistente;
      _inicializada = true;
      return;
    }

    final directory = await getApplicationDocumentsDirectory();

    final nuevaInstancia = await Isar.open(
      [
        ClienteSchema,
        DeudaSchema,
        PagoSchema,
        InteresDeudaSchema,
        CuotaDeudaSchema,
        ConfiguracionSchema,
        RespaldoSchema,
      ],
      directory: directory.path,
      name: AppConstants.databaseName,
      inspector: true,
    );

    _isar = nuevaInstancia;
    _inicializada = true;
  }

  bool get estaInicializada {
    return _inicializada && isar.isOpen;
  }

  Future<void> close() async {
    if (!_inicializada) {
      return;
    }
    if (!isar.isOpen) {
      await isar.close();
    }
    _inicializada = false;
  }

  Future<void> reopen() async {
    await close();
    await initialize();
  }
}
