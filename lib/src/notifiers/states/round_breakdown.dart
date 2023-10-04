
import 'package:flutter_bull/src/utils/result_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'round_breakdown.freezed.dart';

@freezed
class RoundBreakdown with _$RoundBreakdown {
  factory RoundBreakdown({
    required String whoseTurnId,
    required bool isTruth,
    required Map<String, Vote> votes,
    required List<String> eligibleVoters,
    required List<String> playersVotedTrue,
    required List<String> playersVotedLie,
    required List<String> playersNotVoted,
    required String? saboteurId,
    required String? saboteurVote,
    required FooledProportion fooledProportion,
  }) = _RoundBreakdown;
}
