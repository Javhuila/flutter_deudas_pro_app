class NotificationConstants {
  NotificationConstants._();

  // Tipos de notificación relacionados con una deuda.
  static const int tipoDeudaAnticipada = 1;
  static const int tipoDeudaVenceHoy = 2;
  static const int tipoDeudaVencida = 3;

  // Base utilizada para evitar colisiones con otros IDs.
  static const int _baseDeudas = 100000;

  /// ID único para el recordatorio anticipado de una deuda.
  static int deudaAnticipada(int deudaId) {
    return _generarId(deudaId, tipoDeudaAnticipada);
  }

  /// ID único para el aviso del día de vencimiento.
  static int deudaVenceHoy(int deudaId) {
    return _generarId(deudaId, tipoDeudaVenceHoy);
  }

  /// ID único para el aviso de una deuda vencida.
  static int deudaVencida(int deudaId) {
    return _generarId(deudaId, tipoDeudaVencida);
  }

  static int _generarId(int deudaId, int tipo) {
    return _baseDeudas + (deudaId * 10) + tipo;
  }
}
