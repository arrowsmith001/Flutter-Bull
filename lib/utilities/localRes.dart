import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';

import '../gen/assets.gen.dart';

class AppColors{

  static const Color MainColor = const Color.fromARGB(255, 255, 52, 52);
  static const Color DebugColor = const Color.fromARGB(255, 248, 0, 255);

}

class AppStyles {

  static TextStyle MainMenuButtonTextStyle(double size) => TextStyle(
      color: Colors.white,
      fontFamily: FontFamily.lapsusProBold,
      fontSize: size);

}

class AppStrings{
  static const String PRIVACY_POLICY_ACCEPTED = 'privacyPolicyAccepted';
  static const String FIRST_TIME_PROFILE_SETUP = 'firstTimeProfileSetup';
  static const String FIRST_TIME_TUTORIAL_SETUP = 'firstTimeTutorialSetup';

  static const String TUTORIAL_MODE_ON = 'tutorialModeOn';

}