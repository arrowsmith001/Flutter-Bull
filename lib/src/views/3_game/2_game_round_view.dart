import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_round_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:flutter_bull/src/views/4_game_round/0_selecting_player_view.dart';
import 'package:flutter_bull/src/views/4_game_round/1_shuffle_players_view.dart';
import 'package:flutter_bull/src/views/4_game_round/2_reader_view.dart';
import 'package:flutter_bull/src/views/4_game_round/3_reading_out_view.dart';
import 'package:flutter_bull/src/views/4_game_round/4_voting_view.dart';
import 'package:flutter_bull/src/views/4_game_round/5_voting_end_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: reader onwards

class GameRoundView extends ConsumerStatefulWidget {
  const GameRoundView({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameRoundViewState();
}

class _GameRoundViewState extends ConsumerState<GameRoundView>
    with UserID, RoomID, WhoseTurnID {

  final navController = GameRoundNavigationController();

  @override
  Widget build(BuildContext context) {
    
    final vmProvider = gameRoundViewNotifierProvider(userId, roomId, whoseTurnId);

    ref.listen(vmProvider.select((value) => value.value), (_, next) {
      if (next != null) navController.navigate(next);
    });

    final vmAsync = ref.watch(vmProvider);
    return vmAsync.whenDefault((data) => ControlledNavigator(
        observers: [CoordinatedRouteObserver(), HeroController()],
        controller: navController,
        data: data));
  }
}

class GameRoundNavigationController
    extends NavigationController<GameRoundViewModel> {

  void navigate(GameRoundViewModel data) => navigateTo(data.roundPhase.name);

  @override
  Route get defaultRoute => throw UnimplementedError();

  @override
  String generateInitialRoute(GameRoundViewModel data) {
    return data.roundPhase.name;
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'selecting':
        return ForwardPushRoute(
            (context) => scoped(SelectingPlayerPhaseView()));
      case 'shuffling':
        return ForwardPushRoute((context) => scoped(ShufflePlayersAnimationView()));
      case 'reader':
        return ForwardPushRoute(
            (context) => scoped(ReaderView()));
      case 'reading':
        return PageRouteBuilder(pageBuilder: (context, anim, anim2) => scoped(ReadingOutView()));
      case 'voting':
        return ForwardPushRoute((context) => scoped(VotingPhaseView()));
      case 'votingEnd':
        return ForwardPushRoute((context) => scoped(VotingEndView()));
    }

    return null;
  }
}
