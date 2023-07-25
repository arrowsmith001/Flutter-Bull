import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
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
    super.initState();
  }

  void _authStateHandler(
      AsyncValue<AuthState>? prev, AsyncValue<AuthState> next) {
    final bool playerProfileExists = (next.value?.playerProfileExists ?? false);
    final bool isSignedIn = (next.value?.isSignedIn ?? false);
    final String? userId = next.value?.userId;

    final bool wasSignedIn = prev?.value?.isSignedIn ?? false;
    final bool hadProfile = prev?.value?.playerProfileExists ?? false;

    final bool isSignedInAndHasProfile = isSignedIn && playerProfileExists;
    final bool wasSignedInAndHadProfile = wasSignedIn && hadProfile;

    Logger().d('$userId $playerProfileExists');

    if (isSignedInAndHasProfile) {
      _navigateToMain(userId!);
    }
    else {
      _navigateBackToLogin();
    }

/*     if (prev != null && prev.hasValue) {
      if (prev.value!.playerProfileExists && !next.value!.playerProfileExists) {
        Logger().d('Severe error: player profile disappeared');
      }
    } */
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, _authStateHandler);

    final authNotifier = ref.watch(authNotifierProvider.notifier);
    final authStateAsync = ref.watch(authNotifierProvider);

    final mainBody = Navigator(
      key: _navigatorKey,
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginView());

          case '/main':
            return MaterialPageRoute(
                builder: (context) => ProviderScope(overrides: [
                      getSignedInPlayerIdProvider
                          .overrideWithValue(args!['userId'])
                    ], child: MainView()));
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
                  color: Colors.blue.withAlpha(150),
                  child: Text(authNotifier.loadingMessage),
                )))
      ],
    ));
  }

  // TODO: Fix popUntil
  // TODO: Fix the continuous pushing
  // TODO: Better control over navigation
  void _navigateBackToLogin() => _navigateTo('/login');

  void _navigateToMain(String signedInUserId) =>
      _navigateTo('/main', args: {'userId': signedInUserId});

  void _navigateTo(String s, {Object? args}) {
    if (_navigatorKey.currentContext != null) {


      Navigator.of(_navigatorKey.currentContext!)
          .pushReplacementNamed(s, arguments: args);

      Logger().d('Navigated to: $s ${DateTime.now().toIso8601String()}');

    } else {
      Logger().d('Error navigating to: $s ${DateTime.now().toIso8601String()}');
    }
  }
}
