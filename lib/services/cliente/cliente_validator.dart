import '../../models/cliente.dart';
import '../../repositories/cliente_repository.dart';
import 'cliente_exception.dart';

class ClienteValidator {
  ClienteValidator(this._repository);

  final ClienteRepository _repository;

  ///==========================================================
  /// VALIDACIÓN GENERAL
  ///==========================================================

  Future<void> validar(Cliente cliente) async {
    await validarNombre(cliente.nombre);

    await validarTelefono(telefono: cliente.telefono, uuid: cliente.uuid);

    validarDireccion(cliente.direccion);

    validarObservacion(cliente.observacion);
  }

  ///==========================================================
  /// NOMBRE
  ///==========================================================

  Future<void> validarNombre(String nombre) async {
    final value = nombre.trim();

    if (value.isEmpty) {
      throw const ClienteException('El nombre del cliente es obligatorio.');
    }

    if (value.length < 3) {
      throw const ClienteException(
        'El nombre debe contener al menos 3 caracteres.',
      );
    }

    if (value.length > 100) {
      throw const ClienteException(
        'El nombre no puede superar los 100 caracteres.',
      );
    }
  }

  ///==========================================================
  /// TELÉFONO
  ///==========================================================

  Future<void> validarTelefono({String? telefono, String? uuid}) async {
    if (telefono == null || telefono.trim().isEmpty) {
      return;
    }

    final value = telefono.trim();

    if (value.length < 7) {
      throw const ClienteException('El teléfono no es válido.');
    }

    if (value.length > 20) {
      throw const ClienteException('El teléfono es demasiado largo.');
    }

    final cliente = await _repository.obtenerPorTelefono(value);

    if (cliente == null) {
      return;
    }

    if (uuid != null && cliente.uuid == uuid) {
      return;
    }

    throw const ClienteException('Ya existe un cliente con ese teléfono.');
  }

  ///==========================================================
  /// DIRECCIÓN
  ///==========================================================

  void validarDireccion(String? direccion) {
    if (direccion == null) {
      return;
    }

    if (direccion.length > 250) {
      throw const ClienteException(
        'La dirección no puede superar los 250 caracteres.',
      );
    }
  }

  ///==========================================================
  /// OBSERVACIÓN
  ///==========================================================

  void validarObservacion(String? observacion) {
    if (observacion == null) {
      return;
    }

    if (observacion.length > 500) {
      throw const ClienteException(
        'La observación no puede superar los 500 caracteres.',
      );
    }
  }

  ///==========================================================
  /// UTILIDADES
  ///==========================================================

  Future<bool> existeTelefono(String telefono) async {
    final cliente = await _repository.obtenerPorTelefono(telefono.trim());

    return cliente != null;
  }

  Future<bool> existeNombre(String nombre) async {
    final cliente = await _repository.obtenerPorNombre(nombre.trim());

    return cliente != null;
  }
}
