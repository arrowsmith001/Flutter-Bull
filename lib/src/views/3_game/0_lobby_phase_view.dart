import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_phase_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/view_models/3_game/0_lobby_phase_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class LobbyPhaseView extends ConsumerStatefulWidget {
  const LobbyPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LobbyViewState();
}

class _LobbyViewState extends ConsumerState<LobbyPhaseView>
    with UserID, RoomID, TickerProviderStateMixin {
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


  late final vmProvider = lobbyPhaseViewNotifierProvider(roomId, userId);

  @override
  Widget build(BuildContext context) {
    final vmAsync = ref.watch(vmProvider);

    ref.listen(vmProvider.select((state) => state.value?.listChangeData),
        (_, next) {
      if (next == null) return;

      Logger().d('$userId lobby.playerIds: \n\t$next');

      if (next.listChangeType == ListChangeType.add) {
        _insertIntoPlayerList(next.data?.player.id, next.changeIndex);
      } else if (next.listChangeType == ListChangeType.remove) {
        _removeFromPlayerList(next.data, next.changeIndex);
      }
    });

    return Scaffold(body: vmAsync.whenDefault((vm) {
      return Column(
        children: [
          Text(vm.roomCode,
              style: TextStyle(fontFamily: 'LapsusPro', fontSize: 54)),
          Expanded(child: _buildList(vm) //_buildAnimatedList(vm),
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
                        userId, roomId), // TODO: Holy null check
                    title: 'Leave Room'),
              ),
            ]),
          )
        ],
      );
    }));
  }

  AnimatedList _buildAnimatedList(LobbyPhaseViewModel vm) {
    return AnimatedList(
        key: _listKey,
        shrinkWrap: true,
        initialItemCount: vm.presentPlayers.length,
        itemBuilder: (context, index, animation) {
          final player = vm.presentPlayers[index];

          return _buildAnimatedListItem(animation, player);
        });
  }

  Widget _buildAnimatedListItem(
      Animation<double> animation, PlayerWithAvatar playerWithAvatar) {
    final curvedAnim =
        CurvedAnimation(parent: animation, curve: Curves.elasticOut);

    return AnimatedBuilder(
        animation: curvedAnim,
        builder: (context, child) {
          return Transform.scale(
              key: ValueKey(playerWithAvatar.player.id),
              scale: animation.value,
              child: child);
        },
        child: _buildListItem(playerWithAvatar));
  }

  ListTile _buildListItem(PlayerWithAvatar playerWithAvatar) {
    return ListTile(
        title: Text(playerWithAvatar.player.name!),
        leading: UtterBullPlayerAvatar(playerWithAvatar.avatarData));
  }

  void _insertIntoPlayerList(String? changedItemId, int? changeIndex) {
    if (_listKey.currentState == null) return;
    if (changedItemId == null || changeIndex == null) return;

    _listKey.currentState!.insertItem(changeIndex);
  }

  void _removeFromPlayerList(PlayerWithAvatar? changedItem, int? changeIndex) {
    if (_listKey.currentState == null) return;
    if (changedItem == null || changeIndex == null) return;

    _listKey.currentState!.removeItem(changeIndex, (context, animation) {
      return _buildAnimatedListItem(animation, changedItem);
    });
  }

  Widget _buildList(LobbyPhaseViewModel vm) {
    return ListView(
      children: vm.presentPlayers.map((e) => _buildListItem(e)).toList(),
    );
  }
}
