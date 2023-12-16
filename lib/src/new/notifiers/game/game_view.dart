import 'package:flutter/material.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/mixins/game_hooks.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/providers/game_data.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/views/3_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/1_writing_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/views/3_game/3_reveals_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/4_result_phase_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class GameView extends ConsumerStatefulWidget {
  const GameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends ConsumerState<GameView> {
  
  late final _navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    
    ref.listen(getPhaseProvider, (prev, next) {
      Logger().d('getPhaseProvider $next');
      if (next != null) {
        if (prev != GamePhase.results) {
          _navKey.currentState?.pushReplacementNamed(next.name,
              arguments: {'progress': 0, 'initial': prev == null});
        }
      }
    });

    // ref.listen(
    //     getProgressProvider, (prev, next) {
    //   if (next != null) {
    //     //if (prev?.phase != GamePhase.results) {
    //     _navKey.currentState?.pushReplacementNamed(next.name,
    //         arguments: {'progress': next.progress, 'initial': prev == null});
    //     //}
    //   }
    // });

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
            initialRoute: ref.read(getPhaseProvider)?.name,
            onGenerateRoute: (settings) {
              final Map? args = settings.arguments as Map?;
              switch (settings.name) {
                case 'lobby':
                  const lobby = LobbyPhaseView();
                  if (args?['initial']) {
                    return ForwardPushRoute((context) => lobby);
                  } else {
                    return BackwardPushRoute((context) => lobby);
                  }
                case 'writing':
                  return ForwardPushRoute((context) => const WritingPhaseView());
                case 'round':
                  final progressOverride = getProgressProvider
                      .overrideWithValue(args?['progress'] as int);
                  return ForwardPushRoute((context) => ProviderScope(
                      overrides: [progressOverride], child: const GameRoundView()));
                case 'reveals':
                  return ForwardPushRoute((context) => const RevealsPhaseView());
                case 'results':
                  return ForwardPushRoute((context) => const ResultView());
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
