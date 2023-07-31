import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/enums/game_room_state_phase.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/room_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_bull/src/views/3_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/1_writing_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/2_selecting_player_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/3_voting_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/4_reveals_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/5_results_phase_view.dart';
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
    final roomId = ref.watch(getCurrentGameRoomIdProvider);
    final roomNotifier = roomNotifierProvider(roomId);

    ref.listen(roomNotifier.select((value) => value.value?.phase),
        (prev, next) {
      Logger().d('gameRoom.phase.listen: $prev $next');

      if (prev != null && next != null) navController.navigateToPhase(next);
    });

    final stateAsync = ref.watch(roomNotifier);

    return Scaffold(
      backgroundColor: Colors.orange,
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref.read(utterBullServerProvider).returnToLobby(roomId);
      }),
      body: Center(
        child: stateAsync.whenDefault((room) {
          return ControlledNavigator(
            controller: navController,
             data: room.phase);
        }),
      ),
    );
  }
}


class GameRouteNavigationController extends NavigationController<GameRoomStatePhase> {
  void navigateToPhase(GameRoomStatePhase phase) {
    navigateTo(_phaseToRoute(phase));
  }

  String _phaseToRoute(GameRoomStatePhase phase) =>
      phase.toString().split('.').last;

  @override
  Route get defaultRoute =>
      MaterialPageRoute(builder: (context) => SplashView());

  @override
  String generateInitialRoute(GameRoomStatePhase data) {
    return _phaseToRoute(data);
  }

  @override
  PageRoute? resolveRoute() {
    switch (nextRoutePath) {
      case 'lobby':
        return MaterialPageRoute(
            builder: (context) => scoped(LobbyPhaseView()));
      case 'writing':
        return MaterialPageRoute(
            builder: (context) => scoped(WritingPhaseView()));
      case 'selecting':
        return MaterialPageRoute(
            builder: (context) => scoped(SelectingPlayerPhaseView()));
      case 'reading':
        return MaterialPageRoute(
            builder: (context) => scoped(VotingPhaseView()));
      case 'reveals':
        return MaterialPageRoute(
            builder: (context) => scoped(RevealsPhaseView()));
      case 'results':
        return MaterialPageRoute(
            builder: (context) => scoped(ResultsPhaseView()));
    }

    return null;
  }
}
