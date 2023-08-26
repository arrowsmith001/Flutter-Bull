import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_result.freezed.dart';
part 'game_result.g.dart';

@freezed
class GameResult extends Entity with _$GameResult {

  factory GameResult({
    String? id,
    required int timeCreatedUTC,
    required List<PlayerResult> rankedPlayerResults 
  }) = _GameResult;

  
  factory GameResult.fromJson(Map<String, Object?> json) => _$GameResultFromJson(json);
}

@freezed
class PlayerResult with _$PlayerResult {

  factory PlayerResult({

    required List<PlayerRoundResult> roundResults 
  }) = _PlayerResult;

  
  factory PlayerResult.fromJson(Map<String, Object?> json) => _$PlayerResultFromJson(json);
}

@freezed
class PlayerRoundResult with _$PlayerRoundResult {

  factory PlayerRoundResult({
    @Default(0) int score
  }) = _PlayerRoundResult;

  
  factory PlayerRoundResult.fromJson(Map<String, Object?> json) => _$PlayerRoundResultFromJson(json);
}