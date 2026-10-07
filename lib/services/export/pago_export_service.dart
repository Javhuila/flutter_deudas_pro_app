import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/enums/tipo_pago.dart';
import '../../models/pago.dart';
import '../../repositories/pago_repository.dart';

class PagoExportService {
  PagoExportService(this._repository);

  final PagoRepository _repository;

  //==========================================================
  // EXPORTACIÓN PDF
  //==========================================================

  /// Exporta todos los pagos activos a un archivo PDF.
  Future<File> exportarTodosPdf() async {
    final pagos = await _repository.obtenerTodos();

    if (pagos.isEmpty) {
      throw Exception('No existen pagos para exportar.');
    }

    await _cargarRelaciones(pagos);

    return _generarPdf(
      pagos: pagos,
      nombreArchivo: 'pagos_${_marcaTiempo()}.pdf',
      titulo: 'Listado de pagos',
    );
  }

  /// Exporta un pago específico a un archivo PDF.
  Future<File> exportarPagoPdf(Pago pago) async {
    await _cargarRelaciones([pago]);

    return _generarPdf(
      pagos: [pago],
      // nombreArchivo: 'pago_${pago.id}_${_marcaTiempo()}.pdf',
      nombreArchivo:
          'pago_${pago.numeroPago.toString().padLeft(6, '0')}_${_marcaTiempo()}.pdf',
      titulo: 'Detalle de pago',
      pagoIndividual: true,
    );
  }

  //==========================================================
  // EXPORTACIÓN EXCEL
  //==========================================================

  /// Exporta todos los pagos activos a un archivo Excel.
  Future<File> exportarTodosExcel() async {
    final pagos = await _repository.obtenerTodos();

    if (pagos.isEmpty) {
      throw Exception('No existen pagos para exportar.');
    }

    await _cargarRelaciones(pagos);

    return _generarExcel(
      pagos: pagos,
      nombreArchivo: 'pagos_${_marcaTiempo()}.xlsx',
    );
  }

  /// Exporta un pago específico a un archivo Excel.
  Future<File> exportarPagoExcel(Pago pago) async {
    await _cargarRelaciones([pago]);

    return _generarExcel(
      pagos: [pago],
      // nombreArchivo: 'pago_${pago.id}_${_marcaTiempo()}.xlsx',
      nombreArchivo:
          'pago_${pago.numeroPago.toString().padLeft(6, '0')}_${_marcaTiempo()}.xlsx',
    );
  }

  //==========================================================
  // CARGAR RELACIONES
  //==========================================================

  /// Carga la relación:
  ///
  /// Pago -> Deuda
  /// Deuda -> Cliente
  ///
  /// Esto permite obtener correctamente el nombre del cliente
  /// y el saldo pendiente de la deuda.
  Future<void> _cargarRelaciones(List<Pago> pagos) async {
    for (final pago in pagos) {
      await pago.deuda.load();

      final deuda = pago.deuda.value;

      if (deuda != null) {
        await deuda.cliente.load();
      }
      await pago.cuotas.load();
      await pago.interes.load();
    }
  }

  //==========================================================
  // PDF
  //==========================================================

  Future<File> _generarPdf({
    required List<Pago> pagos,
    required String nombreArchivo,
    required String titulo,
    bool pagoIndividual = false,
  }) async {
    final documento = pw.Document();

    await _cargarRelaciones(pagos);

    documento.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return [
            pw.Text(
              titulo,
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),

            pw.SizedBox(height: 8),

            pw.Text(
              pagoIndividual
                  ? 'Información del pago'
                  : 'Pagos registrados en la aplicación',
              style: const pw.TextStyle(fontSize: 11),
            ),

            pw.SizedBox(height: 20),

            if (pagoIndividual)
              _construirDetallePdf(pagos.first)
            else
              _construirTablaPdf(pagos),
          ];
        },
      ),
    );

    final directorio = await _obtenerDirectorioExportaciones();

    final archivo = File(path.join(directorio.path, nombreArchivo));

    await archivo.writeAsBytes(await documento.save(), flush: true);

    return archivo;
  }

  //==========================================================
  // PDF - TABLA
  //==========================================================

  pw.Widget _construirTablaPdf(List<Pago> pagos) {
    return pw.TableHelper.fromTextArray(
      headers: const [
        'N.º pago',
        'Cliente',
        'Fecha pago',
        'Tipo',
        'Concepto',
        'Valor pago',
        'Saldo pendiente',
        'Método de pago',
        'Observación',
      ],
      data: pagos.map((pago) {
        return [
          'Pago #${pago.numeroPago.toString().padLeft(6, '0')}',
          _nombreCliente(pago),
          AppConstants.formatearFecha(pago.fechaPago),
          AppConstants.formatearTipoPago(pago.tipoPago),
          _obtenerConceptoPago(pago),
          AppConstants.formatearMoneda(pago.valor),
          AppConstants.formatearMoneda(_saldoPendiente(pago)),
          AppConstants.formatearMetodoPago(pago.metodoPago),
          pago.observacion ?? '',
        ];
      }).toList(),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
      cellStyle: const pw.TextStyle(fontSize: 7),
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      border: pw.TableBorder.all(color: PdfColors.grey500, width: 0.5),
      cellPadding: const pw.EdgeInsets.all(4),
    );
  }

  //==========================================================
  // PDF - DETALLE
  //==========================================================

  pw.Widget _construirDetallePdf(Pago pago) {
    final deuda = pago.deuda.value;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _filaDetallePdf(
          'Número de pago',
          'Pago #${pago.numeroPago.toString().padLeft(6, '0')}',
        ),
        _filaDetallePdf('Cliente', _nombreCliente(pago)),
        _filaDetallePdf(
          'Fecha del pago',
          AppConstants.formatearFecha(pago.fechaPago),
        ),
        _filaDetallePdf(
          'Tipo de pago',
          AppConstants.formatearTipoPago(pago.tipoPago),
        ),
        _filaDetallePdf('Concepto del pago', _obtenerConceptoPago(pago)),
        _filaDetallePdf(
          'Valor del pago',
          AppConstants.formatearMoneda(pago.valor),
        ),
        _filaDetallePdf(
          'Saldo pendiente',
          AppConstants.formatearMoneda(_saldoPendiente(pago)),
        ),

        _filaDetallePdf(
          'Método de pago',
          AppConstants.formatearMetodoPago(pago.metodoPago),
        ),
        if (pago.tipoPago == TipoPago.capital && pago.cuotas.isNotEmpty)
          _filaDetallePdf('Cuotas aplicadas', _obtenerCuotasPago(pago)),

        if (pago.tipoPago == TipoPago.interes)
          _filaDetallePdf('Período de interés', _obtenerInteresPago(pago)),
        _filaDetallePdf('Observación', pago.observacion ?? 'Sin observaciones'),

        if (pago.referencia != null && pago.referencia!.trim().isNotEmpty)
          _filaDetallePdf('Referencia', pago.referencia!),
        // if (deuda != null) _filaDetallePdf('ID de deuda', deuda.id.toString()),
        if (deuda != null)
          _filaDetallePdf(
            'Número de deuda',
            'Deuda #${deuda.numeroDeuda.toString().padLeft(6, '0')}',
          ),
      ],
    );
  }

  pw.Widget _filaDetallePdf(String titulo, String valor) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
        ),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 150,
            child: pw.Text(
              titulo,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(child: pw.Text(valor)),
        ],
      ),
    );
  }

  //==========================================================
  // EXCEL
  //==========================================================

  Future<File> _generarExcel({
    required List<Pago> pagos,
    required String nombreArchivo,
  }) async {
    await _cargarRelaciones(pagos);

    final excel = Excel.createExcel();

    final sheet = excel['Pagos'];

    // Encabezados.
    sheet.appendRow([
      TextCellValue('N.º pago'),
      TextCellValue('N.º deuda'),
      TextCellValue('Cliente'),
      TextCellValue('Fecha pago'),
      TextCellValue('Tipo de pago'),
      TextCellValue('Concepto'),
      TextCellValue('Valor del pago'),
      TextCellValue('Saldo pendiente'),
      TextCellValue('Método de pago'),
      TextCellValue('Cuotas'),
      TextCellValue('Período de interés'),
      TextCellValue('Referencia'),
      TextCellValue('Observación'),
    ]);

    // Datos.
    for (final pago in pagos) {
      sheet.appendRow([
        TextCellValue('Pago #${pago.numeroPago.toString().padLeft(6, '0')}'),
        TextCellValue(
          pago.deuda.value == null
              ? 'Sin deuda asociada'
              : 'Deuda #${pago.deuda.value!.numeroDeuda.toString().padLeft(6, '0')}',
        ),
        TextCellValue(_nombreCliente(pago)),
        TextCellValue(AppConstants.formatearFecha(pago.fechaPago)),
        TextCellValue(AppConstants.formatearTipoPago(pago.tipoPago)),
        TextCellValue(_obtenerConceptoPago(pago)),
        DoubleCellValue(pago.valor),
        DoubleCellValue(_saldoPendiente(pago)),
        TextCellValue(AppConstants.formatearMetodoPago(pago.metodoPago)),
        TextCellValue(
          pago.tipoPago == TipoPago.capital ? _obtenerCuotasPago(pago) : '',
        ),
        TextCellValue(
          pago.tipoPago == TipoPago.interes ? _obtenerInteresPago(pago) : '',
        ),
        TextCellValue(pago.referencia ?? ''),
        TextCellValue(pago.observacion ?? ''),
      ]);
    }

    // Ancho de columnas.
    sheet.setColumnWidth(0, 10); // N Pago
    sheet.setColumnWidth(1, 10); // N Deuda
    sheet.setColumnWidth(2, 28); // Cliente
    sheet.setColumnWidth(3, 16); // Fecha
    sheet.setColumnWidth(4, 16); // Tipo
    sheet.setColumnWidth(5, 28); // Concepto
    sheet.setColumnWidth(6, 18); // Valor
    sheet.setColumnWidth(7, 20); // Saldo
    sheet.setColumnWidth(8, 20); // Método
    sheet.setColumnWidth(9, 25); // Cuotas
    sheet.setColumnWidth(10, 28); // Interés
    sheet.setColumnWidth(11, 22); // Referencia
    sheet.setColumnWidth(12, 35); // Observación

    final bytes = excel.save();

    if (bytes == null) {
      throw Exception('No fue posible generar el archivo Excel.');
    }

    final directorio = await _obtenerDirectorioExportaciones();

    final archivo = File(path.join(directorio.path, nombreArchivo));

    await archivo.writeAsBytes(bytes, flush: true);

    return archivo;
  }

  //==========================================================
  // DIRECTORIO
  //==========================================================

  Future<Directory> _obtenerDirectorioExportaciones() async {
    final directorioBase = await getApplicationDocumentsDirectory();

    final directorio = Directory(
      path.join(directorioBase.path, 'Exportaciones'),
    );

    if (!await directorio.exists()) {
      await directorio.create(recursive: true);
    }

    return directorio;
  }

  //==========================================================
  // DATOS RELACIONADOS
  //==========================================================

  String _nombreCliente(Pago pago) {
    final deuda = pago.deuda.value;

    if (deuda == null) {
      return 'Cliente no encontrado';
    }

    final cliente = deuda.cliente.value;

    return cliente?.nombre ?? 'Cliente no encontrado';
  }

  double _saldoPendiente(Pago pago) {
    final deuda = pago.deuda.value;

    if (deuda == null) {
      return 0;
    }

    return deuda.saldoPendiente;
  }

  String _obtenerConceptoPago(Pago pago) {
    switch (pago.tipoPago) {
      case TipoPago.capital:
        if (pago.cuotas.isNotEmpty) {
          return _obtenerCuotasPago(pago);
        }

        return 'Pago aplicado al capital';

      case TipoPago.interes:
        return _obtenerInteresPago(pago);
    }
  }

  String _obtenerCuotasPago(Pago pago) {
    if (pago.cuotas.isEmpty) {
      return 'Sin cuotas asociadas';
    }

    final cuotas = pago.cuotas.toList()
      ..sort((a, b) => a.numeroCuota.compareTo(b.numeroCuota));

    return cuotas.map((cuota) => 'Cuota ${cuota.numeroCuota}').join(', ');
  }

  String _obtenerInteresPago(Pago pago) {
    final interes = pago.interes.value;

    if (interes == null) {
      return 'Sin período de interés asociado';
    }

    return 'Período de interés #${interes.id}';
  }

  //==========================================================
  // MARCA DE TIEMPO
  //==========================================================

  String _marcaTiempo() {
    final ahora = DateTime.now();

    final fecha = [
      ahora.year.toString(),
      ahora.month.toString().padLeft(2, '0'),
      ahora.day.toString().padLeft(2, '0'),
    ].join('');

    final hora = [
      ahora.hour.toString().padLeft(2, '0'),
      ahora.minute.toString().padLeft(2, '0'),
      ahora.second.toString().padLeft(2, '0'),
    ].join('');

    return '${fecha}_$hora';
  }
}
