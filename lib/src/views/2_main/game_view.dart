import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/2_main/game_view_model.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_bull/src/views/3_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/1_writing_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/views/3_game/3_reveals_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/4_result_phase_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../enums/game_phases.dart';

class GameView extends ConsumerStatefulWidget {
  const GameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends ConsumerState<GameView> with UserID, RoomID {
  final navController = GameRouteNavigationController();

  late final vmProvider = gameViewNotifierProvider(roomId, userId!);

  @override
  Widget build(BuildContext context) {
    // Reacts to changes
    ref.listen(vmProvider.select((value) => value.value?.path), (prev, next) {
      if (next != null) {
        if (prev?.phase != GamePhase.results) {
          if(prev?.getPathString != next.getPathString)
          {
            navController.navigateTo(next.getPathString);
          }
        }
      }
    });

    ref.listen(vmProvider.select((value) => value.value?.playerState),
        (prev, next) {
      if (prev == PlayerState.inGame && next != PlayerState.inGame) {
        navController.navigateTo(GamePhase.lobby.name);
      }
    });

    final vmAsync = ref.watch(vmProvider);

    return Scaffold(
      body: Container(
        decoration: UtterBullGlobal.gameViewDecoration,
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
    if (data.path.phase == GamePhase.results) return GamePhase.lobby.name;
    return data.path.getPathString;
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'lobby':
        return BackwardPushRoute((context) => scoped(LobbyPhaseView()));
      case 'writing':
        return ForwardPushRoute((context) => scoped(WritingPhaseView()));
      case 'round':
        final whoseTurnOverride =
            getPlayerWhoseTurnIdProvider.overrideWithValue(nextRoutePath);
        return ForwardPushRoute((context) =>
            scoped(GameRoundView(), overrides: [whoseTurnOverride]));
      case 'reveals':
        return ForwardPushRoute((context) => scoped(RevealsPhaseView()));
      case 'results':
        return ForwardPushRoute((context) => scoped(ResultView()));
    }

    return null;
  }
}
