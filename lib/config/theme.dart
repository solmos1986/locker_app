import 'package:flutter/material.dart';

class AppTheme {
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color.fromARGB(255, 255, 255, 255),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        labelMedium: TextStyle(
          color: Color.fromARGB(
            255,
            255,
            255,
            255,
          ), // <-- TextFormField input color
        ),
        bodyLarge: TextStyle(
          color: Color.fromARGB(
            255,
            255,
            255,
            255,
          ), // <-- TextFormField input color
        ),
      ),
      buttonTheme: ButtonThemeData(),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: ConfigColor.appBarTextColor,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: ConfigColor.iconThemeData,
        centerTitle: true,
        backgroundColor: ConfigColor.appBarBackground,
      ),
      scaffoldBackgroundColor: ConfigColor.background,
    );
  }
}

abstract class ConfigColor {
  static final background = Color.fromARGB(255, 39, 39, 39);
  static final appBarBackground = Color.fromARGB(255, 19, 19, 19);

  static final appBarTextColor = Color.fromARGB(255, 218, 216, 216);

  static final iconThemeData = IconThemeData(color: Colors.white);
}
