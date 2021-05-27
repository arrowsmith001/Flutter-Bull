import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';

import '../gen/assets.gen.dart';

class AppColors{

  static const Color MainColor = const Color.fromARGB(255, 255, 52, 52);
  static const Color DebugColor = const Color.fromARGB(255, 248, 0, 255);

  static const Color revealsScaffoldBackgroundColor = const Color.fromARGB(
      255, 255, 195, 195);

}

class AppStyles {

  static TextStyle MainMenuButtonTextStyle(double size, Color fontColor) => TextStyle(
      color: fontColor,
      fontFamily: FontFamily.lapsusProBold,
      fontSize: size);

  static TextStyle DebugStyle(double fontSize) => TextStyle(color: Colors.black, fontSize: fontSize);

  static TextStyle TruthStyle({double? fontSize}) =>
      TextStyle(
          color: Color.fromARGB(255, 110, 211, 222),
          shadows: [Shadow(color: Colors.white, blurRadius: 18)],
          fontSize: fontSize ?? 24,
          fontFamily: FontFamily.lapsusProBold);

  static TextStyle BullStyle({double? fontSize}) =>
      TextStyle(
          color: Color.fromARGB(255, 255, 28, 28),
          shadows: [Shadow(color: Colors.white, blurRadius: 18)],
          fontSize: fontSize ?? 24,
          fontFamily: FontFamily.lapsusProBold);

}

class AppStrings{
  static const String PRIVACY_POLICY_ACCEPTED = 'privacyPolicyAccepted';
  static const String PREFS_FIRST_TIME_PROFILE_SETUP = 'firstTimeProfileSetup';
  static const String PREFS_FIRST_TIME_TUTORIAL_SETUP = 'firstTimeTutorialSetup';

  static const String PREFS_TUTORIAL_MODE_ON = 'tutorialModeOn';

}