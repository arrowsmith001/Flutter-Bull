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
    return game.votes.entries.where((entry) {
      final v = entry.value[index].toUpperCase();
      return v == vote;
    }).map((e) => e.key).toList();
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
}
