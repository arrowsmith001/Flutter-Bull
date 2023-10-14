import 'dart:math';

import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_round_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:flutter_bull/src/views/4_game_round/0_selecting_player_view.dart';
import 'package:flutter_bull/src/views/4_game_round/1_shuffle_players_view.dart';
import 'package:flutter_bull/src/views/4_game_round/2_reader_view.dart';
import 'package:flutter_bull/src/views/4_game_round/3_reading_out_view.dart';
import 'package:flutter_bull/src/views/4_game_round/4_voting_view.dart';
import 'package:flutter_bull/src/views/4_game_round/5_voting_end_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

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
    final vmProvider =
        gameRoundViewNotifierProvider(userId, roomId, whoseTurnId);

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
  void navigate(GameRoundViewModel data) => navigateTo(dataToRoute(data));

  @override
  Route get defaultRoute => throw UnimplementedError();

  @override
  String generateInitialRoute(GameRoundViewModel data) {
    return dataToRoute(data);
  }

  String dataToRoute(GameRoundViewModel data) =>
      '${data.roundPhase.name}/${data.isFinalRound}';

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'selecting':
        final isFinalRound = bool.parse(nextRoutePath);
        return ForwardPushRoute((context) =>
            scoped(SelectingPlayerPhaseView(isFinalRound: isFinalRound)));
      case 'shuffling':
        return ForwardPushRoute(
            (context) => scoped(ShufflePlayersAnimationView()));
      case 'reader':
        return UpwardPushRoute((context) => scoped(ReaderView()));
      case 'reading':
        return PageRouteBuilder(
            pageBuilder: (context, anim, anim2) => scoped(ReadingOutView()));
      case 'voting':
        return ForwardPopRoute((context) => scoped(VotingPhaseView()));
      case 'votingEnd':
        return ForwardPushRoute((context) => scoped(VotingEndView()));
    }

    return null;
  }
}

class ExitDropTurnRoute extends CoordinatedPageRoute {
  ExitDropTurnRoute(super.builder, {this.turn = 0.0})
      : super(transitionDuration: UtterBullGlobal.votingPhaseTransitionToDuration);

  final double turn;

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return child;
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {

    final anim =
        CurvedAnimation(parent: animation, curve: Curves.easeIn);

    return SlideTransition(
      position: anim.drive(Tween(begin: Offset.zero, end: Offset(0, 1))),
      child: RotationTransition(
        child: child,
          turns: anim
              .drive(Tween(begin: 0, end: turn * (pi / 4)))),
    );
  }
}
class ForwardPopRoute extends CoordinatedPageRoute {
  ForwardPopRoute(super.builder)
      : super(transitionDuration: UtterBullGlobal.votingPhaseTransitionToDuration);

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation, curve: Curves.elasticOut).drive(Tween(begin: 0.5, end: 1.0)), child: child,);
  }

  @override
  Widget getExitTransition(BuildContext context, Animation<double> animation, Widget child) {
    return SlideTransition(position: CurvedAnimation(
        parent: animation, curve: Curves.easeInOut).drive(Tween(begin: Offset.zero, end: const Offset(-1, 0))), child: child,);
  }

}
