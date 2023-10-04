import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_phase_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/view_models/3_game/0_lobby_phase_view_model.dart';
import 'package:flutter_bull/src/widgets/common/regular_rectangle_packer.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
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

  final _listKey = GlobalKey<AnimatedGridState>();

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
      return Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.white, Colors.white.withOpacity(0)])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(children: [
                    Text(
                      'Game Code:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    AutoSizeText(vm.roomCode,
                        maxLines: 1, style: TextStyle(fontSize: 64))
                  ]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.45), borderRadius: BorderRadius.circular(16.0)),
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                      child: Column(
                        children: [
                          Text(
                            'Players',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildAnimatedList(vm),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.75),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(vm.numberOfPlayersString),
                    Flexible(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () =>
                                    _getServer.removeFromRoom(userId, roomId),
                                icon: Transform.flip(
                                    flipX: true,
                                    child: Icon(Icons.exit_to_app_rounded))),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: SizedBox(
                                height: 85,
                                child: vm.isStartingGame ? UtterBullCircularProgressIndicator() : UtterBullButton(
                                    onPressed: vm.enoughPlayers
                                        ? () => _getServer.startGame(roomId)
                                        : null,
                                    title: 'Start Game'),
                              ),
                            )
                          ]),
                    ),
                  ]),
                ),
              )
            ],
          )
        ],
      );
    }));
  }

  final ScrollController _scrollController = ScrollController();

  // TODO: Change to RegularRectanglePacker
  Widget _buildAnimatedList(LobbyPhaseViewModel vm) {
    return AnimatedGrid(
      controller: _scrollController,
        key: _listKey,
        initialItemCount: vm.presentPlayers.length,
        itemBuilder: (context, index, animation)
        {
          final player = vm.presentPlayers.values.toList()[index];
          return _buildAnimatedListItem(animation, player);
      
        }, 
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.15),);
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
              scale: curvedAnim.value,
              child: child);
        },
        child: _buildListItem(playerWithAvatar));
  }

  Widget _buildListItem(PlayerWithAvatar playerWithAvatar) {
    return SizedBox(
          height: 120,
          child: UtterBullPlayerAvatar(playerWithAvatar.player.name!, playerWithAvatar.avatarData));
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
      children: vm.presentPlayers.values.map((e) => _buildListItem(e)).toList(),
    );
  }
}
