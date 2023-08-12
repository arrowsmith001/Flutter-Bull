import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/game_data_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reveal_view_model.freezed.dart';

@freezed
class RevealViewModel with _$RevealViewModel {
  factory RevealViewModel(
      {required GameRoom game,
      required List<PlayerWithAvatar> players,
      required String userId,
      required String whoseTurnId}) {

    return RevealViewModel._(
        playerWhoseTurn: GameDataFunctions.playerWhoseTurn(players, whoseTurnId),
        playerWhoseTurnStatement: GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId),
        isStatementTruth: GameDataFunctions.isStatementTruth(game, whoseTurnId),
        playersVotedLie: GameDataFunctions.playersVotedLie(game, whoseTurnId)
            .map(GameDataFunctions.playerFromId(players))
            .toList(),
        playersVotedTruth: GameDataFunctions.playersVotedTruth(game, whoseTurnId)
            .map(GameDataFunctions.playerFromId(players))
            .toList(),
        isRevealed: game.subPhase == 1 || game.playerOrder.indexOf(whoseTurnId) < game.progress
        );
  }


  factory RevealViewModel._(
      {required PlayerWithAvatar playerWhoseTurn,
      required String playerWhoseTurnStatement,
      required bool isStatementTruth,
      required List<PlayerWithAvatar> playersVotedLie,
      required List<PlayerWithAvatar> playersVotedTruth,
      required bool isRevealed}) = _RevealViewModel;

 
}
