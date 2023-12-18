import 'dart:math';

import 'package:flutter_bull/src/mixins/voting_phase_view_model.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/voting_player.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/providers/game_data.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'round_data.g.dart';

@Riverpod(keepAlive: true)
String? getWhoseTurnId(Ref ref) {
  final GameRoom? game = ref.watch(getGameProvider);
  final int progress = ref.watch(getProgressProvider);
  return game?.playerOrder[progress];
}

@Riverpod()
PublicPlayer? getPlayerWhoseTurn(Ref ref) {
  return getWhoseTurnId(ref) == null ? null : getPlayers(ref)?[getWhoseTurnId(ref)];
}

@Riverpod(keepAlive: true)
String? getPlayerWhoseTurnStatement(Ref ref) {
  final GameRoom? game = ref.watch(getGameProvider);
  final String? whoseTurnId = ref.watch(getWhoseTurnIdProvider);
  if(game == null || whoseTurnId == null) return null;
  return game.texts[whoseTurnId];
}

@Riverpod(keepAlive: true)
bool getIsUserReading(Ref ref) {
  final String? userId = ref.watch(getSignedInPlayerIdProvider);
  return userId == getWhoseTurnId(ref);
}

@Riverpod(keepAlive: true)
bool? getHasPlayerVoted(Ref ref, String? id) {
  final String? whoseTurnId = ref.watch(getWhoseTurnIdProvider);
  final GameRoom? game = ref.watch(getGameProvider);
  if (id == null || whoseTurnId == null || game == null) return null;
  final int progress = game.playerOrder.indexOf(whoseTurnId);
  final String vote = game.votes[id]![progress];
  return vote != '-';
}

@Riverpod(keepAlive: true)
bool? getHasUserVoted(Ref ref) {
  final String userId = ref.watch(getSignedInPlayerIdProvider);
  return ref.watch(getHasPlayerVotedProvider(userId));
}

@Riverpod(keepAlive: true)
int? getNumberOfPlayersVoted(Ref ref) {
  final String? whoseTurnId = ref.watch(getWhoseTurnIdProvider);
  final GameRoom? game = ref.watch(getGameProvider);
  if (whoseTurnId == null || game == null) return null;
  return GameDataFunctions.playersVoted(game, whoseTurnId);
}

@Riverpod(keepAlive: true)
int? getNumberOfPlayersVoting(Ref ref) {
  final int? numberOfPlayers = ref.watch(getNumberOfPlayersProvider);
  final int? numberOfPlayersVoted = ref.watch(getNumberOfPlayersVotedProvider);
  if (numberOfPlayers == null || numberOfPlayersVoted == null) return null;
  return numberOfPlayers - numberOfPlayersVoted;
}

@Riverpod(keepAlive: true)
List<String> getEligibleVoterIds(Ref ref) {
  final String? whoseTurnId = ref.watch(getWhoseTurnIdProvider);
  final List<String>? pseudoShuffledIds = ref.watch(getPseudoShuffledIdsProvider);
  if (whoseTurnId == null || pseudoShuffledIds == null) return [];
  return pseudoShuffledIds.where((id) => id != whoseTurnId).toList();
}

@Riverpod(keepAlive: true)
Map<String, VotingPlayer> getVotingPlayers(Ref ref) {

  final GameRoom? game = ref.watch(getGameProvider);
  final Map<String, PublicPlayer>? players = ref.watch(getPlayersProvider);
  final String? whoseTurnId = ref.watch(getWhoseTurnIdProvider);
  final int? timeRemaining = ref.watch(getRoundTimeRemainingSecondsProvider);
  final List<String> eligibleVoterIds = ref.watch(getEligibleVoterIdsProvider) ?? [];

  if (game == null || players == null || whoseTurnId == null) return {};

  return Map.fromEntries(players
      .entries
      .where((p) => eligibleVoterIds.contains(p.key)))
      .map((k, v) {

        final bool isReader = v.player.id == whoseTurnId;

        final bool hasVoted = ref.watch(getHasPlayerVotedProvider(k)) ?? false;
        final bool failedToVote = !hasVoted && (timeRemaining == 0);

        late final VoteStatus status;
        if (isReader) {
          status = VoteStatus.cantVote;
        } else if (failedToVote) {
          status = VoteStatus.failedToVote;
        } else if (hasVoted) {
          status = VoteStatus.hasVoted;
        } else {
          status = VoteStatus.notVoted;
        }

        return MapEntry(k, VotingPlayer(player: v, voteStatus: status));
      });
}

@Riverpod(keepAlive: true)
RoundStatus? getRoundStatus(Ref ref) {
  
  final int? numberOfPlayersVoted = ref.watch(getNumberOfPlayersVotedProvider);
  final int? numberOfPlayersVoting =  ref.watch(getNumberOfPlayersProvider);
  final int? timeRemaining = ref.watch(getRoundTimeRemainingSecondsProvider);

  if([numberOfPlayersVoted, numberOfPlayersVoting, timeRemaining].any((e) => e == null)) 
  {
    return null;
  }

  final bool hasEveryoneVoted = numberOfPlayersVoted == numberOfPlayersVoting;
  final bool hasTimeRunOut = timeRemaining == 0;

  if (!hasEveryoneVoted && !hasTimeRunOut) {
    return RoundStatus.inProgress;
  } else {
    if (hasEveryoneVoted) {
      return RoundStatus.endedDueToVotes;
    } else {
      return RoundStatus.endedDueToTime;
    }
  }
}


@Riverpod(keepAlive: true)
VoteOptionsState? getVoteOptionsState(Ref ref) {

  final String? whoseTurnId = ref.watch(getWhoseTurnIdProvider);
  final bool? hasVoted = ref.watch(getHasUserVotedProvider);
  final RoundStatus? roundStatus = ref.watch(getRoundStatusProvider);

  if(whoseTurnId == null || hasVoted == null || roundStatus == null) return null;

  final bool isReading = ref.watch(getIsUserReadingProvider);
  final bool? isTruth = ref.watch(isPlayerTruthOrLieProvider(whoseTurnId));
  final int elapsed = ref.watch(getRoundTimeRemainingSecondsProvider) ?? 0;

  if(isTruth == null) return null;

  if (isReading) {
    if (!isTruth && elapsed < 30) {
      return VoteOptionsState.readerCanSwitchToTruth;
    } else {
      if (roundStatus == RoundStatus.inProgress) {
        return VoteOptionsState.readerAwaitingVoters;
      } else {
        return VoteOptionsState.readerRoundEnd;
      }
    }
  } else {
    if (roundStatus == RoundStatus.inProgress) {
      if (hasVoted) {
        return VoteOptionsState.voterCannotVote;
      } else {
        return VoteOptionsState.voterCanVote;
      }
    } else {
      return VoteOptionsState.voterRoundEnd;
    }
  }
}

@Riverpod(keepAlive: true)
int? getRoundTimeRemainingSeconds(Ref ref) {
  final int? roundEndUTC =
      ref.watch(getGameProvider.select((g) => g?.roundEndUTC));
  if (roundEndUTC == null) return null;
  final int secondsRemaining =
      roundEndUTC - DateTime.now().millisecondsSinceEpoch;
  return max(0, secondsRemaining);
}

@Riverpod(keepAlive: true)
int? getRoundTimeElapsedSeconds(Ref ref) {
  final int? timeRemaining = ref.watch(getRoundTimeRemainingSecondsProvider);
  if (timeRemaining == null) return null;
  final int secondsTotal =
      ref.watch(getGameProvider.select((g) => g?.settings.roundTimeSeconds)) ?? 0;
  final int secondsElapsed = secondsTotal - timeRemaining;
  return min(secondsTotal, secondsElapsed);
}

enum VoteOptionsState {
  voterCanVote,
  voterCannotVote,
  voterRoundEnd,
  readerCanSwitchToTruth,
  readerAwaitingVoters,
  readerRoundEnd
}
