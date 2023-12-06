import 'dart:math';

import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/mixins/game_hooks.dart';
import 'package:flutter_bull/src/mixins/round_hooks.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_event_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/views/4_game_round/0_selecting_player_view.dart';
import 'package:flutter_bull/src/views/4_game_round/1_shuffle_players_view.dart';
import 'package:flutter_bull/src/views/4_game_round/2_reader_view.dart';
import 'package:flutter_bull/src/views/4_game_round/3_reading_out_view.dart';
import 'package:flutter_bull/src/views/4_game_round/4_voting_view.dart';
import 'package:flutter_bull/src/views/4_game_round/5_voting_end_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bull/src/mixins/auth_hooks.dart';
import 'package:logger/logger.dart';

// TODO: reader onwards

class GameRoundView extends ConsumerStatefulWidget {
  const GameRoundView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameRoundViewState();
}

class _GameRoundViewState extends ConsumerState<GameRoundView> with GameHooks {
  late final navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(
        gameEventNotifierProvider(gameId)
            .select((value) => value.valueOrNull?.newGameRoute?.subPhase),
        (_, next) {
      if (next != null)
        navKey.currentState?.pushNamed(RoundPhase.values[next].name);
    });

    return Navigator(
        initialRoute:
            subPhase == null ? '/' : RoundPhase.values[subPhase!].name,
        observers: [CoordinatedRouteObserver(), HeroController()],
        onGenerateRoute: (settings) {

          switch (settings.name) {
            case 'selecting':
              return ForwardPushRoute((context) => SelectingPlayerPhaseView());
            case 'shuffling':
              return ForwardPushRoute(
                  (context) => ShufflePlayersAnimationView());
            case 'reader':
              return isFinalRound
                  ? ForwardPushRoute((context) => const ReaderView())
                  : UpwardPushRoute((context) => const ReaderView());
            case 'reading':
              return PageRouteBuilder(
                  pageBuilder: (context, anim, anim2) =>
                      const ReadingOutView());
            case 'voting':
              return ForwardPopRoute((context) => const VotingPhaseView());
            case 'votingEnd':
              return ForwardPushRoute((context) => const VotingEndView());
          }

          return PageRouteBuilder(
              pageBuilder: (context, anim, anim2) =>
                  UtterBullCircularProgressIndicator());
        });
  }
}

class ExitDropTurnRoute extends CoordinatedPageRoute {
  ExitDropTurnRoute(super.builder, {this.turn = 0.0})
      : super(
            transitionDuration:
                UtterBullGlobal.votingPhaseTransitionToDuration);

  final double turn;

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return child;
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    final anim = CurvedAnimation(parent: animation, curve: Curves.easeIn);

    return SlideTransition(
      position: anim.drive(Tween(begin: Offset.zero, end: const Offset(0, 1))),
      child: RotationTransition(
          turns: anim.drive(Tween(begin: 0, end: turn * (pi / 4))),
          child: child),
    );
  }
}

class ForwardPopRoute extends CoordinatedPageRoute {
  ForwardPopRoute(super.builder)
      : super(
            transitionDuration:
                UtterBullGlobal.votingPhaseTransitionToDuration);
  double overlap = 0.2;
  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
              parent: animation,
              curve:
                  Interval(0.5 - (overlap / 2), 1.0, curve: Curves.elasticOut))
          .drive(Tween(begin: 0.0, end: 1.0)),
      child: child,
    );
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return SlideTransition(
      position: CurvedAnimation(
              parent: animation,
              curve: Interval(0.0, 0.5 + (overlap / 2), curve: Curves.easeOut))
          .drive(Tween(begin: Offset.zero, end: const Offset(-1, 0))),
      child: child,
    );
  }
}
