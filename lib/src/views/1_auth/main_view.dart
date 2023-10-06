import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/signed_in_player_status_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/2_main/change_avatar_view.dart';
import 'package:flutter_bull/src/views/2_main/game_view.dart';
import 'package:flutter_bull/src/views/2_main/home_view.dart';
import 'package:flutter_bull/src/views/2_main/join_game_view.dart';
import 'package:flutter_bull/src/views/2_main/pending_view.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_bull/src/widgets/common/error_popup.dart';
import 'package:flutter_bull/src/widgets/common/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';

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
      body: signedInPlayerAsync.when(data: (playerStatus) {
        return ControlledNavigator<SignedInPlayerStatusNotifierState>(
          observers: [
            CoordinatedRouteObserver(), 
            HeroController()
            ],
          data: playerStatus,
          controller: nav,
        );
      }, loading: () {
        return LoadingWidget(message: 'Your player profile is being set up...');
      }, error: (e, _) {
        return ErrorPopup(e.toString(), escape: () => _onEscapeError());
      }),
    );
  }

  void _onEscapeError() {
    nav.navigateToHome();
  }
}

class MainRouteNavigatorController
    extends NavigationController<SignedInPlayerStatusNotifierState> {
  void navigateToProfile() => navigateTo('profile');

  void navigateToAvatar() => navigateTo('avatar');

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
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'pending':
        final child = scoped(PendingView());
        return ForwardPushRoute((context) => child);

      case 'profile':
        final child = scoped(ProfileSetupView());
        return UpwardPushRoute((context) => child);

      case 'avatar':
        const child = Text('Implement');
        // scoped(ChangeAvatarView());
        return UpwardPushRoute((context) => child);

      case 'home':
        final child = ProviderScope(child: HomeView());
        return getCurrentRouteName == 'profile'
            ? DownwardPushRoute((context) => child)
            : BackwardPushRoute((context) => child);

      case 'join':
        final child = ProviderScope(child: JoinGameView());
        return ForwardPushRoute((context) => child);

      case 'game':
        final roomId = nextRoutePath;
        final roomOverride =
            getCurrentGameRoomIdProvider.overrideWithValue(roomId);
        final child = ProviderScope(
          child: GameView(),
          overrides: [roomOverride],
        );
        return ForwardPushRoute((context) => child);
    }

    return null;
  }

  @override
  Route get defaultRoute => ForwardPushRoute((context) => SplashView());
}
