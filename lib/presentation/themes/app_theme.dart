import 'package:flutter/material.dart';

class AppTheme {
  static const Color bgColor = Color(0xFF2c3e50);
  static const Color foregroundColor = Color(0xFF34495e);
  static const Color borderColor = Color(0xFF3498db);
  static const Color textColor = Color(0xFFecf0f1);
  static const Color deleteColor = Color(0xFFe74c3c);
  static const Color updateColor = Color(0xFFf1c40f);
  static const Color positiveColor = Color(0xFF2ecc71);

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: bgColor,
      primaryColor: borderColor,
      textTheme: const TextTheme(
        labelLarge: TextStyle(color: textColor),
        labelMedium: TextStyle(color: textColor),
        labelSmall: TextStyle(color: textColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: foregroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: borderColor),
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: borderColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
