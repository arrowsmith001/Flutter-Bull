import 'dart:async';

import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/achievement_notifier.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/result_notifier.dart';
import 'package:flutter_bull/src/utils/result_generator.dart';
import 'package:flutter_bull/src/view_models/5_reveals_phase/reveal_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reveal_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class RevealViewNotifier extends _$RevealViewNotifier {
  
  @override
  Stream<RevealViewModel> build(
      String roomId, String userId, String whoseTurnId) async* {
        
    final gameAsync = ref.watch(gameNotifierProvider(roomId));
    final resultAsync = ref.watch(resultNotifierProvider(roomId));

    if (gameAsync is AsyncData && resultAsync is AsyncData) {
      final game = gameAsync.requireValue;
      final result = resultAsync.requireValue;

      yield _buildViewModel(game.gameRoom, game.players, 
          userId, whoseTurnId,
          result.resultGenerator);
    }
  }

  RevealViewModel _buildViewModel(
      GameRoom game,
      Map<String, PublicPlayer> players,
      String userId,
      String whoseTurnId, 
      ResultGenerator resultGenerator, 
      // GameResult? result,
      // List<AchievementWithIcon> achievementsWithIcons
      ) {

    final int indexOfWhoseTurn = game.playerOrder.indexOf(whoseTurnId);
    final List<Achievement> myAchievements = resultGenerator.playerAchievementsByRound[indexOfWhoseTurn][userId]!;

    return RevealViewModel(
        game: game,
        players: players,
        userId: userId,
        whoseTurnId: whoseTurnId,
        myAchievements: myAchievements);
  }
}
