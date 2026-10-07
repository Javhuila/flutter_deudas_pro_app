import '../../core/enums/metodo_pago.dart';
import '../../models/pago.dart';
import '../../repositories/pago_repository.dart';
import 'pago_exception.dart';

class PagoValidator {
  PagoValidator(this._repository);

  final PagoRepository _repository;

  Future<void> validar(Pago pago) async {
    validarDeuda(pago);
    validarValor(pago);
    validarFecha(pago);
    validarMetodoPago(pago);
    validarReferencia(pago);
    validarObservacion(pago);
  }

  void validarDeuda(Pago pago) {
    if (pago.deuda.value == null) {
      throw const PagoException('Debe seleccionar una deuda.');
    }
  }

  void validarValor(Pago pago) {
    if (pago.valor <= 0) {
      throw const PagoException('El valor del pago debe ser mayor que cero.');
    }
  }

  void validarFecha(Pago pago) {
    final ahora = DateTime.now();

    if (pago.fechaPago.isAfter(ahora)) {
      throw const PagoException('La fecha del pago no puede ser futura.');
    }
  }

  void validarMetodoPago(Pago pago) {
    if (!MetodoPago.values.contains(pago.metodoPago)) {
      throw const PagoException('Debe seleccionar un método de pago válido.');
    }
  }

  void validarReferencia(Pago pago) {
    final referencia = pago.referencia?.trim();

    if (referencia != null && referencia.length > 100) {
      throw const PagoException(
        'La referencia no puede superar los 100 caracteres.',
      );
    }
  }

  void validarObservacion(Pago pago) {
    final observacion = pago.observacion?.trim();

    if (observacion != null && observacion.length > 500) {
      throw const PagoException(
        'La observación no puede superar los 500 caracteres.',
      );
    }
  }

  Future<bool> existe(String uuid) async {
    return await _repository.obtenerPorUuid(uuid) != null;
  }
}
