import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_round_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:flutter_bull/src/views/4_game_round/2_selecting_player_phase_view.dart';
import 'package:flutter_bull/src/views/4_game_round/3_voting_phase_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameRoundView extends ConsumerStatefulWidget {
  const GameRoundView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameRoundViewState();
}

class _GameRoundViewState extends ConsumerState<GameRoundView> with RoomID {
  final navController = GameRoundNavigationController();

  @override
  Widget build(BuildContext context) {
    
    final vmProvider =
        gameRoundViewNotifierProvider(roomId);


    ref.listen(vmProvider.select((value) => value.value?.path), (_, next) {
      if(next != null) navController.navigateTo(next);
    });

    final vmAsync = ref.watch(vmProvider);
    return vmAsync.whenDefault((data) => ControlledNavigator(
      observers: [CoordinatedRouteObserver()],
      controller: navController, data: data));
  }
}

class GameRoundNavigationController extends NavigationController<GameRoundViewModel> {
  void navigate(GameRoundViewModel data) => navigateTo(data.path);

  @override
  Route get defaultRoute => throw UnimplementedError();

  @override
  String generateInitialRoute(GameRoundViewModel data) {
    return data.path;
  }

  @override
  PageRoute? generateRoute() {
    switch (nextRoutePath) {
      case 'selecting':
        return ForwardPushRoute((context) => scoped(SelectingPlayerPhaseView()));
      case 'voting':
        return ForwardPushRoute((context) => scoped(VotingPhaseView()));
    }

    return null;
  }
}
