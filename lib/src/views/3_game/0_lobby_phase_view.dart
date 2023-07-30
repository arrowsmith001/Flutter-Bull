import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/room_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class LobbyPhaseView extends ConsumerStatefulWidget {
  const LobbyPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LobbyViewState();
}

class _LobbyViewState extends ConsumerState<LobbyPhaseView>
    with TickerProviderStateMixin {
  //late AnimationController _controller;

  @override
  void initState() {
    super.initState();
/*     _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(() {
      setState(() {});
    }); */
  }

  final _listKey = GlobalKey<AnimatedListState>();

  List<String> playerIdList = [];

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final roomId = ref.watch(getCurrentGameRoomIdProvider);

    final game = gameNotifierProvider(userId, roomId);
    final gameState = ref.watch(game);

    ref.listen(game.select((state) => state.value?.playerListState), (_, next) {
      if (next == null) return;

      Logger().d('lobby.playerIds: \n\t$next');

      if (next.hasChanged) {
        if (next.listChangeType == ListChangeType.increased) {
          _insertIntoPlayerList(next.changedItemId, next.changeIndex);
        } else if (next.listChangeType == ListChangeType.decreased) {
          _removeFromPlayerList(next.changedItemId, next.changeIndex);
        }
      }
    });

    return Scaffold(body: gameState.whenDefault((state) {
      final player = state.signedInPlayer;
      final room = state.gameRoom;

      return Column(
        children: [
          Expanded(child: Text(player.name!)),
          Expanded(
            child: Text(
              room.toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: AnimatedList(
                key: _listKey,
                shrinkWrap: true,
                initialItemCount: room.playerIds.length,
                itemBuilder: (context, index, animation) {
                  final playerId = room.playerIds[index];
                  return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Opacity(
                            key: ValueKey(index),
                            opacity: animation.value,
                            child: child);
                      },
                      child: ListTile(title: Text(playerId)));
                }),
          ),
          Expanded(
            child: TextButton(
              child: Text("leave room"),
              onPressed: () {
                ref
                    .read(utterBullServerProvider)
                    .removeFromRoom(player.id!, room.id!);
              },
            ),
          )
        ],
      );
    }));
  }

  void _insertIntoPlayerList(String? changedItemId, int? changeIndex) {
    if (_listKey.currentState == null) return;
    if (changedItemId == null || changeIndex == null) return;

    _listKey.currentState!.insertItem(changeIndex);
  }

  void _removeFromPlayerList(String? changedItemId, int? changeIndex) {
    if (_listKey.currentState == null) return;
    if (changedItemId == null || changeIndex == null) return;

    _listKey.currentState!.removeItem(changeIndex, (context, animation) {
      return ListTile(
        tileColor: Colors.red,
        title: Text(changedItemId),
      );
    });
  }
}
