import 'dart:typed_data';

import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/achievement_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part 'reveal_view_model.freezed.dart';

@freezed
class RevealViewModel with _$RevealViewModel {
  factory RevealViewModel(
      {required GameRoom game,
      required Map<String, PublicPlayer> players,
      required String userId,
      required String whoseTurnId,
      required List<Achievement> myAchievements}) {
    try {
      final int indexOfWhoseTurn = game.playerOrder.indexOf(whoseTurnId);

      return RevealViewModel._(
          playerWhoseTurn:
              GameDataFunctions.playerWhoseTurn(players, whoseTurnId),
          playerWhoseTurnStatement:
              GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId),
          isStatementTruth:
              GameDataFunctions.isStatementTruth(game, whoseTurnId),
          playersVotedLie: GameDataFunctions.playersVotedLie(game, whoseTurnId)
              .map((id) => players[id]!)
              .toList(),
          playersVotedTruth:
              GameDataFunctions.playersVotedTruth(game, whoseTurnId)
              .map((id) => players[id]!)
                  .toList(),
          isRevealed: game.subPhase == 1 || indexOfWhoseTurn < game.progress,
          isMyTurn: userId == whoseTurnId,
          achievements: myAchievements);
    } catch (e) {

      Logger().e('Failed to create RevealViewModel: $e');
      return RevealViewModel._(
          playerWhoseTurn: PublicPlayer(Player(name: 'player.name'), Uint8List(0)),
          playerWhoseTurnStatement: 'playerWhoseTurnStatement',
          isStatementTruth: false,
          playersVotedLie: [],
          playersVotedTruth: [],
          isRevealed: false,
          isMyTurn: false,
          achievements: []);
    }
  }

  factory RevealViewModel._(
      {required PublicPlayer playerWhoseTurn,
      required String playerWhoseTurnStatement,
      required bool isStatementTruth,
      required List<PublicPlayer> playersVotedLie,
      required List<PublicPlayer> playersVotedTruth,
      required bool isRevealed,
      required bool isMyTurn,
      required List<Achievement> achievements}) = _RevealViewModel;
}
