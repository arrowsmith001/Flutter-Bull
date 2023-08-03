import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/navigation/animated_routes.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
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

class _GameViewState extends ConsumerState<GameView> {
  final navController = GameRouteNavigationController();

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final roomId = ref.watch(getCurrentGameRoomIdProvider);

    final game = gameNotifierProvider(roomId);

    ref.listen(game.select((value) => value.value?.phaseData),
        (prev, next) {

      Logger().d('gameRoom.phaseData.listen: $prev $next');

      if(next != null) navController.navigateToPhaseWithArg(next);
    });

    final stateAsync = ref.watch(game);

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
          child: stateAsync.whenDefault((room) {
            return ControlledNavigator(
                controller: navController, data: room.phaseData);
          }),
        ),
      ),
    );
  }
}

class GameRouteNavigationController
    extends NavigationController<GamePhaseData> {
  void navigateToPhaseWithArg(GamePhaseData phase) {
    navigateTo(_phaseDataToRoute(phase));
  }

  String _phaseDataToRoute(GamePhaseData data) =>
      data.gamePhase.toString().split('.').last + (data.arg == null ? '' : '/${data.arg}');

  @override
  Route get defaultRoute =>
      MaterialPageRoute(builder: (context) => SplashView());

  @override
  String generateInitialRoute(GamePhaseData data) {
    return _phaseDataToRoute(data);
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'lobby':
        return ForwardRoute(scoped(LobbyPhaseView()));
      case 'writing':
        return ForwardRoute(scoped(WritingPhaseView()));
      case 'round':
        final whoseTurnOverride =
            getPlayerWhoseTurnIdProvider.overrideWithValue(nextRoutePath);
        return ForwardRoute(scoped(GameRoundView(), overrides: [whoseTurnOverride]));
/*       case 'selecting':
        final whoseTurnOverride =
            getPlayerWhoseTurnIdProvider.overrideWithValue(nextRoutePath);
        return ForwardRoute(scoped(SelectingPlayerPhaseView(), overrides: [whoseTurnOverride]));
      case 'reading':
        final whoseTurnOverride =
            getPlayerWhoseTurnIdProvider.overrideWithValue(nextRoutePath);
        return ForwardRoute(scoped(VotingPhaseView(), overrides: [whoseTurnOverride])); */
      case 'reveals':
        return ForwardRoute(scoped(RevealsPhaseView()));
      case 'results':
        return ForwardRoute(scoped(ResultsPhaseView()));
    }

    return null;
  }
}
