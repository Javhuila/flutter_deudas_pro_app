// import '../../core/enums/estado_deuda.dart';
import '../../models/deuda.dart';
import '../../repositories/deuda_repository.dart';
import 'deuda_exception.dart';

class DeudaValidator {
  DeudaValidator(this.repository);

  final DeudaRepository repository;

  //==========================================================
  // VALIDACIÓN GENERAL
  //==========================================================

  Future<void> validar(Deuda deuda) async {
    validarCliente(deuda);

    validarCapital(deuda.capital);

    validarPorcentajeInteres(deuda.porcentajeInteres);

    validarInteresCalculado(deuda.interesCalculado);

    // validarTotal(deuda.total, deuda.capital, deuda.interesCalculado);

    // validarTotalPagado(deuda.totalPagado, deuda.total);

    // validarSaldoPendiente(deuda.saldoPendiente, deuda.total);

    validarFechas(deuda.fechaPrestamo, deuda.fechaVencimiento);

    validarObservacion(deuda.observacion);

    // validarEstado(
    //   deuda.estado,
    //   deuda.total,
    //   deuda.totalPagado,
    //   deuda.saldoPendiente,
    // );
  }

  //==========================================================
  // CLIENTE
  //==========================================================

  void validarCliente(Deuda deuda) {
    if (deuda.cliente.value == null) {
      throw const DeudaException('Debe seleccionar un cliente.');
    }
  }

  //==========================================================
  // CAPITAL
  //==========================================================

  void validarCapital(double capital) {
    if (capital <= 0) {
      throw const DeudaException('El capital debe ser mayor que cero.');
    }
  }

  //==========================================================
  // INTERÉS
  //==========================================================

  void validarPorcentajeInteres(double porcentaje) {
    if (porcentaje < 0) {
      throw const DeudaException(
        'El porcentaje de interés no puede ser negativo.',
      );
    }

    if (porcentaje > 1000) {
      throw const DeudaException('El porcentaje de interés es inválido.');
    }
  }

  void validarInteresCalculado(double interes) {
    if (interes < 0) {
      throw const DeudaException('El interés calculado no puede ser negativo.');
    }
  }

  //==========================================================
  // FECHAS
  //==========================================================

  void validarFechas(DateTime fechaPrestamo, DateTime? fechaVencimiento) {
    if (fechaVencimiento == null) {
      return;
    }

    if (fechaVencimiento.isBefore(fechaPrestamo)) {
      throw const DeudaException(
        'La fecha de vencimiento no puede ser anterior a la fecha del préstamo.',
      );
    }
  }

  //==========================================================
  // OBSERVACIÓN
  //==========================================================

  void validarObservacion(String? observacion) {
    if (observacion == null) {
      return;
    }

    if (observacion.length > 500) {
      throw const DeudaException(
        'La observación no puede superar los 500 caracteres.',
      );
    }
  }
}

  //==========================================================
  // TOTAL
  //==========================================================

  // void validarTotal(double total, double capital, double interes) {
  //   final esperado = capital + interes;

  //   if (total <= 0) {
  //     throw const DeudaException(
  //       'El total de la deuda debe ser mayor que cero.',
  //     );
  //   }

  //   if ((total - esperado).abs() > 0.01) {
  //     throw const DeudaException(
  //       'El total de la deuda no coincide con el capital más el interés.',
  //     );
  //   }
  // }

  //==========================================================
  // PAGOS
  //==========================================================

  // void validarTotalPagado(double totalPagado, double total) {
  //   if (totalPagado < 0) {
  //     throw const DeudaException('El total pagado no puede ser negativo.');
  //   }

  //   if (totalPagado > total) {
  //     throw const DeudaException(
  //       'El total pagado supera el valor total de la deuda.',
  //     );
  //   }
  // }

  // void validarSaldoPendiente(double saldoPendiente, double total) {
  //   if (saldoPendiente < 0) {
  //     throw const DeudaException('El saldo pendiente no puede ser negativo.');
  //   }

  //   if (saldoPendiente > total) {
  //     throw const DeudaException(
  //       'El saldo pendiente no puede superar el total de la deuda.',
  //     );
  //   }
  // }
  //==========================================================
  // ESTADO
  //==========================================================

  // void validarEstado(
  //   EstadoDeuda estado,
  //   double total,
  //   double totalPagado,
  //   double saldoPendiente,
  // ) {
  //   switch (estado) {
  //     case EstadoDeuda.pagada:
  //       if (saldoPendiente > 0) {
  //         throw const DeudaException(
  //           'Una deuda pagada no puede tener saldo pendiente.',
  //         );
  //       }

  //       if (totalPagado < total) {
  //         throw const DeudaException(
  //           'Una deuda pagada debe tener el total cancelado.',
  //         );
  //       }
  //       break;

  //     case EstadoDeuda.pendiente:
  //     case EstadoDeuda.vencida:
  //       break;
  //   }
  // }

