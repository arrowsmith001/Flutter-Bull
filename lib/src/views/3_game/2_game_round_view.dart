import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/navigation/animated_routes.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/4_game_round/2_selecting_player_phase_view.dart';
import 'package:flutter_bull/src/views/4_game_round/3_voting_phase_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameRoundView extends ConsumerStatefulWidget {
  const GameRoundView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameRoundViewState();
}

class _GameRoundViewState extends ConsumerState<GameRoundView> {
  final navController = GameRoundNavigationController();

  @override
  Widget build(BuildContext context) {
    final roomId = ref.watch(getCurrentGameRoomIdProvider);
    final game = gameNotifierProvider(roomId);

    final roundPhaseListenable =
        game.select((state) => state.value?.phaseData.roundPhase);

    ref.listen(roundPhaseListenable, (prev, next) {
      if (next != null) navController.navigate(next);
    });

    final gameAsync = ref.watch(game);
    return gameAsync.whenDefault((data) => ControlledNavigator(controller: navController, data: data.phaseData.roundPhase));
  }
}

class GameRoundNavigationController extends NavigationController<RoundPhase> {
  void navigate(RoundPhase data) => navigateTo(data.name);

  @override
  Route get defaultRoute => throw UnimplementedError();

  @override
  String generateInitialRoute(RoundPhase data) {
    return data.name;
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'selecting':
        return ForwardRoute(scoped(SelectingPlayerPhaseView()));
      case 'voting':
        return ForwardRoute(scoped(VotingPhaseView()));
    }

    return null;
  }
}
