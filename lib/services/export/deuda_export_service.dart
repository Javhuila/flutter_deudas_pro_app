import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_deudas_pro_app/core/constants/app_constants.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/deuda.dart';
import '../../repositories/deuda_repository.dart';

class DeudaExportService {
  DeudaExportService(this._repository);

  final DeudaRepository _repository;

  //==========================================================
  // EXPORTACIÓN PDF
  //==========================================================

  /// Exporta todas las deudas a un archivo PDF.
  Future<File> exportarTodasPdf() async {
    final deudas = await _repository.obtenerTodas();

    if (deudas.isEmpty) {
      throw Exception('No existen deudas para exportar.');
    }

    return _generarPdf(
      deudas: deudas,
      nombreArchivo: 'deudas_${_marcaTiempo()}.pdf',
      titulo: 'Listado de deudas',
    );
  }

  /// Exporta una deuda específica a un archivo PDF.
  Future<File> exportarDeudaPdf(Deuda deuda) async {
    await deuda.cliente.load();

    return _generarPdf(
      deudas: [deuda],
      // nombreArchivo: 'deuda_${deuda.id}_${_marcaTiempo()}.pdf',
      nombreArchivo: 'deuda_${deuda.id}_${_marcaTiempo()}.pdf',
      titulo: 'Detalle de deuda',
      deudaIndividual: true,
    );
  }

  //==========================================================
  // EXPORTACIÓN EXCEL
  //==========================================================

  /// Exporta todas las deudas a un archivo Excel.
  Future<File> exportarTodasExcel() async {
    final deudas = await _repository.obtenerTodas();

    if (deudas.isEmpty) {
      throw Exception('No existen deudas para exportar.');
    }

    return _generarExcel(
      deudas: deudas,
      nombreArchivo: 'deudas_${_marcaTiempo()}.xlsx',
    );
  }

  /// Exporta una deuda específica a un archivo Excel.
  Future<File> exportarDeudaExcel(Deuda deuda) async {
    await deuda.cliente.load();

    return _generarExcel(
      deudas: [deuda],
      // nombreArchivo: 'deuda_${deuda.id}_${_marcaTiempo()}.xlsx',
      nombreArchivo:
          'deuda_${deuda.numeroDeuda.toString().padLeft(6, '0')}_${_marcaTiempo()}.xlsx',
    );
  }

  //==========================================================
  // PDF
  //==========================================================

  Future<File> _generarPdf({
    required List<Deuda> deudas,
    required String nombreArchivo,
    required String titulo,
    bool deudaIndividual = false,
  }) async {
    final documento = pw.Document();

    // Nos aseguramos de que cada deuda tenga cargado su cliente.
    for (final deuda in deudas) {
      await deuda.cliente.load();
    }

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
              deudaIndividual
                  ? 'Información de la deuda'
                  : 'Deudas registradas en la aplicación',
              style: const pw.TextStyle(fontSize: 11),
            ),

            pw.SizedBox(height: 20),

            if (deudaIndividual)
              _construirDetallePdf(deudas.first)
            else
              _construirTablaPdf(deudas),
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

  pw.Widget _construirTablaPdf(List<Deuda> deudas) {
    return pw.TableHelper.fromTextArray(
      headers: const [
        'N.º deuda',
        'Cliente',
        'Fecha préstamo',
        'Capital',
        'Saldo pendiente',
        '% Interés',
        'Vencimiento',
        'Observación',
        'Estado',
      ],
      data: deudas.map((deuda) {
        return [
          'Deuda #${deuda.numeroDeuda.toString().padLeft(6, '0')}',
          _nombreCliente(deuda),
          AppConstants.formatearFecha(deuda.fechaPrestamo),
          AppConstants.formatearMoneda(deuda.capital),
          AppConstants.formatearMoneda(deuda.saldoPendiente),
          '${deuda.porcentajeInteres.toStringAsFixed(2)} %',
          AppConstants.formatFecha(deuda.fechaVencimiento),
          deuda.observacion ?? '',
          AppConstants.formatearEstado(deuda.estado),
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

  pw.Widget _construirDetallePdf(Deuda deuda) {
    final cliente = deuda.cliente.value;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _filaDetallePdf(
          'Número de deuda',
          'Deuda #${deuda.numeroDeuda.toString().padLeft(6, '0')}',
        ),
        _filaDetallePdf('Cliente', cliente?.nombre ?? 'Cliente no encontrado'),
        _filaDetallePdf(
          'Fecha del préstamo',
          AppConstants.formatearFecha(deuda.fechaPrestamo),
        ),

        _filaDetallePdf('Capital', AppConstants.formatearMoneda(deuda.capital)),

        _filaDetallePdf(
          'Saldo pendiente',
          AppConstants.formatearMoneda(deuda.saldoPendiente),
        ),

        _filaDetallePdf(
          'Porcentaje de interés',
          '${deuda.porcentajeInteres.toStringAsFixed(2)} %',
        ),

        _filaDetallePdf(
          'Fecha de vencimiento',
          AppConstants.formatFecha(deuda.fechaVencimiento),
        ),

        _filaDetallePdf(
          'Observación',
          deuda.observacion ?? 'Sin observaciones',
        ),

        _filaDetallePdf('Estado', AppConstants.formatearEstado(deuda.estado)),
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
    required List<Deuda> deudas,
    required String nombreArchivo,
  }) async {
    for (final deuda in deudas) {
      await deuda.cliente.load();
    }

    final excel = Excel.createExcel();

    final sheet = excel['Deudas'];

    // Encabezados.
    sheet.appendRow([
      TextCellValue('N.º deuda'),
      TextCellValue('Cliente'),
      TextCellValue('Fecha préstamo'),
      TextCellValue('Capital'),
      TextCellValue('Saldo pendiente'),
      TextCellValue('% Interés'),
      TextCellValue('Fecha vencimiento'),
      TextCellValue('Observación'),
      TextCellValue('Estado'),
    ]);

    // Datos.
    for (final deuda in deudas) {
      sheet.appendRow([
        TextCellValue('Deuda #${deuda.numeroDeuda.toString().padLeft(6, '0')}'),
        TextCellValue(_nombreCliente(deuda)),
        TextCellValue(AppConstants.formatearFecha(deuda.fechaPrestamo)),
        DoubleCellValue(deuda.capital),
        DoubleCellValue(deuda.saldoPendiente),
        DoubleCellValue(deuda.porcentajeInteres),
        TextCellValue(AppConstants.formatFecha(deuda.fechaVencimiento)),
        TextCellValue(deuda.observacion ?? ''),
        TextCellValue(AppConstants.formatearEstado(deuda.estado)),
      ]);
    }

    // Ancho de columnas.
    sheet.setColumnWidth(0, 10);
    sheet.setColumnWidth(1, 30);
    sheet.setColumnWidth(2, 18);
    sheet.setColumnWidth(3, 16);
    sheet.setColumnWidth(4, 18);
    sheet.setColumnWidth(5, 14);
    sheet.setColumnWidth(6, 20);
    sheet.setColumnWidth(7, 35);
    sheet.setColumnWidth(8, 16);

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
  // UTILIDADES
  //==========================================================

  String _nombreCliente(Deuda deuda) {
    final cliente = deuda.cliente.value;

    return cliente?.nombre ?? 'Cliente no encontrado';
  }

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
