import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

class UtterBullGlobal {
  
  static Color backgroundDark = Color.fromARGB(255, 196, 196, 196);

  static Color truthColor = Color.fromARGB(255, 86, 111, 255);
  static Color lieColor = Color.fromARGB(255, 255, 49, 49);

  static ThemeData theme = ThemeData(
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.transparent),
      scaffoldBackgroundColor: Colors.transparent,
      buttonTheme: ButtonThemeData(
    height: 140.0,
    minWidth: double.infinity,
    textTheme: ButtonTextTheme.primary,
  ),
      shadowColor: backgroundDark,
      fontFamily: 'LapsusPro',
      colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 133, 206, 255),
        // primary: Color.fromARGB(255, 255, 239, 96),
        secondary: Color.fromARGB(237, 196, 255, 173),
        tertiary: Color.fromARGB(235, 255, 255, 255),
      ));


  static Decoration gameViewDecoration = BoxDecoration(
      gradient: RadialGradient(
          center: AlignmentDirectional.center,
          radius: 2.5,
          colors: [
            Colors.white, 
            Color.lerp(theme.primaryColor, Colors.white, 0.3)!]));

  static Color bronzeColor = const Color.fromARGB(255, 209, 101, 0);
  static Color silverColor = const Color.fromARGB(255, 211, 211, 211);
  static Color goldColor = const Color.fromARGB(255, 255, 199, 14);

  static Color greatVibe = Color.fromARGB(255, 23, 139, 0);
  static Color goodVibe = Color.fromARGB(255, 116, 179, 0);
  static Color okayVibe = Color.fromARGB(255, 192, 157, 0);
  static Color badVibe = Color.fromARGB(255, 121, 0, 0);


  static const Duration playerSelectionAnimationDuration = Duration(milliseconds: 2500);
  static const Duration selectingPlayerScreenDuration = Duration(milliseconds: 500);
  static const Duration revealsPreambleTimeMilliseconds =  Duration(milliseconds: 500);

  static const Duration votingPhaseTransitionToDuration =  Duration(milliseconds: 1000);

  static const Duration votingEndAnimationDuration =  Duration(milliseconds: 2000);
  static const Duration votingEndAnimationReverseDuration =  Duration(milliseconds: 800);

  static const String defaultAvatarPath = "pp/default/avatar.jpg";


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
