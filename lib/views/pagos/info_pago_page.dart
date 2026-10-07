import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/enums/estado_cuota.dart';
import '../../core/enums/tipo_pago.dart';
import '../../models/configuracion.dart';
import '../../models/cuota_deuda.dart';
import '../../models/deuda.dart';
import '../../models/interes_deuda.dart';
import '../../models/pago.dart';
import '../../providers/configuracion_provider.dart';
import '../../providers/deuda_provider.dart';
import '../../providers/file_share_provider.dart';
import '../../providers/pago_provider.dart';
import 'pago_form_page.dart';

class InfoPagoPage extends ConsumerStatefulWidget {
  const InfoPagoPage({super.key, required this.pago, required this.deudas});

  final Pago pago;
  final List<Deuda> deudas;

  @override
  ConsumerState<InfoPagoPage> createState() => _InfoPagoPageState();
}

class _InfoPagoPageState extends ConsumerState<InfoPagoPage> {
  bool _exportandoPdf = false;
  bool _exportandoExcel = false;
  Pago get pago => widget.pago;

  bool _cargandoRelaciones = true;

  List<CuotaDeuda> _cuotas = [];
  InteresDeuda? _interes;

  List<Pago> _pagosDeuda = [];
  bool _cargandoPagosDeuda = true;

  Deuda? get deuda {
    final deudaId = pago.deuda.value?.id;
    if (deudaId == null) {
      return null;
    }
    for (final item in widget.deudas) {
      if (item.id == deudaId) {
        return item;
      }
    }

    return null;
  }

  String get nombreCliente {
    final cliente = deuda?.cliente.value;

    return cliente?.nombre ?? 'Cliente no encontrado';
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (!mounted) {
        return;
      }
      ref.read(configuracionProvider.notifier).cargar();
      await _cargarRelaciones();
    });
  }

  Future<void> _cargarRelaciones() async {
    try {
      await pago.deuda.load();
      await pago.cuotas.load();
      await pago.interes.load();

      final deudaRelacionada = pago.deuda.value;

      if (deudaRelacionada != null) {
        await deudaRelacionada.cliente.load();
      }

      final cuotas = pago.cuotas.toList()
        ..sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

      List<Pago> pagosDeuda = [];

      if (deudaRelacionada != null) {
        pagosDeuda =
            ref.read(pagoProvider.notifier).obtenerPorDeuda(deudaRelacionada.id)
              ..sort((a, b) => b.fechaPago.compareTo(a.fechaPago));
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _cuotas = cuotas;
        _interes = pago.interes.value;
        _pagosDeuda = pagosDeuda;
        _cargandoRelaciones = false;
        _cargandoPagosDeuda = false;
      });
    } catch (e, stackTrace) {
      debugPrint('ERROR AL CARGAR RELACIONES DEL PAGO: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) {
        return;
      }

      setState(() {
        _cargandoRelaciones = false;
        _cargandoPagosDeuda = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final configuracionState = ref.watch(configuracionProvider);

    final configuracion = configuracionState.configuracion;
    final theme = Theme.of(context);
    final deudaActual = deuda;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del pago'),
        actions: [
          IconButton(
            tooltip: 'Editar pago',
            onPressed: _editarPago,
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información del pago',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _InfoItem(
                      icon: Icons.tag,
                      titulo: 'Número de pago',
                      valor:
                          'Pago #${pago.numeroPago.toString().padLeft(6, '0')}',
                    ),
                    const SizedBox(height: 16),
                    _InfoItem(
                      icon: Icons.person_outline,
                      titulo: 'Cliente',
                      valor: nombreCliente,
                    ),

                    const SizedBox(height: 16),

                    _InfoItem(
                      icon: Icons.calendar_today_outlined,
                      titulo: 'Fecha del pago',
                      valor: AppConstants.formatearFecha(pago.fechaPago),
                    ),

                    const SizedBox(height: 16),
                    _InfoItem(
                      icon: Icons.category_outlined,
                      titulo: 'Tipo de pago',
                      valor: AppConstants.formatearTipoPago(pago.tipoPago),
                    ),

                    const SizedBox(height: 16),
                    _InfoItem(
                      icon: Icons.payments_outlined,
                      titulo: 'Valor del pago',
                      valor: AppConstants.formatearMoneda(pago.valor),
                    ),

                    const SizedBox(height: 16),

                    _InfoItem(
                      icon: Icons.account_balance_wallet_outlined,
                      titulo: 'Saldo pendiente',
                      valor: AppConstants.formatearMoneda(
                        deudaActual?.saldoPendiente ?? 0,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _InfoItem(
                      icon: Icons.payment_outlined,
                      titulo: 'Método de pago',
                      valor: AppConstants.formatearMetodoPago(pago.metodoPago),
                    ),
                    if (pago.referencia != null &&
                        pago.referencia!.trim().isNotEmpty) ...[
                      const SizedBox(height: 16),

                      _InfoItem(
                        icon: Icons.receipt_long_outlined,
                        titulo: 'Referencia',
                        valor: pago.referencia!,
                      ),
                    ],

                    if (pago.observacion != null &&
                        pago.observacion!.trim().isNotEmpty) ...[
                      const SizedBox(height: 16),

                      _InfoItem(
                        icon: Icons.notes_outlined,
                        titulo: 'Observación',
                        valor: pago.observacion!,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (pago.tipoPago == TipoPago.capital &&
                deudaActual?.tieneCuotas == true) ...[
              const SizedBox(height: 16),
              _buildCuotasCard(context),
            ],
            if (pago.tipoPago == TipoPago.interes) ...[
              const SizedBox(height: 16),
              _buildInteresCard(context),
            ],
            const SizedBox(height: 16),
            _buildPagosDeudaCard(context),
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

  Widget _buildCuotasCard(BuildContext context) {
    final theme = Theme.of(context);

    if (_cargandoRelaciones) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cuotas asociadas',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      );
    }

    if (_cuotas.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cuotas asociadas',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              '${_cuotas.length} '
              '${_cuotas.length == 1 ? 'cuota asociada' : 'cuotas asociadas'}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 12),

            ..._cuotas.map(
              (cuota) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _CuotaItem(cuota: cuota),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteresCard(BuildContext context) {
    final theme = Theme.of(context);

    if (_cargandoRelaciones) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interés asociado',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      );
    }

    final interes = _interes;

    if (interes == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interés asociado',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            _InfoItem(
              icon: Icons.format_list_numbered_outlined,
              titulo: 'Período',
              valor: interes.numeroPeriodo.toString(),
            ),

            const SizedBox(height: 16),

            _InfoItem(
              icon: Icons.calendar_today_outlined,
              titulo: 'Fecha de inicio',
              valor: AppConstants.formatearFecha(interes.fechaInicio),
            ),

            const SizedBox(height: 16),

            _InfoItem(
              icon: Icons.event_outlined,
              titulo: 'Fecha de finalización',
              valor: AppConstants.formatearFecha(interes.fechaFin),
            ),

            const SizedBox(height: 16),

            _InfoItem(
              icon: Icons.percent_outlined,
              titulo: 'Porcentaje',
              valor: '${interes.porcentaje.toStringAsFixed(2)} %',
            ),

            const SizedBox(height: 16),

            _InfoItem(
              icon: Icons.attach_money_outlined,
              titulo: 'Valor del interés',
              valor: AppConstants.formatearMoneda(interes.valor),
            ),

            const SizedBox(height: 16),

            _InfoItem(
              icon: Icons.payments_outlined,
              titulo: 'Pagado',
              valor: AppConstants.formatearMoneda(interes.valorPagado),
            ),

            const SizedBox(height: 16),

            _InfoItem(
              icon: Icons.account_balance_wallet_outlined,
              titulo: 'Saldo',
              valor: AppConstants.formatearMoneda(interes.saldoPendiente),
            ),

            const SizedBox(height: 16),

            _InfoItem(
              icon: interes.pagado
                  ? Icons.check_circle_outline
                  : Icons.pending_outlined,
              titulo: 'Estado',
              valor: interes.pagado ? 'Pagado' : 'Pendiente',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagosDeudaCard(BuildContext context) {
    final theme = Theme.of(context);

    if (_cargandoPagosDeuda) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pagos de esta deuda',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      );
    }

    if (_pagosDeuda.isEmpty) {
      return const SizedBox.shrink();
    }

    final deudaActual = deuda;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.history, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Pagos de esta deuda',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              deudaActual == null
                  ? '${_pagosDeuda.length} '
                        '${_pagosDeuda.length == 1 ? 'pago' : 'pagos'}'
                  : 'Deuda #${deudaActual.numeroDeuda.toString().padLeft(6, '0')} · '
                        '${_pagosDeuda.length} '
                        '${_pagosDeuda.length == 1 ? 'pago' : 'pagos'}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 16),

            ..._pagosDeuda.map((pagoRelacionado) {
              final esPagoActual = pagoRelacionado.id == pago.id;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _PagoRelacionadoItem(
                  pago: pagoRelacionado,
                  esPagoActual: esPagoActual,
                  onTap: esPagoActual
                      ? null
                      : () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => InfoPagoPage(
                                pago: pagoRelacionado,
                                deudas: widget.deudas,
                              ),
                            ),
                          );
                        },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  //==========================================================
  // EDITAR
  //==========================================================

  Future<void> _editarPago() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PagoFormPage(pago: pago, deudas: widget.deudas),
      ),
    );

    if (!mounted) {
      return;
    }

    if (resultado == true) {
      await Future.wait([
        ref.read(pagoProvider.notifier).refrescar(),
        ref.read(deudaProvider.notifier).cargar(),
      ]);

      if (!mounted) {
        return;
      }

      Navigator.pop(context, true);
    }
  }

  //==========================================================
  // EXPORTAR PDF
  //==========================================================

  Future<void> _exportarPdf() async {
    if (_exportandoPdf) {
      return;
    }
    final configuracion = ref.read(configuracionProvider).configuracion;

    if (configuracion == null || !configuracion.exportarPdf) {
      _mostrarError('La exportación a PDF está desactivada en Configuración.');
      return;
    }
    setState(() {
      _exportandoPdf = true;
    });

    try {
      final exportService = ref.read(pagoExportServiceProvider);
      final shareService = ref.read(fileShareServiceProvider);
      final archivo = await exportService.exportarPagoPdf(pago);

      if (!mounted) {
        return;
      }

      await shareService.compartirArchivo(
        archivo: archivo,
        titulo: 'Compartir pago',
        texto: 'Información del pago de $nombreCliente',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL EXPORTAR PAGO A PDF: $e');
      debugPrintStack(stackTrace: stackTrace);
      if (!mounted) {
        return;
      }

      _mostrarError('No se pudo exportar el PDF: $e');
    } finally {
      if (mounted) {
        setState(() {
          _exportandoPdf = false;
        });
      }
    }
  }

  //==========================================================
  // EXPORTAR EXCEL
  //==========================================================

  Future<void> _exportarExcel() async {
    if (_exportandoExcel) {
      return;
    }
    final configuracion = ref.read(configuracionProvider).configuracion;

    if (configuracion == null || !configuracion.exportarExcel) {
      _mostrarError(
        'La exportación a Excel está desactivada en Configuración.',
      );
      return;
    }
    setState(() {
      _exportandoExcel = true;
    });

    try {
      final exportService = ref.read(pagoExportServiceProvider);
      final shareService = ref.read(fileShareServiceProvider);
      final archivo = await exportService.exportarPagoExcel(pago);

      if (!mounted) {
        return;
      }

      await shareService.compartirArchivo(
        archivo: archivo,
        titulo: 'Compartir pago',
        texto: 'Información del pago de $nombreCliente',
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR AL EXPORTAR DEUDA A EXCEL: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (mounted) {
        _mostrarError('No se pudo exportar la deuda a Excel.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _exportandoExcel = false;
        });
      }
    }
  }
  //==========================================================
  // UTILIDADES
  //==========================================================

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.primary),

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
    );
  }
}

class _CuotaItem extends StatelessWidget {
  const _CuotaItem({required this.cuota});

  final CuotaDeuda cuota;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 20,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  'Cuota ${cuota.numeroCuota}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              _EstadoCuotaChip(estado: cuota.estado),
            ],
          ),

          const SizedBox(height: 12),

          _CuotaDato(
            titulo: 'Valor',
            valor: AppConstants.formatearMoneda(cuota.valor),
          ),

          const SizedBox(height: 6),

          _CuotaDato(
            titulo: 'Pagado acumulado',
            valor: AppConstants.formatearMoneda(cuota.valorPagado),
          ),

          const SizedBox(height: 6),

          _CuotaDato(
            titulo: 'Saldo actual',
            valor: AppConstants.formatearMoneda(cuota.saldoPendiente),
          ),

          if (cuota.fechaPago != null) ...[
            const SizedBox(height: 6),

            _CuotaDato(
              titulo: 'Fecha de pago',
              valor: AppConstants.formatearFecha(cuota.fechaPago!),
            ),
          ],
        ],
      ),
    );
  }
}

class _CuotaDato extends StatelessWidget {
  const _CuotaDato({required this.titulo, required this.valor});

  final String titulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titulo,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            valor,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _EstadoCuotaChip extends StatelessWidget {
  const _EstadoCuotaChip({required this.estado});

  final EstadoCuota estado;

  @override
  Widget build(BuildContext context) {
    String texto;
    IconData icono;

    switch (estado) {
      case EstadoCuota.pendiente:
        texto = 'Pendiente';
        icono = Icons.pending_outlined;
        break;

      case EstadoCuota.parcial:
        texto = 'Parcial';
        icono = Icons.timelapse_outlined;
        break;

      case EstadoCuota.pagada:
        texto = 'Pagada';
        icono = Icons.check_circle_outline;
        break;
    }

    return Chip(
      avatar: Icon(icono, size: 16),
      label: Text(texto),
      visualDensity: VisualDensity.compact,
    );
  }
}
//==========================================================
// COMPARTIR
//==========================================================

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
              'Exportar pago',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Genera un archivo con la información de este pago.',
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

class _PagoRelacionadoItem extends StatelessWidget {
  const _PagoRelacionadoItem({
    required this.pago,
    required this.esPagoActual,
    this.onTap,
  });

  final Pago pago;
  final bool esPagoActual;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final numeroPago = pago.numeroPago.toString().padLeft(6, '0');

    return Material(
      color: esPagoActual
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                esPagoActual
                    ? Icons.radio_button_checked
                    : Icons.payments_outlined,
                color: esPagoActual
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pago #$numeroPago',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      AppConstants.formatearFecha(pago.fechaPago),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      AppConstants.formatearMoneda(pago.valor),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      AppConstants.formatearMetodoPago(pago.metodoPago),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              if (esPagoActual)
                Chip(
                  label: const Text('Actual'),
                  visualDensity: VisualDensity.compact,
                )
              else
                const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
