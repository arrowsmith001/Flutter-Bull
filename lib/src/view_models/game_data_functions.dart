import 'dart:math';

import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';

class GameDataFunctions {
  static PlayerWithAvatar playerWhoseTurn(
          List<PlayerWithAvatar> players, String whoseTurnId) =>
      players.singleWhere((p) => p.player.id == whoseTurnId);

  static PlayerWithAvatar playerFromId(
      String id, List<PlayerWithAvatar> players) {
    return players.singleWhere((p) {
      return p.player.id == id;
    });
  }

  static String playersWhoseTurnStatement(GameRoom game, String whoseTurnId) =>
      game.texts[whoseTurnId]!;

  static bool isStatementTruth(GameRoom game, String whoseTurnId) =>
      game.targets[whoseTurnId] == whoseTurnId;

  static List<String> playersVotedLie(GameRoom game, String whoseTurnId) {
    return _playersVotedX(game, whoseTurnId, 'L');
  }

  static PlayerWithAvatar getTargetPlayer(
          GameRoom game, List<PlayerWithAvatar> players, String userId) =>
      players.singleWhere((p) => p.player.id == game.targets[userId]);

  static List<String> playersVotedTruth(GameRoom game, String whoseTurnId) {
    return _playersVotedX(game, whoseTurnId, 'T');
  }

  static List<String> _playersVotedX(
      GameRoom game, String whoseTurnId, String vote) {
    int index = _indexOfWhoseTurn(game, whoseTurnId);
    return game.votes.entries
        .where((entry) {
          final v = entry.value[index].toUpperCase();
          return v == vote;
        })
        .map((e) => e.key)
        .toList();
  }

  static int playersVoted(GameRoom game, String whoseTurnId) {
    int index = _indexOfWhoseTurn(game, whoseTurnId);
    return game.votes.entries
        .map((e) => e.value[index].toUpperCase())
        .where((v) => ['T', 'L'].contains(v))
        .length;
  }

  static int _indexOfWhoseTurn(GameRoom game, String whoseTurnId) =>
      game.playerOrder.indexOf(whoseTurnId);

  static bool isSaboteur(GameRoom game, String userId, String whoseTurnId) {
    return game.targets[userId] == whoseTurnId;
  }

  static String generatePlaceholderText(
      String id, Map<String, String> targets) {
    final target = targets[id];
    if (target == id) {
      return 'Write a TRUTH about yourself!';
    } else
      return 'Write a LIE about $target';
  }

  static String? getTargetText(GameRoom game, String userId) {
    return game.texts[game.targets[userId]];
  }

  static List<String> getShuffledIds(GameRoom game) {
    final pseudoShuffledIds = List<String>.from(game.playerOrder);

    // 'Random' seed = sum of the lengths of the text entries
    final int seed =
        game.texts.values.map((s) => s?.length ?? 0).reduce((v, e) => v + e);

    return pseudoShuffledIds..shuffle(Random(seed));
  }

  static int calculateTimeToReadOut(String statement) {
    return 1;
    final int wordCount = statement.split(' ').length;
    final int expectedRate = wordCount * 2;
    if (expectedRate < 3) return 3;
    if (expectedRate > 10) return 10;
    return expectedRate;
  }

  static Map<String, PlayerWithAvatar> makePlayerMap(
      List<PlayerWithAvatar> players) {
    return Map<String, PlayerWithAvatar>.fromEntries(players.map((e) => MapEntry(e.player.id!, e)));
  }
}
