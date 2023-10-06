import 'package:flutter/material.dart';

class UtterBullGlobal {
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

  static const int revealsPreambleTimeMilliseconds = 100;

  static Decoration gameViewDecoration = const BoxDecoration(
      gradient: RadialGradient(
          center: AlignmentDirectional.topCenter,
          radius: 2.5,
          colors: [Colors.white, Color.fromARGB(255, 109, 221, 255)]));

  static Color bronzeColor = const Color.fromARGB(255, 209, 101, 0);
  static Color silverColor = const Color.fromARGB(255, 211, 211, 211);
  static Color goldColor = const Color.fromARGB(255, 255, 199, 14);

  static Color greatVibe = Color.fromARGB(255, 23, 139, 0);
  static Color goodVibe = Color.fromARGB(255, 116, 179, 0);
  static Color okayVibe = Color.fromARGB(255, 192, 157, 0);
  static Color badVibe = Color.fromARGB(255, 121, 0, 0);

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
