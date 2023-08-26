// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameResult _$$_GameResultFromJson(Map<String, dynamic> json) =>
    _$_GameResult(
      id: json['id'] as String?,
      timeCreatedUTC: json['timeCreatedUTC'] as int,
      rankedPlayerResults: (json['rankedPlayerResults'] as List<dynamic>)
          .map((e) => PlayerResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GameResultToJson(_$_GameResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeCreatedUTC': instance.timeCreatedUTC,
      'rankedPlayerResults': instance.rankedPlayerResults,
    };

_$_PlayerResult _$$_PlayerResultFromJson(Map<String, dynamic> json) =>
    _$_PlayerResult(
      roundResults: (json['roundResults'] as List<dynamic>)
          .map((e) => PlayerRoundResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PlayerResultToJson(_$_PlayerResult instance) =>
    <String, dynamic>{
      'roundResults': instance.roundResults,
    };

_$_PlayerRoundResult _$$_PlayerRoundResultFromJson(Map<String, dynamic> json) =>
    _$_PlayerRoundResult(
      score: json['score'] as int? ?? 0,
    );

Map<String, dynamic> _$$_PlayerRoundResultToJson(
        _$_PlayerRoundResult instance) =>
    <String, dynamic>{
      'score': instance.score,
    };
