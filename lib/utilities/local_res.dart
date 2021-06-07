import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';

import '../gen/assets.gen.dart';

class AppColors{

  static const Color MainColor = const Color.fromARGB(255, 255, 52, 52);
  static const Color DebugColor = const Color.fromARGB(255, 248, 0, 255);

  static const Color trueColor = const Color.fromARGB(255, 110, 211, 222);
  static const Color bullColor = const Color.fromARGB(255, 255, 28, 28);

  static const Color revealsScaffoldBackgroundColor = const Color.fromARGB(
      255, 255, 220, 220);

}

class AppStyles {

  static TextStyle MainMenuButtonTextStyle(double size, Color fontColor) => TextStyle(
      color: fontColor,
      fontFamily: FontFamily.lapsusProBold,
      fontSize: size);

  static TextStyle DebugStyle(double fontSize, {FontWeight weight = FontWeight.normal}) => TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: weight);

  static TextStyle TruthStyle({double? fontSize}) =>
      TextStyle(
          color: AppColors.trueColor,
          shadows: [Shadow(color: Colors.white, blurRadius: 18)],
          fontSize: fontSize ?? 24,
          fontFamily: FontFamily.lapsusProBold);

  static TextStyle BullStyle({double? fontSize}) =>
      TextStyle(
          color: AppColors.bullColor,
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