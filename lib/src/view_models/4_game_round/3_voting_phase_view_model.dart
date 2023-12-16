// import 'dart:math';

// import 'package:flutter_bull/src/model/game_room.dart';
// import 'package:flutter_bull/src/notifiers/player_notifier.dart';
// import 'package:flutter_bull/src/notifiers/view_models/voting_player.dart';
// import 'package:flutter_bull/src/providers/round_data.dart';
// import 'package:flutter_bull/src/utils/game_data_functions.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part '3_voting_phase_view_model.freezed.dart';

// @freezed
// class VotingPhaseViewModel with _$VotingPhaseViewModel {
//   factory VotingPhaseViewModel(
//       {required GameRoom game,
//       required Map<String, VotingPlayer> players,
//       required String userId,
//       required String whoseTurnId,
//       required Duration? timeRemaining,
//       required RoundStatus roundStatus}) {
//     final int progress = game.playerOrder.indexOf(whoseTurnId);
//     final bool isReading = userId == whoseTurnId;
//     final bool isTruth = game.truths[whoseTurnId]!;

//     final List<String> pseudoShuffledIds =
//         GameDataFunctions.getShuffledIds(game);

//     final List<String> eligibleVoterIds =
//         pseudoShuffledIds.where((id) => id != whoseTurnId).toList();

//     final Map<String, bool> eligibleVoterStatus = Map.fromEntries(
//         eligibleVoterIds
//             .map((id) => MapEntry(id, game.votes[id]![progress] != '-')));

//     final List<String> playerVotedIds = eligibleVoterIds
//         .where((id) => eligibleVoterStatus[id] ?? false)
//         .toList();

//     playerVotedIds.sort((id1, id2) {
//       final int time1 = game.voteTimes[id1]![progress];
//       final int time2 = game.voteTimes[id2]![progress];
//       return time1.compareTo(time2);
//     });

//     final List<String> playerNotVotedIds =
//         eligibleVoterIds.where((id) => !playerVotedIds.contains(id)).toList();

//     final String vote = game.votes[userId]![progress];
//     final bool hasVoted = vote != '-';

//     final PublicPlayer playerWhoseTurn = players[whoseTurnId]!.player;
//     final Map<String, VotingPlayer> votingPlayers = Map.fromEntries(players
//         .entries
//         .where((element) => eligibleVoterIds.contains(element.key)));

//     final int numberOfPlayersVoted =
//         GameDataFunctions.playersVoted(game, whoseTurnId);
//     final int numberOfPlayersVoting = game.playerOrder.length - 1;

//     final int? secondsElapsed = timeRemaining == null
//         ? null
//         : game.settings.roundTimeSeconds - timeRemaining.inSeconds;
//     final int? timeForReaderToSwitchToTruth =
//         secondsElapsed == null ? null : max(0, 30 - secondsElapsed);

//     VoteOptionsState? voteOptionsState;

//     if (isReading) {
//       if (!isTruth &&
//           timeForReaderToSwitchToTruth != null &&
//           timeForReaderToSwitchToTruth > 0) {
//         voteOptionsState = VoteOptionsState.readerCanSwitchToTruth;
//       } else {
//         if (roundStatus == RoundStatus.inProgress) {
//           voteOptionsState = VoteOptionsState.readerAwaitingVoters;
//         } else {
//           voteOptionsState = VoteOptionsState.readerRoundEnd;
//         }
//       }
//     } else {
//       if (roundStatus == RoundStatus.inProgress) {
//         if (hasVoted) {
//           voteOptionsState = VoteOptionsState.voterCannotVote;
//         } else {
//           voteOptionsState = VoteOptionsState.voterCanVote;
//         }
//       } else {
//         voteOptionsState = VoteOptionsState.voterRoundEnd;
//       }
//     }

//     return VotingPhaseViewModel._(
//         timeData: TimeData(timeRemaining),
//         roundStatus: roundStatus,
//         playerWhoseTurn: playerWhoseTurn,
//         votingPlayers: votingPlayers,
//         playersWhoseTurnStatement:
//             GameDataFunctions.playersWhoseTurnStatement(game, whoseTurnId),
//         playersVotedIds: playerVotedIds,
//         playersNotVotedIds: playerNotVotedIds,
//         eligibleVoterIds: eligibleVoterIds,
//         eligibleVoterStatus: eligibleVoterStatus,
//         timeForReaderToSwitchToTruth: timeForReaderToSwitchToTruth,
//         voteOptionsState: voteOptionsState,
//         isThereTimeRemaining: timeRemaining != Duration.zero,
//         hasEveryoneVoted: numberOfPlayersVoted == numberOfPlayersVoting,
//         numberOfPlayersVoted: numberOfPlayersVoted,
//         numberOfPlayersVoting: numberOfPlayersVoting,
//         isSaboteur: false,
//         waitingForPlayerText: "Waiting for ${playerWhoseTurn.player.name!}",
//         hasVoted: hasVoted,
//         isReading: isReading);
//   }

//   const factory VotingPhaseViewModel._(
//       {required PublicPlayer playerWhoseTurn,
//       required Map<String, VotingPlayer> votingPlayers,
//       required String playersWhoseTurnStatement,
//       required TimeData timeData,
//       required String waitingForPlayerText,
//       required int numberOfPlayersVoted,
//       required int numberOfPlayersVoting,
//       required bool isThereTimeRemaining,
//       required bool hasEveryoneVoted,
//       required bool isSaboteur,
//       required bool isReading,
//       required bool hasVoted,
//       required VoteOptionsState voteOptionsState,
//       required RoundStatus roundStatus,
//       required int? timeForReaderToSwitchToTruth,
//       required List<String> playersVotedIds,
//       required List<String> playersNotVotedIds,
//       required List<String> eligibleVoterIds,
//       required Map<String, bool> eligibleVoterStatus}) = _VotingPhaseViewModel;
// }

