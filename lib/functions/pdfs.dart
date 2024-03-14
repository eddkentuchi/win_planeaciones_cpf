import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

//------------------Creación de columnas------------------
void addColumsTitle(PdfGrid grid, PdfFont fontTitle, PdfFont fontContent,
    List<dynamic> list, int columns, int count) {
  PdfPen borders = PdfPens.darkGray;
  final PdfGridRow row = grid.rows.add();
  for (int i = 0; i < columns; i++) {
    row.cells[i].value = list[count]['datavalue$i'];
    row.cells[i].style = PdfGridCellStyle(
        font: fontTitle,
        backgroundBrush: PdfBrushes.lightGray,
        borders: PdfBorders(
            bottom: borders, top: borders, right: borders, left: borders));
  }
}

void addcolums(PdfGrid grid, PdfFont fontTitle, PdfFont fontContent,
    List<dynamic> list, int columns, int count, bool simpleC) {
  PdfPen borders = PdfPens.darkGray;
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = list[count]['datavalue0'];

  if (!simpleC) {
    row.cells[0].style = PdfGridCellStyle(
        font: fontTitle,
        backgroundBrush: PdfBrushes.lightGray,
        borders: PdfBorders(
            bottom: borders, top: borders, right: borders, left: borders));
  } else {
    row.cells[0].style = PdfGridCellStyle(
        font: fontContent,
        borders: PdfBorders(
            bottom: borders, top: borders, right: borders, left: borders));
  }
  for (int i = 1; i < columns; i++) {
    row.cells[i].value = list[count]['datavalue$i'];
    row.cells[i].style = PdfGridCellStyle(
        font: fontContent,
        borders: PdfBorders(
            bottom: borders, top: borders, right: borders, left: borders));
  }
}

//Fin creación de columnas

//------------------Ordenamiento de datos para pdf------------------
String concatenarValores(Map<String, dynamic> formValues, String thisKey) {
  String concatenatedValues = '';
  for (var key in formValues.keys) {
    if (key.startsWith(thisKey) && formValues[key] != '') {
      concatenatedValues += '${formValues[key]}, ';
    }
  }
  if (concatenatedValues.isNotEmpty) {
    concatenatedValues = concatenatedValues.replaceRange(
        concatenatedValues.length - 2, concatenatedValues.length, '.');
  }
  return concatenatedValues;
}

String tabularValores(Map<String, dynamic> formValues, String thisKey) {
  String concatenatedValues = '';
  for (var key in formValues.keys) {
    if (key.startsWith(thisKey) && formValues[key] != '') {
      concatenatedValues += '· ${formValues[key]}.\n';
    }
  }
  if (concatenatedValues.isNotEmpty) {
    concatenatedValues = concatenatedValues.replaceRange(
        concatenatedValues.length - 2, concatenatedValues.length, '.');
  }
  return concatenatedValues;
}

//Fin de Ordenamiento de datos a pdf

//------------------Guarda y abre el pdf------------------
Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getApplicationDocumentsDirectory()).path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}
