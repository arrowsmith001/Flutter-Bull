import 'dart:math';

import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '2_game_round_view_model.freezed.dart';

enum PlayerRole { reading, voting, saboteur }

@freezed
class GameRoundViewModel with _$GameRoundViewModel {
  factory GameRoundViewModel(
      {required RoundPhase roundPhase,
      required GameRoom game,
      required Map<String, PublicPlayer> players,
      required String userId,
      required String whoseTurnId}) {

    final int progress = game.progress; // TODO: Define progress in terms of whoseTurnId?

    final PublicPlayer playerWhoseTurn =
        players[whoseTurnId]!;

    final bool isTruth = game.truths[whoseTurnId] ?? false;

    final bool isMyTurn = userId == whoseTurnId;
    final bool isSaboteur =
        GameDataFunctions.isSaboteur(game, userId, whoseTurnId);
    final PlayerRole role = isMyTurn
        ? PlayerRole.reading
        : isSaboteur
            ? PlayerRole.saboteur
            : PlayerRole.voting;

    // Shuffle playerIds
    final List<String> pseudoShuffledIds =
        GameDataFunctions.getShuffledIds(game);

    final List<String> playersLeftToPlay = pseudoShuffledIds
        .where((id) => game.progress <= game.playerOrder.indexOf(id))
        .toList();
    final int whoseTurnIndex = playersLeftToPlay.indexOf(whoseTurnId);
    
    final String statement =
        GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId);


    return GameRoundViewModel._(
        roundPhase: roundPhase,
        playersLeftToPlayIds: playersLeftToPlay,
        whoseTurnIndex: whoseTurnIndex,
        players: players,
        playerWhoseTurn: playerWhoseTurn,
        playerWhoseTurnStatement: statement,
        roleDescriptionStrings:
            getRoleDescriptionStrings(role, isTruth, playerWhoseTurn),
        isMyTurn: userId == whoseTurnId,
        isSaboteur: isSaboteur,
        timeToReadOut: GameDataFunctions.calculateTimeToReadOut(statement),
        isTruth: isTruth);
  }

  const factory GameRoundViewModel._({
    required RoundPhase roundPhase,
    required List<String> playersLeftToPlayIds,
    required Map<String, PublicPlayer> players,
    required PublicPlayer playerWhoseTurn,
    required String playerWhoseTurnStatement,
    required List<String> roleDescriptionStrings,
    required bool isMyTurn,
    required bool isSaboteur,
    required bool isTruth,
    required int whoseTurnIndex,
    required int timeToReadOut,
  }) = _GameRoundViewModel;

  static List<String> getRoleDescriptionStrings(
      PlayerRole role, bool isTruth, PublicPlayer playerWhoseTurn) {
    switch (role) {
      case PlayerRole.reading:
        return [
          'Get ready to read out your statement...',
          'You\'re about to read out a ${isTruth ? 'truth' : 'lie'}. Convince people it\'s a ${!isTruth ? 'truth' : 'lie'}!'
        ];
      case PlayerRole.voting:
        return [
          '${playerWhoseTurn.player.name} will now read out their statement.',
          'Get ready to vote!'
        ];
      case PlayerRole.saboteur:
        return [
          '${playerWhoseTurn.player.name} will now read out their statement.',
          'Try and persuade people to vote TRUE this round...'
        ];
    }
  }

  // static String getRoleIcon(PlayerRole role) {
  //   switch (role) {
  //     case PlayerRole.reading:
  //       return 'Reading role';
  //     case PlayerRole.voting:
  //       return 'Voting role';
  //     case PlayerRole.saboteur:
  //       return 'Saboteur role';
  //   }
  // }
}
