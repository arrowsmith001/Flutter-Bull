
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/game_data_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '2_selecting_player_phase_view_model.freezed.dart';

enum PlayerRole { reading, voting, saboteur }

@freezed
class SelectingPlayerPhaseViewModel with _$SelectingPlayerPhaseViewModel {
  factory SelectingPlayerPhaseViewModel(
      {
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

    return SelectingPlayerPhaseViewModel._(
        pseudoShuffledPlayerList: players, // TODO: Shuffle
        playerWhoseTurn: players.firstWhere((p) => p.player.id == whoseTurnId),
        playerWhoseTurnStatement:
            GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId),
        roleDescriptionString: getRoleDescriptionString(role),
        isMyTurn: userId == whoseTurnId,
        isSaboteur: isSaboteur);
  }

  const factory SelectingPlayerPhaseViewModel._({
    required List<PlayerWithAvatar> pseudoShuffledPlayerList,
    required PlayerWithAvatar playerWhoseTurn,
    required String playerWhoseTurnStatement,
    required String roleDescriptionString,
    required bool isMyTurn,
    required bool isSaboteur,
  }) = _VotingPhaseViewModel;

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
