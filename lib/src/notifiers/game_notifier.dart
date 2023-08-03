import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: false)
class GameNotifier extends _$GameNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  UtterBullServer get _server => ref.read(utterBullServerProvider);

  @override
  Stream<GameNotifierState> build(String gameRoomId) {
/*     final playerStream = _streamService.streamPlayer(userId);
    final roomStream = _streamService.streamGameRoom(gameRoomId);

    return CombineLatestStream.combine2(
        playerStream, roomStream, (player, room) => _buildState(player, room)); */

    return _streamService.streamGameRoom(gameRoomId).asyncMap((room) async {
      return await _buildState(room);
    });
  }

  Future<GameNotifierState> _buildState(GameRoom room) async {
    Logger().d(room);

    final playerList = room.playerIds;

    final prevList = state.valueOrNull?.playerListState.list;
    final prevAllPlayers = state.valueOrNull?.allPlayersThisSession;

    final allPlayers = {...playerList, ...(prevAllPlayers ?? [])}.toList();
    final playerFutureAvatars = allPlayers.map((p) {
      return ref.read(playerNotifierProvider(p).future);
    });

    final playerAvatars = await Future.wait(playerFutureAvatars);

    final playerListState = ListState.fromLists(prevList, playerList);

    final playerRoles = RolesState(targets: room.targets, texts: room.texts);

    final rounds = RoundsState(
        order: room.playerOrder,
        playerIds: room.playerIds,
        progress: room.progress);

    final phaseData = GamePhaseData(
        gamePhase: room.phase,
        roundPhase: room.roundPhase,
        arg: rounds.getCurrentPlayerWhoseTurn);

    return GameNotifierState(
        roomId: room.id!,
        roomCode: room.roomCode,
        endTime: room.timeRemaining,
        allPlayersThisSession: allPlayers,
        playerAvatars: playerAvatars,
        playerListState: playerListState,
        rolesState: playerRoles,
        roundsState: rounds,
        phaseData: phaseData);
  }

  Future<void> vote(String userId, bool truthOrLie) async {
    await _server.vote(state.value!.roomId, userId, truthOrLie);
  }

  Future<void> endRound(String userId) async {
    await _server.endRound(state.value!.roomId, userId);
  }
}
