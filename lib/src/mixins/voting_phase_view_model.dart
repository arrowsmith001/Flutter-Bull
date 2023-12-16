import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/voting_player.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/providers/round_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin VotingPhaseViewModel<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  late final String userId = ref.watch(getSignedInPlayerIdProvider);
  late final String gameId = ref.watch(getCurrentGameRoomIdProvider);

  late final PublicPlayer? playerWhoseTurn =
      ref.watch(getPlayerWhoseTurnProvider);
  late final int? timeRemaining = ref.watch(getRoundTimeRemainingSecondsProvider);
  late final int? timeElapsed = ref.watch(getRoundTimeElapsedSecondsProvider);

  late final VoteOptionsState? voteOptionsState =
      ref.watch(getVoteOptionsStateProvider);

  late final String? playersWhoseTurnStatement =
      ref.watch(getPlayerWhoseTurnStatementProvider);
  late final int? numberOfPlayersVoting =
      ref.watch(getNumberOfPlayersVotingProvider);

  late final RoundStatus? roundStatus = ref.watch(getRoundStatusProvider);
  late final Map<String, VotingPlayer> votingPlayers =
      ref.watch(getVotingPlayersProvider);

  late final bool? hasVoted = ref.watch(getHasUserVotedProvider);

  late final bool? isReading = ref.watch(getIsUserReadingProvider);
}

enum RoundStatus { inProgress, endedDueToTime, endedDueToVotes, notInProgress }

class TimeData {
  TimeData(this.timeRemaining) {
    if (timeRemaining == null) {
      minuteString = "--";
      secondString = "--";
    } else {
      final int secondsLeft = timeRemaining!.inSeconds % 60;
      final int minutesLeft = timeRemaining!.inMinutes;

      secondString = (secondsLeft.toString().length == 1)
          ? '0$secondsLeft'
          : '$secondsLeft';

      minuteString = '$minutesLeft';
    }
  }

  factory TimeData.fromSeconds(int? seconds) {
    if (seconds == null) return TimeData(null);
    return TimeData(Duration(seconds: seconds));
  }

  @override
  String toString() {
    return "$minuteString : $secondString";
  }

  final Duration? timeRemaining;
  late final String minuteString;
  late final String secondString;
}
