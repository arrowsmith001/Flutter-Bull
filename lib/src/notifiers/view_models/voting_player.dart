import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voting_player.freezed.dart';

@freezed
class VotingPlayer with _$VotingPlayer {


  factory VotingPlayer(
      {
        required PublicPlayer player,
        required VoteStatus voteStatus
        }) = _VotingPlayer;
}

enum VoteStatus {
  cantVote, hasVoted, failedToVote, notVoted
}