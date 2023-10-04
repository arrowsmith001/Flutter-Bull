import 'package:flutter_bull/src/utils/result_generator.dart';
import 'package:flutter_bull/src/view_models/3_game/4_result_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_breakdown.freezed.dart';

@freezed
class PlayerBreakdown with _$PlayerBreakdown {
  factory PlayerBreakdown({
    required String playerId,
    required int turnNumber,
    required FooledProportion ownRoundFooledProportion,
    required int correctVotes,
    required int fastestCorrectVotes,
    required int minorityVotes,
    required String? lieTarget,
    required bool? targetsLieTurnedOutTrue,
    required int? saboteursUncovered,
    required FooledProportion? saboteurfooledProportion,
    required int roundScore,
  }) = _PlayerBreakdown;
}


