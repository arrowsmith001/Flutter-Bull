import 'package:flutter/material.dart';

class UtterBullTheme {
  
  static Color backgroundDark = Color.fromARGB(255, 196, 196, 196);

  static Color truthColor = Color.fromARGB(255, 86, 111, 255);
  static Color lieColor = Color.fromARGB(255, 255, 49, 49);

  static ThemeData theme = ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      shadowColor: backgroundDark,
      fontFamily: 'LapsusPro',
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 133, 206, 255),
        // primary: Color.fromARGB(255, 255, 239, 96),
        secondary: Color.fromARGB(237, 196, 255, 173),
        tertiary: Color.fromARGB(235, 255, 255, 255),
      ));

/*     static ColorScheme appColorScheme = ColorScheme(
      background: Color.fromARGB(255, 207, 207, 207), 
      brightness: null, 
      error: null, 
      onBackground: null, 
      onError: null, 
      onPrimary: null, 
      onSecondary: null, 
      onSurface: null,
       primary: null,
        secondary: null, 
        surface: null) */
}
