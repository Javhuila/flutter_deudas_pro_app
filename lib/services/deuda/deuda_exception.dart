class DeudaException implements Exception {
  final String message;

  const DeudaException(this.message);

  @override
  String toString() => message;
}
