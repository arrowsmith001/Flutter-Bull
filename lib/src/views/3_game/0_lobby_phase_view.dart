import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_phase_view_notifier.dart';
import 'package:flutter_bull/src/proto/animated_regular_rectangle_packer.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/view_models/3_game/0_lobby_phase_view_model.dart';
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

  UtterBullServer get _getServer => ref.read(utterBullServerProvider);

  late final vmProvider = lobbyPhaseViewNotifierProvider(roomId, userId);

  final rectKey = GlobalKey<AnimatedRegularRectanglePackerState<LobbyPlayer>>();

  @override
  Widget build(BuildContext context) {
    final vmAsync = ref.watch(vmProvider);

    ref.listen(vmProvider.select((state) => state.value?.listChangeData),
        (_, next) {
      if (next == null) return;

      Logger().d('$userId lobby.playerIds: \n\t$next');

      if (next.listChangeType == ListChangeType.add) {
        final newPlayer = next.data!;
        rectKey.currentState!.addItem(newPlayer);
      }
      if (next.listChangeType == ListChangeType.remove) {
        rectKey.currentState!.removeItem(next.data!);
      }

      // if (next.listChangeType == ListChangeType.add) {
      //   _insertIntoPlayerList(next.data?.player.id, next.changeIndex);
      // } else if (next.listChangeType == ListChangeType.remove) {
      //   _removeFromPlayerList(next.data, next.changeIndex);
      // }
    });

    return Scaffold(body: vmAsync.whenDefault((vm) {
      return Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.white.withOpacity(0)])),
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
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                      child: Column(
                        children: [
                          Text(
                            'Players',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildRectanglePacker(vm),
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
                                child: vm.isStartingGame
                                    ? UtterBullCircularProgressIndicator()
                                    : UtterBullButton(
                                        onPressed: vm.enoughPlayers
                                            ? () => _onStartGamePressed()
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
  // Widget _buildAnimatedList(LobbyPhaseViewModel vm) {
  //   return AnimatedGrid(
  //     controller: _scrollController,
  //     key: _listKey,
  //     initialItemCount: vm.presentPlayers.length,
  //     itemBuilder: (context, index, animation) {
  //       final player = vm.presentPlayers.values.toList()[index];
  //       return _buildAnimatedListItem(animation, player);
  //     },
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2, childAspectRatio: 1.15),
  //   );
  // }

  // Widget _buildAnimatedListItem(
  //     Animation<double> animation, PublicPlayer playerWithAvatar) {
  //   final curvedAnim =
  //       CurvedAnimation(parent: animation, curve: Curves.elasticOut);

  //   return AnimatedBuilder(
  //       animation: curvedAnim,
  //       builder: (context, child) {
  //         return Transform.scale(
  //             key: ValueKey(playerWithAvatar.player.id),
  //             scale: curvedAnim.value,
  //             child: child);
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.fromLTRB(0, 0, 0, 12.0),
  //         child: _buildListItem(playerWithAvatar),
  //       ));
  // }

  Widget _buildListItem(
      PublicPlayer playerWithAvatar, bool isReady, bool isLeader) {
    return LayoutBuilder(builder: (context, constraints) {
      final double h = constraints.maxHeight * 0.2;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            UtterBullPlayerAvatar(
                playerWithAvatar.player.name!, playerWithAvatar.avatarData),
            isLeader
                ? Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(height: h, child: LeaderLabel()))
                : isReady
                    ? Positioned(
                        top: 10,
                        right: 0,
                        child: SizedBox(height: h, child: ReadyLabel()))
                    : SizedBox.shrink()
          ],
        ),
      );
    });
  }

  // void _insertIntoPlayerList(String? changedItemId, int? changeIndex) {
  //   if (_listKey.currentState == null) return;
  //   if (changedItemId == null || changeIndex == null) return;

  //   _listKey.currentState!.insertItem(changeIndex);
  // }

  // void _removeFromPlayerList(PublicPlayer? changedItem, int? changeIndex) {
  //   if (_listKey.currentState == null) return;
  //   if (changedItem == null || changeIndex == null) return;

  //   _listKey.currentState!.removeItem(changeIndex, (context, animation) {
  //     return _buildAnimatedListItem(animation, changedItem);
  //   });
  // }

  // Widget _buildList(LobbyPhaseViewModel vm) {
  //   return ListView(
  //     children: vm.presentPlayers.values.map((e) => _buildListItem(e)).toList(),
  //   );
  // }

  void _onStartGamePressed() {
    _getServer.setPlayerState(roomId, userId, PlayerState.ready);
    //_getServer.startGame(roomId);
  }

  AnimatedRegularRectanglePacker<LobbyPlayer>? rectPacker;

  Widget _buildRectanglePacker(LobbyPhaseViewModel vm) {
    rectPacker ??= AnimatedRegularRectanglePacker<LobbyPlayer>(
        key: rectKey,
        initialData: vm.presentPlayers.values.toList(),
        builder: (LobbyPlayer e) => _buildListItem(e.player, e.isReady, e.isLeader),
        itemToId: (LobbyPlayer lp) => lp.player.player.id!);
    return rectPacker!;
  }
}

class ReadyLabel extends StatelessWidget {
  const ReadyLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return AvatarStateLabel('READY');
  }
}

class LeaderLabel extends StatelessWidget {
  const LeaderLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return AvatarStateLabel('LEADER',
        outline:
            Color.lerp(Theme.of(context).primaryColor, Colors.white, 0.65));
  }
}

class AvatarStateLabel extends StatelessWidget {
  const AvatarStateLabel(
    this.text, {
    this.outline,
    super.key,
  });

  final String text;
  final Color? outline;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: pi * 0.06,
        child: UglyOutlinedText(
          text,
          outlineColor: outline ?? Colors.white,
          fillColor: Colors.black,
        ));
  }
}
