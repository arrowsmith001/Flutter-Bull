import 'package:flutter/material.dart';

class UtterBullTheme {
  
  static Color backgroundDark = Color.fromARGB(255, 196, 196, 196);

  static ThemeData theme = ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      shadowColor: backgroundDark,
      fontFamily: 'LapsusPro',
      colorScheme: ColorScheme.light(
          background: Color.fromARGB(255, 133, 206, 255),
          primary: Color.fromARGB(255, 255, 239, 96),
          secondary: Color.fromARGB(237, 196, 255, 173),
          tertiary: Color.fromARGB(235, 255, 255, 255),));

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
