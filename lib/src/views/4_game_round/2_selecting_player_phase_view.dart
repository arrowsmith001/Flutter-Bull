import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/widgets/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectingPlayerPhaseView extends ConsumerStatefulWidget {
  const SelectingPlayerPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectingPlayerPhaseViewState();
}

class _SelectingPlayerPhaseViewState
    extends ConsumerState<SelectingPlayerPhaseView> {
  @override
  Widget build(BuildContext context) {
    final roomId = ref.watch(getCurrentGameRoomIdProvider);
    final participantId = ref.watch(getSignedInPlayerIdProvider);
    final whoseTurn = ref.watch(getPlayerWhoseTurnIdProvider);

    final gameProvider = gameNotifierProvider(roomId);
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.watch(gameProvider.notifier);

    return gameState.whenDefault((state) {
      bool myTurn = state.isTurnOf(participantId);

      String text;
      if (myTurn) {
        text = state.getStatement(participantId);
      } else
        text = whoseTurn + ' is about to read';

        
      return Center(
        child: Column(
          children: [
            Text(text),
           !myTurn ? Container() : PlaceholderButton(
              title: 'Advance',
              onPressed: () {
                ref.read(utterBullServerProvider).startRound(ref.read(getCurrentGameRoomIdProvider), ref.read(getSignedInPlayerIdProvider));
              },
              )
          ],
        ),
      );
    });

  }
}
