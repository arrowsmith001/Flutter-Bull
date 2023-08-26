import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
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
    PlayerWithAvatar? playerWhoseTurn;
    String? playerWhoseTurnStatement;
    bool? isStatementTruth;
    List<PlayerWithAvatar>? playersVotedLie;
    List<PlayerWithAvatar>? playersVotedTruth;
    bool? isRevealed;
    try {
      playerWhoseTurn =
        GameDataFunctions.playerWhoseTurn(players, whoseTurnId); 
    } catch (e) {
      //Logger().d('playerWhoseTurn $e');
    }
    try {playerWhoseTurnStatement =
        GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId);} catch (e) {
      //Logger().d('playerWhoseTurnStatement $e');
    }
    try {isStatementTruth =
        GameDataFunctions.isStatementTruth(game, whoseTurnId);} catch (e) {
      //Logger().d('isStatementTruth $e');
    }
    try {
      playersVotedLie = GameDataFunctions.playersVotedLie(game, whoseTurnId)
        .map((id) => GameDataFunctions.playerFromId(id, players))
        .toList();} catch (e) {
      //Logger().d('playersVotedLie $e');
    }
    try {playersVotedTruth =
        GameDataFunctions.playersVotedTruth(game, whoseTurnId)
            .map((id) => GameDataFunctions.playerFromId(id, players))
            .toList();} catch (e) {
      //Logger().d('playersVotedTruth $e');
    }
    try {isRevealed = game.subPhase == 1 ||
        game.playerOrder.indexOf(whoseTurnId) < game.progress;} catch (e) {
      //Logger().d('isRevealed $e');
    }
  

    return RevealViewModel._(
        playerWhoseTurn:playerWhoseTurn ?? PlayerWithAvatar(Player(), null),
        playerWhoseTurnStatement:playerWhoseTurnStatement ?? '',
        isStatementTruth:isStatementTruth ?? false,
        playersVotedLie: playersVotedLie ?? [],
        playersVotedTruth:playersVotedTruth ?? [],
        isRevealed: isRevealed ?? false,
        isMyTurn: userId == whoseTurnId,
        );
  }

  factory RevealViewModel._(
      {required PlayerWithAvatar playerWhoseTurn,
      required String playerWhoseTurnStatement,
      required bool isStatementTruth,
      required List<PlayerWithAvatar> playersVotedLie,
      required List<PlayerWithAvatar> playersVotedTruth,
      required bool isRevealed,
      required bool isMyTurn,
      }) = _RevealViewModel;
}
