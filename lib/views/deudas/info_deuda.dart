import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../models/configuracion.dart';
import '../../models/deuda.dart';
import '../../providers/configuracion_provider.dart';
import '../../providers/deuda_provider.dart';
import '../../providers/file_share_provider.dart';
import 'deuda_form_page.dart';

class InfoDeudaPage extends ConsumerStatefulWidget {
  const InfoDeudaPage({super.key, required this.deuda});

  final Deuda deuda;

  @override
  ConsumerState<InfoDeudaPage> createState() => _InfoDeudaPageState();
}

class _InfoDeudaPageState extends ConsumerState<InfoDeudaPage> {
  bool _exportandoPdf = false;
  bool _exportandoExcel = false;

  Deuda get deuda => widget.deuda;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) {
        return;
      }

      ref.read(configuracionProvider.notifier).cargar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final configuracionState = ref.watch(configuracionProvider);

    final configuracion = configuracionState.configuracion;

    final cliente = deuda.cliente.value;
    final nombreCliente = cliente?.nombre ?? 'Cliente no encontrado';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de la deuda'),
        actions: [
          IconButton(
            tooltip: 'Editar deuda',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () async {
              final resultado = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (_) => DeudaFormPage(deuda: deuda)),
              );

              if (resultado == true && context.mounted) {
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _ClienteCard(nombreCliente: nombreCliente),
            const SizedBox(height: 16),
            _InformacionDeudaCard(deuda: deuda),
            const SizedBox(height: 16),
            _ResumenFinancieroCard(deuda: deuda),
            const SizedBox(height: 16),
            _ExportacionesCard(
              configuracion: configuracion,
              exportandoPdf: _exportandoPdf,
              exportandoExcel: _exportandoExcel,
              onExportarPdf: _exportarPdf,
              onExportarExcel: _exportarExcel,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportarPdf() async {
    if (_exportandoPdf) {
      return;
    }

    final configuracion = ref.read(configuracionProvider).configuracion;

    if (configuracion == null || !configuracion.exportarPdf) {
      _mostrarMensaje(
        'La exportación a PDF está desactivada en Configuración.',
      );
      return;
    }

    setState(() {
      _exportandoPdf = true;
    });

    try {
      final exportService = ref.read(deudaExportServiceProvider);
      final shareService = ref.read(fileShareServiceProvider);

      final archivo = await exportService.exportarDeudaPdf(deuda);

      await shareService.compartirArchivo(
        archivo: archivo,
        titulo: 'Compartir deuda',
        texto: 'Información de la deuda de ${_nombreCliente()}',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL EXPORTAR DEUDA A PDF: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (mounted) {
        _mostrarMensaje('No se pudo exportar la deuda a PDF.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _exportandoPdf = false;
        });
      }
    }
  }

  Future<void> _exportarExcel() async {
    if (_exportandoExcel) {
      return;
    }

    final configuracion = ref.read(configuracionProvider).configuracion;

    if (configuracion == null || !configuracion.exportarExcel) {
      _mostrarMensaje(
        'La exportación a Excel está desactivada en Configuración.',
      );
      return;
    }

    setState(() {
      _exportandoExcel = true;
    });

    try {
      final exportService = ref.read(deudaExportServiceProvider);
      final shareService = ref.read(fileShareServiceProvider);

      final archivo = await exportService.exportarDeudaExcel(deuda);

      await shareService.compartirArchivo(
        archivo: archivo,
        titulo: 'Compartir deuda',
        texto: 'Información de la deuda de ${_nombreCliente()}',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL EXPORTAR DEUDA A EXCEL: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (mounted) {
        _mostrarMensaje('No se pudo exportar la deuda a Excel.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _exportandoExcel = false;
        });
      }
    }
  }

  String _nombreCliente() {
    final cliente = deuda.cliente.value;

    return cliente?.nombre ?? 'Cliente no encontrado';
  }

  void _mostrarMensaje(String mensaje) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }
}

// ==========================================================
// CLIENTE
// ==========================================================

class _ClienteCard extends StatelessWidget {
  const _ClienteCard({required this.nombreCliente});

  final String nombreCliente;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(radius: 26, child: const Icon(Icons.person_outline)),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cliente',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    nombreCliente,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// INFORMACIÓN DE LA DEUDA
// ==========================================================

class _InformacionDeudaCard extends StatelessWidget {
  const _InformacionDeudaCard({required this.deuda});

  final Deuda deuda;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información de la deuda',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            _InfoRow(
              icon: Icons.calendar_today_outlined,
              titulo: 'Fecha del préstamo',
              valor: AppConstants.formatearFecha(deuda.fechaPrestamo),
            ),

            _InfoRow(
              icon: Icons.percent_outlined,
              titulo: 'Porcentaje de interés',
              valor: '${deuda.porcentajeInteres.toStringAsFixed(2)} %',
            ),

            _InfoRow(
              icon: Icons.event_outlined,
              titulo: 'Fecha de vencimiento',
              valor: deuda.fechaVencimiento != null
                  ? AppConstants.formatearFecha(deuda.fechaVencimiento!)
                  : 'Sin fecha de vencimiento',
            ),

            _InfoRow(
              icon: Icons.info_outline,
              titulo: 'Estado',
              valor: AppConstants.formatearEstado(deuda.estado),
            ),

            if (deuda.observacion != null &&
                deuda.observacion!.trim().isNotEmpty) ...[
              const SizedBox(height: 12),

              const Divider(),

              const SizedBox(height: 12),

              Text(
                'Observación',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                deuda.observacion!.trim(),
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// RESUMEN FINANCIERO
// ==========================================================

class _ResumenFinancieroCard extends StatelessWidget {
  const _ResumenFinancieroCard({required this.deuda});

  final Deuda deuda;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen financiero',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _InfoRow(
              icon: Icons.tag,
              titulo: 'Número de deuda',
              valor: 'Deuda #${deuda.numeroDeuda.toString().padLeft(6, '0')}',
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _ResumenItem(
                    titulo: 'Capital',
                    valor: AppConstants.formatearMoneda(deuda.capital),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _ResumenItem(
                    titulo: 'Interés',
                    valor: AppConstants.formatearMoneda(deuda.interesCalculado),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _ResumenItem(
                    titulo: 'Total',
                    valor: AppConstants.formatearMoneda(deuda.total),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _ResumenItem(
                    titulo: 'Saldo pendiente',
                    valor: AppConstants.formatearMoneda(deuda.saldoPendiente),
                    destacado: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// EXPORTACIONES
// ==========================================================

class _ExportacionesCard extends StatelessWidget {
  const _ExportacionesCard({
    required this.configuracion,
    required this.exportandoPdf,
    required this.exportandoExcel,
    required this.onExportarPdf,
    required this.onExportarExcel,
  });

  final Configuracion? configuracion;

  final bool exportandoPdf;
  final bool exportandoExcel;

  final VoidCallback onExportarPdf;
  final VoidCallback onExportarExcel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final pdfActivo = configuracion?.exportarPdf ?? false;
    final excelActivo = configuracion?.exportarExcel ?? false;

    if (!pdfActivo && !excelActivo) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exportar deuda',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Genera un archivo con la información de esta deuda.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 16),

            if (pdfActivo)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: exportandoPdf || exportandoExcel
                      ? null
                      : onExportarPdf,
                  icon: exportandoPdf
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.picture_as_pdf_outlined),
                  label: Text(
                    exportandoPdf ? 'Generando PDF...' : 'Exportar a PDF',
                  ),
                ),
              ),

            if (pdfActivo && excelActivo) const SizedBox(height: 12),

            if (excelActivo)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: exportandoPdf || exportandoExcel
                      ? null
                      : onExportarExcel,
                  icon: exportandoExcel
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.table_chart_outlined),
                  label: Text(
                    exportandoExcel ? 'Generando Excel...' : 'Exportar a Excel',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// COMPONENTES
// ==========================================================

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.titulo,
    required this.valor,
  });

  final IconData icon;
  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.primary),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  valor,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ResumenItem extends StatelessWidget {
  const _ResumenItem({
    required this.titulo,
    required this.valor,
    this.destacado = false,
  });

  final String titulo;
  final String valor;
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          valor,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: destacado ? theme.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
