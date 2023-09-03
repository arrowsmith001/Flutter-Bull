import 'dart:async';

import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/achievement_notifier.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/5_reveals_phase/reveal_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reveal_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class RevealViewNotifier extends _$RevealViewNotifier {
  @override
  Stream<RevealViewModel> build(
      String roomId, String userId, String whoseTurnId) async* {
    final gameAsync = ref.watch(gameNotifierProvider(roomId));

    if (gameAsync is AsyncData) {
      final game = gameAsync.requireValue;
      yield _buildViewModel(game.gameRoom, game.players, game.result,
          game.achievementsWithIcons, userId, whoseTurnId);
    }
  }

  RevealViewModel _buildViewModel(
      GameRoom game,
      List<PlayerWithAvatar> players,
      GameResult? result,
      List<AchievementWithIcon> achievementsWithIcons,
      String userId,
      String whoseTurnId) {

    final int indexOfWhoseTurn = game.playerOrder.indexOf(whoseTurnId);
    final List<AchievementWithIcon> myAchievements = [];

    if (result != null) {

      final thisRoundsResults = result.result[indexOfWhoseTurn];

      final achievements =
          thisRoundsResults.playersToAchievements[userId]?.toList() ?? [];

      final achievementWithIcon = achievements.map((id) =>
          achievementsWithIcons.singleWhere((a) => a.achievement.id == id));

      myAchievements.addAll(achievementWithIcon);
    }

    return RevealViewModel(
        game: game,
        players: players,
        userId: userId,
        whoseTurnId: whoseTurnId,
        result: result,
        myAchievements: myAchievements);
  }
}
