import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/game_view.dart';
import 'package:flutter_bull/src/views/home_view.dart';
import 'package:flutter_bull/src/views/profile_view.dart';
import 'package:flutter_bull/src/views/splash_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class MainView extends ConsumerStatefulWidget {
  MainView({super.key});

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(getSignedInPlayerIdProvider);

    //final playerAsync = ref.watch(playerNotifierProvider(userId));

    ref.listen(playerNotifierProvider(userId), (prev, next) {
      final name = next.value?.name;
      final occupiedRoomId = next.value?.occupiedRoomId;

      Logger().d('$name $occupiedRoomId');
/*       if (!next.hasValue) {
        _navigateToPlayerProfileError();
      }

      if (name == null) {
        _navigateToEditProfile();
      } */

      if (occupiedRoomId == null) {
        _navigateToHome();
      } else {
        _navigateToGame(occupiedRoomId);
      }
    });

    final mainBody = Navigator(
      key: widget.navigatorKey,
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;
        switch (settings.name) {
          case '/playerProfileNotFound':
            return MaterialPageRoute(
                builder: (context) => ProviderScope(
                    overrides: [],
                    child: Text(
                        "We couldn't find your player profile just now. Please contact our support team or try again later.")));
          case '/profile':
            return MaterialPageRoute(
                builder: (context) =>
                    ProviderScope(overrides: [], child: ProfileView()));
          case '/home':
            return MaterialPageRoute(builder: (context) => HomeView());
          case '/game':
            return MaterialPageRoute(
                builder: (context) => ProviderScope(overrides: [
                      getCurrentGameRoomProvider
                          .overrideWithValue(args!['occupiedRoomId'])
                    ], child: GameView()));
        }

        return MaterialPageRoute(builder: (context) => SplashView());
      },
    );

    return Scaffold(
      body: Stack(children: [mainBody]),
    );
  }

  Scaffold _buildSignedOutView() =>
      Scaffold(body: Center(child: Text("Signed out")));

  void _navigateToEditProfile() => _navigateTo('/profile');

  void _navigateToHome() => _navigateTo('/home');

  void _navigateToGame(String occupiedRoomId) =>
      _navigateTo('/game', args: {'occupiedRoomId': occupiedRoomId});


  void _navigateTo(String s, {Object? args}) {

    if (widget.navigatorKey.currentContext != null) {

      Navigator.of(widget.navigatorKey.currentContext!)
          .pushReplacementNamed(s, arguments: args);

      Logger().d('Navigated to: $s ${DateTime.now().toIso8601String()}');

    } else {
      Logger().d('Error navigating to: $s ${DateTime.now().toIso8601String()}');
    }
  }

  void _navigateToPlayerProfileError() => _navigateTo('/playerProfileNotFound');
}
