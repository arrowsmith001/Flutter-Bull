import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/game_data_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '3_voting_phase_view_model.freezed.dart';

@freezed
class VotingPhaseViewModel with _$VotingPhaseViewModel {
  factory VotingPhaseViewModel(
      {required GameRoom game,
      required List<PlayerWithAvatar> players,
      required String userId,
      required String whoseTurnId,
      required Duration? timeRemaining}) {
    return VotingPhaseViewModel._(
        playerWhoseTurn:
            GameDataFunctions.playerWhoseTurn(players, whoseTurnId),
        playersWhoseTurnStatement:
            GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId),
        timeString: generateTimeString(timeRemaining),
        timeRemaining: timeRemaining ?? Duration.zero,
        isRoundInProgress: timeRemaining != Duration.zero,
        numberOfPlayersVoted: GameDataFunctions.playersVoted(game, whoseTurnId),
        numberOfPlayersVoting: game.playerOrder.length,
        isSaboteur: false,
        isReading: userId == whoseTurnId);
  }

  const factory VotingPhaseViewModel._({
    required PlayerWithAvatar playerWhoseTurn,
    required String playersWhoseTurnStatement,
    required Duration timeRemaining,
    required String timeString,
    required int numberOfPlayersVoted,
    required int numberOfPlayersVoting,
    required bool isRoundInProgress,
    required bool isSaboteur,
    required bool isReading,
  }) = _VotingPhaseViewModel;

  static String generateTimeString(Duration? timeRemaining) {
    if (timeRemaining == null) return '-- : --';

    final int secondsLeft = timeRemaining.inSeconds % 60;
    final int minutesLeft = timeRemaining.inMinutes;

    return '$minutesLeft : $secondsLeft';

/*     final int ms = millisecondsLeft - (secondsLeft * 1000);
    final int s = secondsLeft - (minutesLeft * 60);
    final int m = minutesLeft;

    final String millisecondString = ms == 0 ? '--' : ms.toString().padLeft(3 - ms.toString().length, '0');
    final String secondString = s == 0 ? '--' : s.toString().padLeft(2 - s.toString().length, '0');
    final String minuteString = m == 0 ? '--' : m.toString();

    return '$minuteString:$secondString:$millisecondString'; */
  }
}
