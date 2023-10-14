import 'dart:async';

import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/timer_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/voting_player.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voting_phase_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class VotingPhaseViewNotifier extends _$VotingPhaseViewNotifier {
  @override
  Stream<VotingPhaseViewModel> build(
      String roomId, String userId, String whoseTurnId) async* {
    final gameAsync = ref.watch(gameNotifierProvider(roomId));

    if (gameAsync is AsyncData) {
      final game = gameAsync.requireValue;

      yield _buildViewModel(game.gameRoom, game.players, userId, whoseTurnId);
    }
  }

  VotingPhaseViewModel _buildViewModel(GameRoom game,
      Map<String, PublicPlayer> players, String userId, String whoseTurnId) {
    final RoundStatus? lastStatus = state.valueOrNull?.roundStatus;
    final bool readTimer =
        lastStatus == null || lastStatus == RoundStatus.inProgress;

    Duration? timeRemaining;
    final timerAsync = ref.watch(timerNotifierProvider(game.roundEndUTC));
    if (readTimer) {
      timeRemaining = timerAsync.valueOrNull?.timeRemaining;
    } else {
      timeRemaining = Duration.zero;
    }

    final int progress = game.playerOrder.indexOf(whoseTurnId);

    final Map<String, VotingPlayer> votingPlayers = players.map((k, v) {
      final bool isReader = v.player.id == whoseTurnId;

      final String vote = game.votes[k]?[progress] ?? '-';
      final bool hasVoted = vote != '-';
      final bool failedToVote = !hasVoted && (timeRemaining == Duration.zero);

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

    final int numberOfPlayersVoted =
        GameDataFunctions.playersVoted(game, whoseTurnId);
    final int numberOfPlayersVoting = game.playerOrder.length - 1;

    final bool hasEveryoneVoted = numberOfPlayersVoted == numberOfPlayersVoting;
    final bool hasTimeRunOut = timeRemaining == Duration.zero;

    late RoundStatus roundStatus;

    if (!hasEveryoneVoted && !hasTimeRunOut) {
      roundStatus = RoundStatus.inProgress;
    } else {
      if (lastStatus == RoundStatus.inProgress) {
        if (hasEveryoneVoted) {
          roundStatus = RoundStatus.endedDueToVotes;
        } else {
          // time ran out
          roundStatus = RoundStatus.endedDueToTime;
        }
      } else {
        roundStatus = RoundStatus.notInProgress;
      }
    }

    return VotingPhaseViewModel(
        game: game,
        players: votingPlayers,
        userId: userId,
        whoseTurnId: whoseTurnId,
        roundStatus: roundStatus,
        timeRemaining: timeRemaining);
  }
}
