class BackupResult {
  const BackupResult({
    required this.success,
    this.message,
    this.filePath,
    this.fileName,
    this.fileSizeBytes = 0,
    this.durationMs = 0,
    this.cantidadClientes = 0,
    this.cantidadDeudas = 0,
    this.cantidadPagos = 0,
    this.restored = false,
  });

  final bool success;
  final String? message;

  final String? filePath;
  final String? fileName;
  final int fileSizeBytes;

  final int durationMs;

  final int cantidadClientes;
  final int cantidadDeudas;
  final int cantidadPagos;

  final bool restored;

  bool get failed => !success;
  bool get hasFile => filePath != null && filePath!.isNotEmpty;
}
