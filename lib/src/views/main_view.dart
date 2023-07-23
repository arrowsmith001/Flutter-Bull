import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/views/game_view.dart';
import 'package:flutter_bull/src/views/home_view.dart';
import 'package:flutter_bull/src/views/splash_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainView extends ConsumerStatefulWidget {
  MainView({super.key});

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {


  @override
  Widget build(BuildContext context) {
    
    final authStateAsync = ref.watch(authNotifierProvider);

    return authStateAsync.whenDefault((authState) {

      if (authState.isSignedIn) {

        _listenForOccupiedRoomChanges(authState);

        return _buildNavigator();
      }

      return _buildSignedOutView();
    });
  }

  void _listenForOccupiedRoomChanges(AuthNotifierState authState) {
    return ref.listen(playerNotifierProvider(authState.userId!), (prev, next) {
        final occupiedRoomId = next.value!.occupiedRoomId;

        if (occupiedRoomId == null) {
          _navigateToHome();
        }
        if (occupiedRoomId != null) {
          _navigateToGame();
        }
      });
  }

  Scaffold _buildSignedOutView() => Scaffold(body: Center(child: CircularProgressIndicator()));

  Navigator _buildNavigator() {
    return Navigator(
        key: widget.navigatorKey,
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (context) => HomeView());
            case '/game':
              return MaterialPageRoute(builder: (context) => GameView());
          }

          return MaterialPageRoute(builder: (context) => SplashView());
        },
      );
  }

  void _navigateToHome() => _navigateTo('/home');

  void _navigateToGame() => _navigateTo('/game');

  void _navigateTo(String s) {
    if (widget.navigatorKey.currentContext != null) {
      Navigator.of(widget.navigatorKey.currentContext!).pushReplacementNamed(s);
    }
  }

}
