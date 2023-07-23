import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/main.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/room_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/views/game_view.dart';
import 'package:flutter_bull/src/views/home_view.dart';
import 'package:flutter_bull/src/views/login_view.dart';
import 'package:flutter_bull/src/views/main_view.dart';
import 'package:flutter_bull/src/views/splash_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class UtterBullContainer extends ConsumerStatefulWidget {
  const UtterBullContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UtterBullContainerState();
}

class _UtterBullContainerState extends ConsumerState<UtterBullContainer> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

/*     final initialId = FirebaseAuth.instance.currentUser?.uid;
    if (initialId != null) {
      setState(() {
        initialRoute = '/main';
      });
    } */
  }

  String initialRoute = '/login';

  @override
  Widget build(BuildContext context) {
    // TODO: Best practice for emitting states and reacting?? (events??)

    ref.listen(authNotifierProvider, (prev, next) {
      Logger().d('message: ${next.toString()}');
      Logger().d('isSignedIn: ${next.value?.isSignedIn ?? 'null'}');

      if (next.value!.isSignedIn == true) {
        _navigateToMain();
      } else if (next.value!.isSignedIn == false) {
        _navigateBackToLogin();
      }
    });

    final signInState = ref.watch(authNotifierProvider);

    return signInState.whenDefault((authState) {
      return Navigator(
        key: _navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginView());
            case '/main':
              return MaterialPageRoute(builder: (context) => MainView());
          }

          return MaterialPageRoute(builder: (context) => SplashView());
        },
      );
    });
  }

  // TODO: Fix popUntil
  // TODO: Fix the continuous pushing
  void _navigateBackToLogin() => _navigateTo('/login');

  void _navigateToMain() => _navigateTo('/main');

  void _navigateTo(String s) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      
    if (_navigatorKey.currentContext != null) {
      Navigator.of(_navigatorKey.currentContext!).pushReplacementNamed(s);
    } else {
      Logger().d('Error navigating to: $s');
    }
    });
  }
}
