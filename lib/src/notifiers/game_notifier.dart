import 'dart:async';

import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameNotifier extends _$GameNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  UtterBullServer get _server => ref.read(utterBullServerProvider);

  @override
  Stream<GameNotifierState> build(String? gameRoomId) {
    if (gameRoomId == null) return Stream.empty();
    return _streamService.streamGameRoom(gameRoomId)
      .asyncMap((room)
      {
        return _buildState(room);
      });
    
  }

  Future<GameNotifierState> _buildState(GameRoom room) async {
    final playerAvatars = await _getPlayerAvatars(room.playerIds);

    return GameNotifierState(players: playerAvatars, gameRoom: room);
  }

  Future<List<PlayerWithAvatar>> _getPlayerAvatars(
      List<String> playerIds) async {
    final prevList = state.valueOrNull?.players.map((e) => e.player.id!) ?? [];
    final allPlayers = {...playerIds, ...prevList}.toList();

    final playerFutureAvatars =
        allPlayers.map((p) => ref.read(playerNotifierProvider(p).future));

    return await Future.wait(playerFutureAvatars);
  }

  Future<void> vote(String userId, bool truthOrLie) async {
    await _server.vote(state.value!.gameRoom.id!, userId, truthOrLie);
  }

  Future<void> endRound(String userId) async {
    await _server.endRound(state.value!.gameRoom.id!, userId);
  }

  Future<void> reveal(String userId) async {
    await _server.reveal(state.value!.gameRoom.id!, userId);

  }

  Future<void> revealNext(String userId) async {
    await _server.revealNext(state.value!.gameRoom.id!, userId);

  }
}
