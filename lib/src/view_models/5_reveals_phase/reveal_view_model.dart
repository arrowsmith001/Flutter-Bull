import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/achievement_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/game_data_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reveal_view_model.freezed.dart';

@freezed
class RevealViewModel with _$RevealViewModel {
  factory RevealViewModel(
      {
        required GameRoom game,
      required List<PlayerWithAvatar> players,
      required String userId,
      required String whoseTurnId,
      required GameResult? result, 
      required List<AchievementWithIcon> myAchievements
      }) {

    final int indexOfWhoseTurn = game.playerOrder.indexOf(whoseTurnId);

    return RevealViewModel._(
      playerWhoseTurn: GameDataFunctions.playerWhoseTurn(players, whoseTurnId),
      playerWhoseTurnStatement:
          GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId),
      isStatementTruth: GameDataFunctions.isStatementTruth(game, whoseTurnId),
      playersVotedLie: GameDataFunctions.playersVotedLie(game, whoseTurnId)
          .map((id) => GameDataFunctions.playerFromId(id, players))
          .toList(),
      playersVotedTruth: GameDataFunctions.playersVotedTruth(game, whoseTurnId)
          .map((id) => GameDataFunctions.playerFromId(id, players))
          .toList(),
      isRevealed: game.subPhase == 1 || indexOfWhoseTurn < game.progress,
      isMyTurn: userId == whoseTurnId,
      achievements: myAchievements
    );
  }

  factory RevealViewModel._({
    required PlayerWithAvatar playerWhoseTurn,
    required String playerWhoseTurnStatement,
    required bool isStatementTruth,
    required List<PlayerWithAvatar> playersVotedLie,
    required List<PlayerWithAvatar> playersVotedTruth,
    required bool isRevealed,
    required bool isMyTurn,
    required List<AchievementWithIcon> achievements
  }) = _RevealViewModel;
}
