import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/widgets/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/utter_bull_player_avatar.dart';
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

  UtterBullServer get _getServer => ref.read(utterBullServerProvider);

  @override
  Widget build(BuildContext context) {
    final signedInPlayerId = ref.watch(getSignedInPlayerIdProvider);
    final signedInPlayer = playerNotifierProvider(signedInPlayerId);
    final signedInPlayerState = ref.watch(signedInPlayer);

    final roomId = ref.watch(getCurrentGameRoomIdProvider);
    final game = gameNotifierProvider(roomId);
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
      return Column(
        children: [
          Text(state.roomCode,
              style: TextStyle(fontFamily: 'LapsusPro', fontSize: 54)),
          Expanded(
            child: AnimatedList(
                key: _listKey,
                shrinkWrap: true,
                initialItemCount: state.playerListState.length,
                itemBuilder: (context, index, animation) {
                  final playerId = state.playerListState.list[index];

                  return _buildAnimatedListItem(animation, playerId);
                }),
          ),
          Flexible(
            child: Column(children: [
              Flexible(
                child: PlaceholderButton(
                    onPressed: () => _getServer.startGame(roomId),
                    title: 'Start Game'),
              ),
              Flexible(
                child: PlaceholderButton(
                    onPressed: () => _getServer.removeFromRoom(
                        ref.read(signedInPlayer).requireValue.player.id!,
                        roomId), // TODO: Holy null check
                    title: 'Leave Room'),
              ),
            ]),
          )
        ],
      );
    }));
  }

  AnimatedBuilder _buildAnimatedListItem(
      Animation<double> animation, String playerId) {
    final asyncOtherPlayer = ref.watch(playerNotifierProvider(playerId));
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
              key: ValueKey(playerId), opacity: animation.value, child: child);
        },

        child: asyncOtherPlayer.when(
          loading: () => Container(), error:(error, stackTrace) => Container(),
          data: (data) {
            return ListTile(
                title: Text(data.player.name!),
                leading: UtterBullPlayerAvatar(data.avatarData));
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
