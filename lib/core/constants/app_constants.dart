import 'package:intl/intl.dart';

import '../enums/estado_deuda.dart';
import '../enums/metodo_pago.dart';
import '../enums/tipo_pago.dart';
import '../enums/tipo_respaldo.dart';

class AppConstants {
  AppConstants._();

  static const databaseName = 'deudas_db';

  static const backupFolder = 'Backups';

  static const backupExtension = '.isar';

  static const appName = 'Deudas App';

  static String formatearMoneda(num valor) {
    return NumberFormat('#,##0', 'es_CO').format(valor);
  }

  static String formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    final anio = fecha.year;

    return '$dia/$mes/$anio';
  }

  static String formatFecha(DateTime? fecha) {
    if (fecha == null) {
      return '-';
    }

    return formatearFecha(fecha);
  }

  static String iniciales(String nombre) {
    final texto = nombre.trim();

    if (texto.isEmpty) {
      return '?';
    }

    final partes = texto
        .split(RegExp(r'\s+'))
        .where((parte) => parte.isNotEmpty)
        .toList();

    if (partes.length == 1) {
      return partes.first.substring(0, 1).toUpperCase();
    }

    return (partes.first.substring(0, 1) + partes.last.substring(0, 1))
        .toUpperCase();
  }

  static String formatearMetodoPago(MetodoPago metodo) {
    switch (metodo) {
      case MetodoPago.efectivo:
        return 'Efectivo';

      case MetodoPago.transferencia:
        return 'Transferencia';

      case MetodoPago.nequi:
        return 'Nequi';
      case MetodoPago.bancolombia:
        return 'Bancolombia';
      case MetodoPago.bancoCajaSocial:
        return 'Banco Caja Social';
      case MetodoPago.bbva:
        return 'BBVA';
      case MetodoPago.daviplata:
        return 'Daviplata';
      case MetodoPago.otro:
        return 'Otro';
    }
  }

  static String formatearTipoPago(TipoPago tipo) {
    switch (tipo) {
      case TipoPago.capital:
        return 'Capital';

      case TipoPago.interes:
        return 'Interés';
    }
  }

  static String formatearEstado(EstadoDeuda estado) {
    switch (estado) {
      case EstadoDeuda.pendiente:
        return 'Pendiente';

      case EstadoDeuda.vencida:
        return 'Vencida';

      case EstadoDeuda.pagada:
        return 'Pagada';
    }
  }

  static String tipoTexto(TipoRespaldo tipo) {
    switch (tipo) {
      case TipoRespaldo.manual:
        return 'Manual';

      case TipoRespaldo.automatico:
        return 'Automático';

      case TipoRespaldo.restauracion:
        return 'Restauración';
    }
  }

  static String formatBytes(int bytes) {
    if (bytes <= 0) {
      return '0 KB';
    }

    if (bytes < 1024) {
      return '$bytes B';
    }

    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }

    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  static String greeting(DateTime date) {
    final hour = date.hour;

    if (hour < 12) {
      return 'Buenos días';
    }

    if (hour < 18) {
      return 'Buenas tardes';
    }

    return 'Buenas noches';
  }
}
