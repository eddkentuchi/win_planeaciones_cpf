import 'package:fluent_ui/fluent_ui.dart';

/*
class AppTheme {
  static const Color primary = Color.fromRGBO(48, 61, 122, 1);
  static const Color secondary = Color.fromRGBO(138, 43, 41, 1);
  static const Color tertiary = Color.fromRGBO(86, 109, 43, 1);
  static const Color lightPrimary = Color.fromRGBO(223, 221, 255, 1);
  static const Color lightSecondary = Color.fromRGBO(254, 209, 209, 1);
  static const Color lightTertiary = Color.fromRGBO(169, 220, 150, 1);
  static const Color backPrimary = Color.fromRGBO(240, 240, 255, 1);
  static const Color backSecondary = Color.fromRGBO(253, 245, 245, 1);
  static const Color backTertiary = Color.fromRGBO(242, 254, 243, 1);
  static const Color darkPrimary = Color.fromRGBO(11, 22, 70, 1);
  static const Color darkSecondary = Color.fromRGBO(36, 3, 3, 1);
  static const Color darkTertiary = Color.fromRGBO(43, 60, 11, 1);
  static const Color dark = Color.fromRGBO(0, 0, 0, 1);
  static const Color light = Color.fromRGBO(255, 255, 255, 1);
  static const Brightness brightness = Brightness.dark;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
      //primaryColor: Colors.redAccent,
      scaffoldBackgroundColor: backTertiary,
      //typography: Typography.material2021(),
      colorScheme: const ColorScheme(
          brightness: brightness,
          primary: primary,
          onPrimary: backPrimary,
          secondary: tertiary,
          onSecondary: backTertiary,
          error: secondary,
          onError: backSecondary,
          background: backTertiary,
          onBackground: darkPrimary,
          surface: lightPrimary,
          onSurface: darkPrimary),
      appBarTheme: const AppBarTheme(
        color: primary,
        elevation: 500,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: lightPrimary,
            fontSize: 30,
            fontFamily: AutofillHints.birthdayYear),
      ),
      /*textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: secondary))
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: secondary, elevation: 5),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tertiary,
          //foregroundColor: Colors.yellow,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
      ),*/
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        //hintStyle: TextStyle(fontFamily: ),
        filled: true,
        fillColor: backTertiary,

        enabledBorder: OutlineInputBorder(
          //borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          //borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
      ));
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(elevation: 0),
      scaffoldBackgroundColor: dark);
}
*/

class AppFluentTheme {
  static final AccentColor appPrimaryColor =
      AccentColor.swatch(const <String, Color>{
    'darkest': Color.fromRGBO(7, 17, 22, 1),
    'darker': Color.fromRGBO(25, 36, 53, 1),
    'dark': Color.fromRGBO(38, 49, 91, 1),
    'normal': Color.fromRGBO(50, 61, 129, 1),
    'light': Color.fromRGBO(114, 126, 180, 1),
    'lighter': Color.fromRGBO(157, 168, 203, 1),
    'lightest': Color.fromRGBO(208, 219, 240, 1),
  });
  static final AccentColor appSecondaryColor =
      AccentColor.swatch(const <String, Color>{
    'darkest': Color.fromRGBO(21, 14, 10, 1),
    'darker': Color.fromRGBO(53, 24, 22, 1),
    'dark': Color.fromRGBO(91, 36, 34, 1),
    'normal': Color.fromRGBO(129, 56, 54, 1),
    'light': Color.fromRGBO(166, 115, 117, 1),
    'lighter': Color.fromRGBO(203, 168, 170, 1),
    'lightest': Color.fromRGBO(240, 219, 221, 1),
  });
  static final AccentColor appTertiaryColor =
      AccentColor.swatch(const <String, Color>{
    'darkest': Color.fromRGBO(18, 21, 11, 1),
    'darker': Color.fromRGBO(24, 53, 17, 1),
    'dark': Color.fromRGBO(36, 91, 29, 1),
    'normal': Color.fromRGBO(65, 129, 58, 1),
    'light': Color.fromRGBO(115, 166, 108, 1),
    'lighter': Color.fromRGBO(168, 203, 161, 1),
    'lightest': Color.fromRGBO(219, 240, 212, 1),
  });
  static const Color dark = Color.fromRGBO(0, 0, 0, 1);
  static const Color light = Color.fromRGBO(255, 255, 255, 1);

  static final FluentThemeData lightTheme = FluentThemeData.light().copyWith(
      //shadowColor: dark,
      //color tabulador
      //inactiveColor: appTertiaryColor['normal'],
      accentColor: appPrimaryColor,
      //scaffoldBackgroundColor: appTertiaryColor['backTertiary'],
      // Personaliza el borde de los inputs
      navigationPaneTheme:
          NavigationPaneThemeData(backgroundColor: appPrimaryColor['lightest']),
      bottomNavigationTheme:
          BottomNavigationThemeData(backgroundColor: Colors.purple));
  static final FluentThemeData darkTheme = FluentThemeData.dark().copyWith(
    shadowColor: dark,
    //color tabulador
    //inactiveColor: appTertiaryColor['normal'],
    accentColor: appPrimaryColor,

    navigationPaneTheme:
        NavigationPaneThemeData(backgroundColor: appPrimaryColor['darkest']),
    //scaffoldBackgroundColor: appTertiaryColor['backTertiary'],
    // Personaliza el borde de los inputs
  );
}
