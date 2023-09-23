import 'dart:async';

import 'package:flutter_bull/src/custom/data/abstract/database_service.dart';
import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/achievement_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameNotifier extends _$GameNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  UtterBullServer get _server => ref.read(utterBullServerProvider);
  DataService get _db => ref.read(dataServiceProvider);

  @override
  Stream<GameNotifierState> build(String? gameRoomId) {
    if (gameRoomId == null) return const Stream.empty();

    return _streamService.streamGameRoom(gameRoomId).asyncMap((room) {
      return _buildState(room);
    });
  }

// TODO: Create parallel combined streams
  Future<GameNotifierState> _buildState(GameRoom room) async {
    final playerAvatars = await _getPlayerAvatars(room.playerIds);

    final result = await _getResult(room.resultId);

    final achievementsWithIcons = await _getAchievements(result);

    return GameNotifierState(
        players: playerAvatars, gameRoom: room, result: result, achievementsWithIcons: achievementsWithIcons);
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

  Future<void> startRound(String userId) async {
    await _server.startRound(state.value!.gameRoom.id!, userId);
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

  Future<GameResult?> _getResult(String? resultId) async {
    if (resultId == null) return null;
    final result = await _db.getResult(resultId);

    if (result != null)
      Logger().d(result.toJson().toString());
    else
      Logger().d('null result');

    return result;
  }

  Future<List<AchievementWithIcon>> _getAchievements(GameResult? result) async {
    if (result == null) return [];

    final uniqueAchievements = <String>{};

    for (var r in result.result) {
      final lists = r.playersToAchievements.values;
      for (var l in lists) {
        for (var a in l) {
          uniqueAchievements.add(a);
        }
      }
    }

    final List<Future<AchievementWithIcon>> futures = [];
    for (var a in uniqueAchievements) {
      final f = ref.read(achievementNotifierProvider(a).future);
      futures.add(f);
    }
    final achievements = await Future.wait(futures);
    return achievements;
  }
}
