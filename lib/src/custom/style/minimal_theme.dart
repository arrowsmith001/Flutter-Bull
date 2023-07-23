import 'package:flutter/material.dart';

class MinimalTheme {
  static Color backgroundDark = Color.fromARGB(255, 196, 196, 196);

  static ThemeData theme = ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      shadowColor: backgroundDark,
      colorScheme: ColorScheme.light(
          background: Color.fromARGB(255, 223, 223, 223),
          primary: Color.fromARGB(255, 43, 195, 255)));

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
