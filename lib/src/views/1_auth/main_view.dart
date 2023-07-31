import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/navigation/animated_routes.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/signed_in_player_status_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/2_main/game_view.dart';
import 'package:flutter_bull/src/views/2_main/home_view.dart';
import 'package:flutter_bull/src/views/2_main/pending_view.dart';
import 'package:flutter_bull/src/views/2_main/profile_view.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

class MainView extends ConsumerStatefulWidget {
  MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  final nav = MainRouteNavigatorController();

  void _onPlayerNameChanged(String? prev, String? next) {
    Logger().d('name.listen: $prev $next');
    if (next != null) {
      nav.navigateToHome();
    }
  }

  void _onPlayerProfileExistenceChanged(bool? prev, bool? next) {
    Logger().d('exists.listen: $prev $next');
    if (next ?? false) {
      nav.navigateToProfile();
    }
  }

  void _onOccupiedRoomChanged(String? prev, String? next) {
    Logger().d('occupiedRoomId.listen: $prev $next');
    if (next == null) {
      nav.navigateToHome();
    } else {
      nav.navigateToGame(next);
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
    

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: signedInPlayerAsync.when(data: (playerStatus) {
        return Stack(
          children: [
            ControlledNavigator<SignedInPlayerStatusNotifierState>(
              data: playerStatus,
              controller: nav,
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

}



class MainRouteNavigatorController
    extends NavigationController<SignedInPlayerStatusNotifierState> {

  void navigateToProfile() => navigateTo('profile');

  void navigateToHome() => navigateTo('home');

  void navigateToGame(String occupiedRoomId) =>
      navigateTo('game/$occupiedRoomId');

  @override
  String generateInitialRoute(SignedInPlayerStatusNotifierState data) {
    final player = data.player;
    return data.exists == false
        ? 'pending'
        : player!.name == null
            ? 'profile'
            : player.occupiedRoomId == null
                ? 'home'
                : 'game/${player.occupiedRoomId}';
  }

  @override
  PageRoute? resolveRoute() {

    switch (nextRoutePath) {
      case 'pending':
        final child = scoped(PendingView());
        return ForwardRoute(child);

      case 'profile':
        final child = scoped(ProfileView());
        return UpwardRoute(child);

      case 'home':
        final child = scoped(HomeView());
        return getCurrentRouteName == 'profile'
            ? DownwardRoute(child)
            : BackwardRoute(child);

      case 'game':
        final roomId = nextRoutePath;
        final roomOverride =
            getCurrentGameRoomIdProvider.overrideWithValue(roomId);

        final child = scoped(GameView(), overrides: [roomOverride]);
        return ForwardRoute(child);
    }

    return null;
  }

  @override
  Route get defaultRoute => ForwardRoute(SplashView());
}