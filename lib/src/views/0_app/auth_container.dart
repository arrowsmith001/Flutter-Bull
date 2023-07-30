import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_bull/src/views/1_auth/login_view.dart';
import 'package:flutter_bull/src/views/1_auth/main_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class AuthContainer extends ConsumerStatefulWidget {
  const AuthContainer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UtterBullContainerState();
}

class _UtterBullContainerState extends ConsumerState<AuthContainer> {

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        authNotifierProvider.select((stateAsync) => stateAsync.value?.userId),
        (prev, next) {
      Logger().d('userId.listen: $prev $next');

      if (next != null) {
        _navigateToMain(next);
      } else {
        _navigateBackToLogin();
      }
    });

    final authStateAsync = ref.watch(authNotifierProvider);

    final mainBody = Navigator(
      key: _navigatorKey,
      initialRoute: 'login',
      onGenerateRoute: (settings) {
        final segments = settings.name!.split('/');
        final route = segments.first;

        switch (route) {
          case 'login':
            return MaterialPageRoute(builder: (context) => LoginView());

          case 'main':
            final userId = segments.elementAt(1);
            return MaterialPageRoute(
                builder: (context) => ProviderScope(
                    overrides: [getSignedInPlayerIdProvider.overrideWithValue(userId)], child: MainView()));
        }

        return MaterialPageRoute(builder: (context) => SplashView());
      },
    );

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        mainBody,
        authStateAsync.whenDefault((data) => SizedBox.shrink(),
            loading: () => Positioned.fill(
                    child: Container(
                  child: Text('loading'),
                )))
      ],
    ));
  }

  
  bool get canNavigate => navigatorContext != null;
  BuildContext? get navigatorContext => _navigatorKey.currentContext;

  void _navigateBackToLogin() => _navigateTo('login');

  void _navigateToMain(String signedInUserId) =>
      _navigateTo('main/$signedInUserId');

  void _navigateTo(String s) {
    if (canNavigate) {
      Navigator.of(navigatorContext!)
          .pushReplacementNamed(s);

      Logger().d('Navigated to: $s ${DateTime.now().toIso8601String()}');
    } else {
      Logger().d('Error navigating to: $s ${DateTime.now().toIso8601String()}');
    }
  }
}
