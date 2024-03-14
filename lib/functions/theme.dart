import 'package:fluent_ui/fluent_ui.dart';
import 'package:planeaciones/theme/app_theme.dart';

Color getColor(bool isTitle, BuildContext context) {
  final isDarkTheme = FluentTheme.of(context).brightness == Brightness.dark;
  Color thisColor = Colors.transparent;
  if (!isTitle) {
    if (isDarkTheme) {
      Color thisColor = AppFluentTheme.appSecondaryColor['darkest']!;
      return thisColor;
    }
    if (!isDarkTheme) {
      Color thisColor = AppFluentTheme.appSecondaryColor['lighter']!;
      return thisColor;
    }
  }
  return thisColor;
}
