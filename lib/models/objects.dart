import 'package:flutter/material.dart';

class MenuOption {
  final String route;
  final Widget icon;
  final String name;
  final Widget screen;
  final Widget title;

  MenuOption(
      {required this.title,
      required this.route,
      required this.icon,
      required this.name,
      required this.screen});
}

class DateAndString {
  final DateTime? picked;
  final String date;

  DateAndString({required this.picked, required this.date});
}
