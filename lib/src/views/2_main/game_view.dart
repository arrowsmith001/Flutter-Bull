import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/view_models/2_main/game_view_model.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_bull/src/views/3_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/1_writing_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/views/4_game_round/2_selecting_player_phase_view.dart';
import 'package:flutter_bull/src/views/4_game_round/3_voting_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/3_reveals_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/4_results_phase_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class GameView extends ConsumerStatefulWidget {
  const GameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends ConsumerState<GameView> with RoomID {
  final navController = GameRouteNavigationController();

  @override
  void dispose() {
    ref.invalidate(vmProvider);
    super.dispose();
  }

  late final vmProvider = gameViewNotifierProvider(roomId);

  @override
  Widget build(BuildContext context) {
    
    ref.listen(vmProvider.select((value) => value.value?.path), (_, next) {
      if (next != null) navController.navigateTo(next);
    });


    final vmAsync = ref.watch(vmProvider);
    Logger().d('vmAsync: ${vmAsync.runtimeType}');

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(utterBullServerProvider).returnToLobby(roomId);
      }),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                center: AlignmentDirectional.topCenter,
                radius: 2.5,
                colors: [Colors.white, Color.fromARGB(255, 109, 221, 255)])),
        child: Center(
          child: vmAsync.whenDefault((vm) {
            return ControlledNavigator(
                observers: [CoordinatedRouteObserver()],
                controller: navController,
                data: vm);
          }),
        ),
      ),
    );
  }
}

class GameRouteNavigationController
    extends NavigationController<GameViewModel> {
  @override
  Route get defaultRoute =>
      MaterialPageRoute(builder: (context) => SplashView());

  @override
  String generateInitialRoute(GameViewModel data) {
    return data.path;
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'lobby':
        return ForwardPushRoute((context) => scoped(LobbyPhaseView()));
      case 'writing':
        return ForwardPushRoute((context) => scoped(WritingPhaseView()));
      case 'round':
        final whoseTurnOverride =
            getPlayerWhoseTurnIdProvider.overrideWithValue(nextRoutePath);
        return ForwardPushRoute((context) =>
            scoped(GameRoundView(), overrides: [whoseTurnOverride]));
/*       case 'selecting':
        final whoseTurnOverride =
            getPlayerWhoseTurnIdProvider.overrideWithValue(nextRoutePath);
        return ForwardRoute(scoped(SelectingPlayerPhaseView(), overrides: [whoseTurnOverride]));
      case 'reading':
        final whoseTurnOverride =
            getPlayerWhoseTurnIdProvider.overrideWithValue(nextRoutePath);
        return ForwardRoute(scoped(VotingPhaseView(), overrides: [whoseTurnOverride])); */
      case 'reveals':
        return ForwardPushRoute((context) => scoped(RevealsPhaseView()));
      case 'results':
        return ForwardPushRoute((context) => scoped(ResultsPhaseView()));
    }

    return null;
  }
}
