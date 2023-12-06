import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/mixins/app_hooks.dart';
import 'package:flutter_bull/src/mixins/auth_hooks.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_event_notifier.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
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
import 'package:flutter_bull/src/widgets/common/utter_bull_single_option_dismissable_dialog.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../mixins/game_hooks.dart';
import '../../notifiers/view_models/lobby_player.dart';

class LobbyPhaseView extends ConsumerStatefulWidget {
  const LobbyPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LobbyViewState();
}

class _LobbyViewState extends ConsumerState<LobbyPhaseView>
    with TickerProviderStateMixin, GameHooks, AppHooks {

  final _rectKey =
      GlobalKey<AnimatedRegularRectanglePackerState<LobbyPlayer>>();

  UtterBullServer get _getServer => ref.read(utterBullServerProvider);


  void onReadyUp(bool isReady) {
    _getServer.setPlayerState(
        gameId!, userId!, isReady ? PlayerState.unready : PlayerState.ready);
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(gameEvents.select((state) => state.valueOrNull?.newPresentPlayers),
        (_, next) {
      if (next != null) {
        _rectKey.currentState?.setItems(next);
      }
    });

    // ref.listen(_vmProvider.select((state) => state.value?.listChangeData),
    //     (_, next) {
    //   if (next == null) return;

    //   Logger().d('$userId lobby.playerIds: \n\t$next');

    //   // if (next.listChangeType == ListChangeType.add) {
    //   //   final newPlayer = next.data!;
    //   //   _rectKey.currentState!.addItem(newPlayer);
    //   // }
    //   // if (next.listChangeType == ListChangeType.remove) {
    //   //   _rectKey.currentState!.removeItem(next.data!);
    //   // }

    //   // if (next.listChangeType == ListChangeType.add) {
    //   //   _insertIntoPlayerList(next.data?.player.id, next.changeIndex);
    //   // } else if (next.listChangeType == ListChangeType.remove) {
    //   //   _removeFromPlayerList(next.data, next.changeIndex);
    //   // }
    // });

    return Scaffold(body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGameCodeDisplay(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8),
                  child: isLeavingGame
                      ? UtterBullTextBox('Leaving Game...')
                      : _buildPlayerDisplay(context),
                ),
              ),
              isLeavingGame ? SizedBox.shrink() : _buildBottomControls()
            ],
          )
        ],
      ));
  }

  Widget _buildGameCodeDisplay(
      BuildContext context) {

    return gameCode == null ? UtterBullCircularProgressIndicator()
    : Container(
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //         colors: [Colors.white, Colors.white.withOpacity(0)])),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(children: [
          Text(
            'Game Code:',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          AutoSizeText(gameCode!,
              maxLines: 1, style: const TextStyle(fontSize: 64))
        ]),
      ),
    );
  }

  Container _buildPlayerDisplay(BuildContext context) {
    return Container(
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
              child: __buildRectanglePacker(),
            )),
          ],
        ),
      ),
    );
  }

  Container _buildBottomControls() {
    final button = isLeader
        ? UtterBullButton(
            onPressed: enoughPlayers
                ? () => onStartGamePressed(canStartGame)
                : null,
            title: 'Start Game')
        : isReady
            ? UtterBullButton(
                key: UniqueKey(),
                onPressed: () => onReadyUp(true),
                isShimmering: false,
                title: 'UNREADY')
            : UtterBullButton(
                key: UniqueKey(),
                onPressed: () => onReadyUp(false),
                isShimmering: true,
                title: 'READY UP');

    return Container(
      color: Colors.white.withOpacity(0.75),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('$numberOfPlayers player${numberOfPlayers == 1 ? '' : 's'}',
              style: Theme.of(context).textTheme.headlineSmall),
          Flexible(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => onLeaveGamePressed(),
                      icon: Transform.flip(
                          flipX: true,
                          child: const Icon(Icons.exit_to_app_rounded))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      height: 85,
                      child: isStartingGame || isMidGame
                          ? const UtterBullCircularProgressIndicator()
                          : button,
                    ),
                  )
                ]),
          ),
        ]),
      ),
    );
  }

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

  Widget __buildListItem(
      PublicPlayer publicPlayer, bool isReady, bool isLeader, bool isAbsent) {
    return LayoutBuilder(
        key: ValueKey<String>(publicPlayer.player.id!),
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LabelledAvatar(
              avatar: UtterBullPlayerAvatar(
                  publicPlayer.player.name!, publicPlayer.avatarData),
              labels: [
                AvatarStateLabel(
                    text: 'LEADER',
                    isActive: isLeader,
                    outline: Color.lerp(
                        Theme.of(context).primaryColor, Colors.white, 0.65)),
                AvatarStateLabel(text: 'READY', isActive: isReady && !isLeader)
              ],
            ),
          );
        });
  }

  AnimatedRegularRectanglePacker<LobbyPlayer>? rectPacker;

  Widget __buildRectanglePacker() {
    rectPacker ??= AnimatedRegularRectanglePacker<LobbyPlayer>(
        key: _rectKey,
        initialData: lobbyListInitialData,
        builder: (LobbyPlayer e) => __buildListItem(
            e.player,
            e.isReady,
            e.isLeader,
            e.isAbsent),
        itemToId: (LobbyPlayer lp) => lp.player.player.id!);
    return rectPacker!;
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

  void onStartGamePressed(bool canStartGame) {
    if (canStartGame) {
      game.startGame();
    } else {
      showDialog(
          context: context,
          builder: (context) => const UtterBullSingleOptionDismissableDialog(
              message: 'Not everyone is ready'));
    }
  }

  void onLeaveGamePressed() {
    game.leaveGame(userId);
  }
}

class LabelledAvatar extends StatelessWidget {
  const LabelledAvatar({
    super.key,
    required this.avatar,
    required this.labels,
  });

  final Widget avatar;
  final List<AvatarStateLabel> labels;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double h = constraints.maxHeight * 0.2;

        return Stack(
          children: [
            avatar,
            ...labels.map((e) => Positioned(
                top: 10, right: 0, child: SizedBox(height: h, child: e)))
          ],
        );
      },
    );
  }
}

class AvatarStateLabel extends StatelessWidget {
  AvatarStateLabel(
      {this.text,
      this.child,
      this.fill,
      this.outline,
      super.key,
      required this.isActive}) {
    assert(text != null || child != null);
    assert(text == null || child == null);
  }

  final String? text;
  final Widget? child;
  final Color? outline;
  final Color? fill;

  final bool isActive;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.decelerate,
      duration: duration,
      opacity: isActive ? 1 : 0,
      child: AnimatedContainer(
        curve: Curves.elasticInOut,
        transform: isActive ? Matrix4.identity() : Matrix4.identity() * 0.01,
        transformAlignment: Alignment.center,
        duration: duration,
        child: Transform.rotate(
            angle: pi * 0.06,
            child: text != null
                ? UglyOutlinedText(
                    text: text!,
                    outlineColor: outline ?? Colors.white,
                    fillColor: fill ?? Colors.black,
                  )
                : child),
      ),
    );
  }
}
