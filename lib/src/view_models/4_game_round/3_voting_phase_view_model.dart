import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part '3_voting_phase_view_model.freezed.dart';

@freezed
class VotingPhaseViewModel with _$VotingPhaseViewModel {
  factory VotingPhaseViewModel(
      {required GameRoom game,
      required Map<String, PlayerWithAvatar> players,
      required String userId,
      required String whoseTurnId,
      required Duration? timeRemaining}) {
        
    final int progress = game.playerOrder.indexOf(whoseTurnId);

    final List<String> pseudoShuffledIds =
        GameDataFunctions.getShuffledIds(game);

    final List<String> eligibleVoterIds =
        pseudoShuffledIds.where((id) => id != whoseTurnId).toList();

    final Map<String, bool> eligibleVoterStatus = Map.fromEntries(
        eligibleVoterIds
            .map((id) => MapEntry(id, game.votes[id]![progress] != '-')));

    final List<String> playerVotedIds = eligibleVoterIds
        .where((id) => eligibleVoterStatus[id] ?? false)
        .toList();

    playerVotedIds.sort((id1, id2) {
      final int time1 = game.voteTimes[id1]![progress];
      final int time2 = game.voteTimes[id2]![progress];
      return time1.compareTo(time2);
    });

    final List<String> playerNotVotedIds =
        eligibleVoterIds.where((id) => !playerVotedIds.contains(id)).toList();

    final String? vote = game.votes[userId]![progress];
    final bool hasVoted = vote != '-';

    final playerWhoseTurn = GameDataFunctions.playerWhoseTurn(players, whoseTurnId);

    return VotingPhaseViewModel._(
        playerWhoseTurn: playerWhoseTurn,
        playersWhoseTurnStatement:
            GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId),
        playersVotedIds: playerVotedIds,
        playersNotVotedIds: playerNotVotedIds,
        eligibleVoterIds: eligibleVoterIds,
        eligibleVoterStatus: eligibleVoterStatus,
        playerMap: players,
        timeString: generateTimeString(timeRemaining),
        timeRemaining: timeRemaining ?? Duration.zero,
        isRoundInProgress: timeRemaining != Duration.zero,
        numberOfPlayersVoted: GameDataFunctions.playersVoted(game, whoseTurnId),
        numberOfPlayersVoting: game.playerOrder.length,
        isSaboteur: false,
        waitingForPlayerText: "Waiting for ${playerWhoseTurn.player.name!}",
        hasVoted: hasVoted,
        isReading: userId == whoseTurnId);
  }

  const factory VotingPhaseViewModel._(
          {required PlayerWithAvatar playerWhoseTurn,
          required String playersWhoseTurnStatement,
          required Duration timeRemaining,
          required String timeString,
          required String waitingForPlayerText,
          required int numberOfPlayersVoted,
          required int numberOfPlayersVoting,
          required bool isRoundInProgress,
          required bool isSaboteur,
          required bool isReading,
          required bool hasVoted,
          required List<String> playersVotedIds,
          required List<String> playersNotVotedIds,
          required List<String> eligibleVoterIds,
          required Map<String, bool> eligibleVoterStatus,
          required Map<String, PlayerWithAvatar> playerMap}) =
      _VotingPhaseViewModel;

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
