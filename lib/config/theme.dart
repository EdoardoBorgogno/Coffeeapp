import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get coffeAppTheme {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 239, 204, 166),
      scaffoldBackgroundColor: const Color.fromARGB(255, 239, 204, 166),
      fontFamily: 'Montserrat',
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        buttonColor: const Color.fromARGB(255, 239, 204, 166),
      ),
    );
  }
}
