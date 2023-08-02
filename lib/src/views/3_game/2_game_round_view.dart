/* import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameRoundView extends ConsumerStatefulWidget {
  const GameRoundView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameRoundViewState();
}

class _GameRoundViewState extends ConsumerState<GameRoundView> {
  NavigationController<RoundsState> navController =
      GameRoundNavigationController();

  @override
  Widget build(BuildContext context) {

    final roomId = ref.watch(getCurrentGameRoomIdProvider);
    final signedInPlayerId = ref.watch(getSignedInPlayerIdProvider);

    final gameRoundsState = gameNotifierProvider(roomId, signedInPlayerId).select((state) => state.value?.roundsState);

    ref.listen(
        gameRoundsState, (prev, next) 
        {


        });

    return ControlledNavigator(controller: navController, data: data);
  }
}

class GameRoundNavigationController extends NavigationController<RoundsState> {
  @override
  Route get defaultRoute => throw UnimplementedError();

  @override
  String generateInitialRoute(RoundsState data) {
    // TODO: implement generateInitialRoute
    throw UnimplementedError();
  }

  @override
  PageRoute? generateRoute() {
    // TODO: implement generateRoute
    throw UnimplementedError();
  }
}
 */