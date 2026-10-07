import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/backups/backup_result.dart';

class RespaldoRestorePage extends StatefulWidget {
  const RespaldoRestorePage({super.key, this.onRestaurar});

  final Future<BackupResult> Function(String rutaArchivo)? onRestaurar;

  @override
  State<RespaldoRestorePage> createState() => _RespaldoRestorePageState();
}

class _RespaldoRestorePageState extends State<RespaldoRestorePage> {
  String? _rutaArchivo;

  bool _restaurando = false;

  Future<void> _seleccionarCopia() async {
    // La selección real del archivo se conectará posteriormente
    // con el mecanismo de selección de archivos que utilicemos
    // para el módulo de Respaldo.
    //
    // Por ahora, esta página solamente mantiene la ruta seleccionada.
    if (_restaurando) {
      return;
    }

    try {
      final resultado = await FilePicker.platform.pickFiles(
        dialogTitle: 'Seleccionar copia de seguridad',
        type: FileType.custom,
        allowedExtensions: ['isar'],
        allowMultiple: false,
      );

      if (resultado == null || resultado.files.isEmpty || !mounted) {
        return;
      }

      final archivo = resultado.files.single;

      final ruta = archivo.path;

      if (ruta == null || ruta.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No se pudo obtener la ruta del archivo seleccionado.',
            ),
          ),
        );

        return;
      }

      setState(() {
        _rutaArchivo = ruta;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo seleccionar la copia: $e')),
      );
    }
  }

  Future<void> _restaurar() async {
    final ruta = _rutaArchivo;

    if (ruta == null || ruta.isEmpty || _restaurando) {
      return;
    }

    final confirmar = await _mostrarConfirmacion();

    if (!confirmar || !mounted) {
      return;
    }

    setState(() {
      _restaurando = true;
    });

    try {
      final resultado = widget.onRestaurar != null
          ? await widget.onRestaurar!(ruta)
          : null;

      if (!mounted) {
        return;
      }

      if (resultado?.success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'La copia de seguridad fue restaurada correctamente.',
            ),
          ),
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No fue posible restaurar la copia de seguridad.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al restaurar la copia: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _restaurando = false;
        });
      }
    }
  }

  Future<bool> _mostrarConfirmacion() async {
    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Theme.of(context).colorScheme.error,
            size: 32,
          ),
          title: const Text('Restaurar copia'),
          content: const Text(
            'Al restaurar una copia de seguridad, la información '
            'actual de clientes, deudas y pagos será reemplazada '
            'por la información contenida en la copia seleccionada.\n\n'
            '¿Deseas continuar?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Restaurar'),
            ),
          ],
        );
      },
    );

    return resultado ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tieneArchivo =
        _rutaArchivo != null && _rutaArchivo!.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Restaurar copia')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.restore_outlined,
                      size: 52,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Restaurar copia de seguridad',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Selecciona una copia de seguridad para '
                      'recuperar tus clientes, deudas y pagos.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Copia seleccionada',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      if (!tieneArchivo)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.insert_drive_file_outlined),
                          title: const Text('Ninguna copia seleccionada'),
                          subtitle: const Text(
                            'Selecciona el archivo de respaldo que deseas '
                            'restaurar.',
                          ),
                        )
                      else
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.insert_drive_file,
                            color: theme.colorScheme.primary,
                          ),
                          title: Text(
                            _nombreArchivo(_rutaArchivo!),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            _rutaArchivo!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            onPressed: _restaurando
                                ? null
                                : () {
                                    setState(() {
                                      _rutaArchivo = null;
                                    });
                                  },
                            icon: const Icon(Icons.close),
                            tooltip: 'Quitar copia',
                          ),
                        ),

                      const SizedBox(height: 12),

                      OutlinedButton.icon(
                        onPressed: _restaurando ? null : _seleccionarCopia,
                        icon: const Icon(Icons.folder_open_outlined),
                        label: const Text('Seleccionar copia'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: theme.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'La restauración reemplazará la información '
                        'actual de clientes, deudas y pagos por los '
                        'datos contenidos en la copia.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              FilledButton.icon(
                onPressed: tieneArchivo && !_restaurando ? _restaurar : null,
                icon: _restaurando
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.restore),
                label: Text(
                  _restaurando ? 'Restaurando...' : 'Restaurar copia',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _nombreArchivo(String ruta) {
    final partes = ruta.split(RegExp(r'[/\\]'));

    if (partes.isEmpty) {
      return ruta;
    }

    return partes.last;
  }
}
