
import 'dart:math';

import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/game_data_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '2_game_round_view_model.freezed.dart';

enum PlayerRole { reading, voting, saboteur }

@freezed
class GameRoundViewModel with _$GameRoundViewModel {
  factory GameRoundViewModel(
      {
        required RoundPhase roundPhase,
      required GameRoom game,
      required List<PlayerWithAvatar> players,
      required String userId,
      required String whoseTurnId}) {
    final isMyTurn = userId == whoseTurnId;
    final isSaboteur = GameDataFunctions.isSaboteur(game, userId, whoseTurnId);
    final role = isMyTurn
        ? PlayerRole.reading
        : isSaboteur
            ? PlayerRole.saboteur
            : PlayerRole.voting;

    // Shuffle playerIds
    final List<String> pseudoShuffledIds =
        GameDataFunctions.getShuffledIds(game);

    final int whoseTurnIndex = pseudoShuffledIds.indexOf(whoseTurnId);

    return GameRoundViewModel._(
        roundPhase : roundPhase,
        pseudoShuffledPlayerIds: pseudoShuffledIds,
        whoseTurnIndex: whoseTurnIndex,
        players: players,
        playerWhoseTurnStatement:
            GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId),
        roleDescriptionString: getRoleDescriptionString(role),
        isMyTurn: userId == whoseTurnId,
        isSaboteur: isSaboteur);
  }

  const factory GameRoundViewModel._({
        required RoundPhase roundPhase,
    required List<String> pseudoShuffledPlayerIds,
    required List<PlayerWithAvatar> players,
    required String playerWhoseTurnStatement,
    required String roleDescriptionString,
    required bool isMyTurn,
    required bool isSaboteur,
    required int whoseTurnIndex,
  }) = _GameRoundViewModel;

  static String getRoleDescriptionString(PlayerRole role) {
    switch (role) {
      case PlayerRole.reading:
        return 'Reading role';
      case PlayerRole.voting:
        return 'Voting role';
      case PlayerRole.saboteur:
        return 'Saboteur role';
    }
  }
}
