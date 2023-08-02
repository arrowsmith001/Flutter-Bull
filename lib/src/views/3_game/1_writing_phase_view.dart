import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/widgets/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class WritingPhaseView extends ConsumerStatefulWidget {
  const WritingPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WritingPhaseViewState();
}

class _WritingPhaseViewState extends ConsumerState<WritingPhaseView> {
  UtterBullServer get _getServer => ref.read(utterBullServerProvider);
  TextEditingController _submissionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userId = ref.watch(getSignedInPlayerIdProvider);
    final roomId = ref.watch(getCurrentGameRoomIdProvider);


    final game = gameNotifierProvider(roomId);
    final gameState = ref.watch(game);


    return gameState.whenDefault((state) {

      final round = state.rolesState;
      final myTarget = round.getTarget(userId);
      final message = myTarget == userId ? 'YOURSELF' : myTarget;

      return Column(
        children: [
          Flexible(
            child: Text(
                'Write a ${round.isTruther(userId) ? 'TRUTH' : 'LIE'} about $message'),
          ),
          Flexible(child: TextField(controller: _submissionController)),
          Flexible(
            child: PlaceholderButton(
                onPressed: () {
                  _getServer.submitText(
                      roomId, userId, _submissionController.text);
                },
                title: 'Submit Text'),
          )
        ],
      );
    });

    return Center(child: gameState.whenDefault((state) {
      Logger().d(state.toString());

      final roles = state.rolesState;

      return ListView(
        children: roles.participants.map((id) {
          return ListTile(
            title: Text(id),
            leading: Container(
              width: 50,
              height: 50,
              color: roles.isTruther(id) ? Colors.green : Colors.red,
            ),
          );
        }).toList(),
      );
    }));
  }
}
