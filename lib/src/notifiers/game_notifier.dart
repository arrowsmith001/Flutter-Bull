import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/loadable.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: false)
class GameNotifier extends _$GameNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);

  @override
  Stream<GameNotifierState> build(String gameRoomId) {
/*     final playerStream = _streamService.streamPlayer(userId);
    final roomStream = _streamService.streamGameRoom(gameRoomId);

    return CombineLatestStream.combine2(
        playerStream, roomStream, (player, room) => _buildState(player, room)); */

    return _streamService.streamGameRoom(gameRoomId).map((room) {
      return _buildState(room);
    });
  }

  // TODO: Tie playerIdList changes to playerNotifier so that playerIdList updated == player with avatar loaded available :)

  GameNotifierState _buildState(GameRoom room) {
    Logger().d(room);

    final prevList = state.value?.playerListState;

    final playerListState = ListState.fromLists(prevList?.list, room.playerIds);

    final playerRoles = RolesState(targets: room.targets, texts: room.texts);

    final rounds = RoundsState(
        order: room.playerOrder,
        playerIds: room.playerIds,
        progress: room.progress);

    final phaseData =
        GamePhaseData(phase: room.phase, arg: rounds.getCurrentPlayerWhoseTurn);

    return GameNotifierState(
      roomCode: room.roomCode,
        playerListState: playerListState,
        rolesState: playerRoles,
        roundsState: rounds,
        phaseData: phaseData);
  }

  bool isItMyTurn(String userId) {
    return state.requireValue.roundsState.isItMyTurn(userId);
  }

  String? get getCurrentPlayerWhoseTurn {
    return state.requireValue.roundsState.getCurrentPlayerWhoseTurn;
  }

  String getMyText(String participantId) {
    return state.requireValue.rolesState.getMyText(participantId);
  }
}
