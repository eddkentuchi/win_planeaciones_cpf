import 'package:flutter/material.dart';
import 'package:planeaciones/models/objects.dart';

Future<DateAndString> pickDate(BuildContext context, DateTime inputday) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: inputday,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  String date = '';
  if (picked != null) {
    date = picked.toString().split(" ")[0];
  }
  return DateAndString(picked: picked, date: date);
}
