class ClienteException implements Exception {
  final String message;

  const ClienteException(this.message);

  @override
  String toString() => message;
}
