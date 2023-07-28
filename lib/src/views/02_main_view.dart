import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/signed_in_player_status_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/023_game_view.dart';
import 'package:flutter_bull/src/views/021_home_view.dart';
import 'package:flutter_bull/src/views/022_profile_view.dart';
import 'package:flutter_bull/src/views/splash_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class MainView extends ConsumerStatefulWidget {
  MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  String _getInitialRoute(SignedInPlayerStatusNotifierState status) {
    final player = status.player;
    return status.exists == false
        ? 'pending'
        : player!.name == null
            ? 'profile'
            : player.occupiedRoomId == null
                ? 'home'
                : 'game/${player.occupiedRoomId}';
  }

  void _onPlayerNameChanged(String? prev, String? next) {
    Logger().d('name.listen: $prev $next');
    if (next != null) {
      _navigateToHome();
    }
  }

  void _onPlayerProfileExistenceChanged(bool? prev, bool? next) {
    Logger().d('exists.listen: $prev $next');
    if (next ?? false) {
      _navigateToProfile();
    }
  }

  void _onOccupiedRoomChanged(String? prev, String? next) {
    Logger().d('occupiedRoomId.listen: $prev $next');
    if (next == null) {
      _navigateToHome();
    } else {
      _navigateToGame(next);
    }
  }

  void _onPlayerStatusChanged(PlayerStatus? prev, PlayerStatus? next) {
    Logger().d('status.listen: $prev $next');
    if (next == null) return;

    setState(() {
      busy = next.busy;
      messageWhileBusy = next.messageWhileBusy;
    });
  }

  bool busy = false;
  String messageWhileBusy = '';

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final signedInPlayer = signedInPlayerStatusNotifierProvider(userId);

    final signedInPlayerAsync = ref.watch(signedInPlayer);

    if (_navigatorKey.currentContext != null) {
      ref.listen<PlayerStatus?>(
          signedInPlayer.select((state) => state.value?.status),
          _onPlayerStatusChanged);

      ref.listen<bool?>(signedInPlayer.select((state) => state.value?.exists),
          _onPlayerProfileExistenceChanged);

      ref.listen<String?>(
          signedInPlayer.select((state) => state.value?.player?.occupiedRoomId),
          _onOccupiedRoomChanged);

      ref.listen<String?>(
          signedInPlayer.select((state) => state.value?.player?.name),
          _onPlayerNameChanged);
    }

    return Scaffold(
      body: signedInPlayerAsync.when(data: (playerStatus) {
        return Stack(
          children: [
            Navigator(
              key: _navigatorKey,
              initialRoute: _getInitialRoute(playerStatus),
              onGenerateRoute: (settings) {

                final segments = settings.name!.split('/');
                final route = segments.first;

                switch (route) {
                  case 'pending':
                    return MaterialPageRoute(
                        builder: (context) => ProviderScope(
                            overrides: [],
                            child: Text(('Provisioning profile...'))));
                  case 'profile':
                    return MaterialPageRoute(
                        builder: (context) =>
                            ProviderScope(overrides: [], child: ProfileView()));
                  case 'home':
                    return MaterialPageRoute(
                        builder: (context) =>
                            ProviderScope(overrides: [], child: HomeView()));
                  case 'game':
                    final roomId = segments.elementAt(1);
                    return MaterialPageRoute(
                        builder: (context) => ProviderScope(overrides: [
                              getCurrentGameRoomIdProvider.overrideWithValue(roomId)
                            ], child: GameView()));
                }

                return MaterialPageRoute(builder: (context) => SplashView());
              },
            ),
            busy
                ? Positioned.fill(
                    child: Container(
                    color: Colors.grey.withAlpha(175),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(messageWhileBusy),
                        CircularProgressIndicator()
                      ],
                    )),
                  ))
                : SizedBox.shrink()
          ],
        );
      }, loading: () {
        return Center(child: Text('Provisioning player profile'));
      }, error: (_, __) {
        return Text('There was an error');
      }),
    );
  }

  String? initialRoute;

  Scaffold _buildSignedOutView() =>
      Scaffold(body: Center(child: Text("Signed out")));

  void _navigateToProfile() => _navigateTo('profile');

  void _navigateToHome() => _navigateTo('home');

  void _navigateToGame(String occupiedRoomId) =>
      _navigateTo('game/$occupiedRoomId');

  bool get canNavigate => navigatorContext != null;
  BuildContext? get navigatorContext => _navigatorKey.currentContext;

  // TODO: Find a way to queue and/or prioritize navigation instructions

  void _navigateTo(String s) {
    if (canNavigate) {
      Navigator.of(navigatorContext!).pushReplacementNamed(s);
      Logger().d('Navigated to: $s ${DateTime.now().toIso8601String()}');
    } else {
      Logger().d('Error navigating to: $s ${DateTime.now().toIso8601String()}');
    }
  }
}
