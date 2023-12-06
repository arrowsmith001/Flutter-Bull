import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/views/0_app/auth_container.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/new/main/utter_bull.dart';
import 'package:flutter_bull/src/widgets/unique/utter_bull_master_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class UtterBullApp extends ConsumerWidget {
  const UtterBullApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: UtterBullGlobal.theme,
        home: PopScope(
          onPopInvoked: (b) async {
            onBackPressed(ref);
          },
          child: const UtterBullMasterBackground(child: UtterBull()),
        ));
  }

  bool onBackPressed(WidgetRef ref) {

    final auth = ref.read(authNotifierProvider).valueOrNull;
    final app = ref.read(appStateNotifierProvider).valueOrNull;

    final authNotifier = ref.read(authNotifierProvider.notifier);
    final appNotifier = ref.read(appStateNotifierProvider.notifier);

    if (auth == null) return true;
    if (app?.signUpPageState == SignUpPageState.open) {
      appNotifier.setSignUpPageState(SignUpPageState.closed);
      return false;
    }
    else if (app?.cameraViewState == CameraViewState.open) {
      appNotifier.setCameraViewState(CameraViewState.closed);
      return false;
    }
    
    switch (auth.authState) {
      case null:
        break;
      case AuthState.signedOut:
        break;
      case AuthState.signedInNoPlayerProfile:
        authNotifier.signOut();
      case AuthState.signedInNoName:
        authNotifier.signOut();
      case AuthState.signedInNoPic:
        authNotifier.signOut();
      case AuthState.signedIn:
        authNotifier.signOut();
    }

    Logger().d('APP WOULD CLOSE');
    return false;
  }
}
