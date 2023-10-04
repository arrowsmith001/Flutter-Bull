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
import 'package:rxdart/rxdart.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameNotifier extends _$GameNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  UtterBullServer get _server => ref.read(utterBullServerProvider);

  String? get roomId => state.value!.gameRoom.id;

  @override
  Stream<GameNotifierState> build(String? gameRoomId) {
    if (gameRoomId == null) return const Stream.empty();

    return _streamService
        .streamGameRoom(gameRoomId)
        // .switchMap((room) {
        //   _streamService.strea
        // })
        .asyncMap((room) {
      return _buildState(room);
    });
  }

// TODO: Create parallel combined streams
  Future<GameNotifierState> _buildState(GameRoom room) async {
    final playerAvatars = await _getPlayerAvatars(room.playerIds);

    Logger().d('playerAvatars: $playerAvatars');

    //final result = await _getResult(room.resultId);
    //final achievementsWithIcons = await _getAchievements(result);

    return GameNotifierState(
      players: playerAvatars,
      gameRoom: room,
      //result: result,
      //achievementsWithIcons: achievementsWithIcons
    );
  }

  Future<Map<String, PlayerWithAvatar>> _getPlayerAvatars(
      List<String> playerIds) async {
    final prevList = state.valueOrNull?.players.keys ?? [];
    final allPlayers = {...playerIds, ...prevList}.toList();
    Logger().d('prevList: $prevList allPlayers: $allPlayers');

    final playerFutureAvatars =
        allPlayers.map((p) => ref.read(playerNotifierProvider(p).future));

    final avatarList = await Future.wait(playerFutureAvatars);

    return Map.fromEntries(avatarList.map((e) => MapEntry(e.player.id!, e)));
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
    Logger().d('reveal: $userId $roomId');
    await _server.reveal(roomId!, userId);
  }

  Future<void> revealNext(String userId) async {
    Logger().d('revealNext: $userId $roomId');
    await _server.revealNext(roomId!, userId);
  }

  // Future<GameResult?> _getResult(String? resultId) async {
  //   if (resultId == null) return null;
  //   final result = await _db.getResult(resultId);

  //   if (result != null)
  //     Logger().d('result: ' + result.toJson().toString());
  //   else
  //     Logger().d('null result');

  //   return result;
  // }

  // Future<List<AchievementWithIcon>> _getAchievements(GameResult? result) async {
  //   if (result == null) return [];

  //   final uniqueAchievements = <String>{};

  //   for (var r in result.result) {
  //     final lists = r.playersToAchievements.values;
  //     for (var l in lists) {
  //       for (var a in l) {
  //         uniqueAchievements.add(a);
  //       }
  //     }
  //   }

  //   final List<Future<AchievementWithIcon>> futures = [];
  //   for (var a in uniqueAchievements) {
  //     final f = ref.read(achievementNotifierProvider(a).future);
  //     futures.add(f);
  //   }
  //   final achievements = await Future.wait(futures);
  //   return achievements;
  // }
}
