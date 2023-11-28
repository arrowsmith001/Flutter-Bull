import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter_bull/src/mixins/game_hooks.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_event_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/2_main/game_view_model.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_bull/src/views/3_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/1_writing_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/views/3_game/3_reveals_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/4_result_phase_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../enums/game_phases.dart';

class GameView extends ConsumerStatefulWidget {
  const GameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends ConsumerState<GameView> with GameHooks {
  late final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(gameEvents.select((value) => value.valueOrNull?.newGameRoute),
        (prev, next) {
      if (next != null) {
        //if (prev?.phase != GamePhase.results) {
        _navKey.currentState
            ?.pushReplacementNamed(next.phase.name, arguments: next.progress);
        //}
      }
    });

    // ref.listen(vmProvider.select((value) => value.value?.playerState),
    //     (prev, next) {
    //   if (prev == PlayerState.inGame && next != PlayerState.inGame) {
    //     navController.navigateTo(GamePhase.lobby.name);
    //   }
    // });

    return Scaffold(
      body: Container(
        decoration: UtterBullGlobal.gameViewDecoration,
        child: Center(
          child: Navigator(
            key: _navKey,
            observers: [CoordinatedRouteObserver()],
            initialRoute: phase?.name,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case 'lobby':
                  return BackwardPushRoute((context) => LobbyPhaseView());
                case 'writing':
                  return ForwardPushRoute((context) => WritingPhaseView());
                case 'round':
                  final progressOverride = getProgressProvider
                      .overrideWithValue(settings.arguments as int);
                  return ForwardPushRoute((context) => ProviderScope(
                      overrides: [progressOverride], child: GameRoundView()));
                case 'reveals':
                  return ForwardPushRoute((context) => RevealsPhaseView());
                case 'results':
                  return ForwardPushRoute((context) => ResultView());
              }

              return PageRouteBuilder(
                  pageBuilder: (context, anim, anim2) =>
                      const UtterBullCircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
