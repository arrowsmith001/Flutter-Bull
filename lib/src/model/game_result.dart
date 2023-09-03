import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_result.freezed.dart';
part 'game_result.g.dart';

@freezed
class GameResult extends Entity with _$GameResult {

  factory GameResult({
    String? id,
    required int timeCreatedUTC,
    required List<RoundResult> result
  }) = _GameResult;

  
  factory GameResult.fromJson(Map<String, Object?> json) => _$GameResultFromJson(json);
}

@freezed
class RoundResult with _$RoundResult {

  factory RoundResult({

    required Map<String, List<String>> playersToAchievements,
    //Map<String, int>? playersToRoundScore, // TODO: Include
  }) = _RoundResult;

  
  factory RoundResult.fromJson(Map<String, Object?> json) => _$RoundResultFromJson(json);
}

