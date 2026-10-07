class PagoException implements Exception {
  final String message;

  const PagoException(this.message);

  @override
  String toString() => message;
}
