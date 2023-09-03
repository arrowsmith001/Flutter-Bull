// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameResult _$$_GameResultFromJson(Map<String, dynamic> json) =>
    _$_GameResult(
      id: json['id'] as String?,
      timeCreatedUTC: json['timeCreatedUTC'] as int,
      result: (json['result'] as List<dynamic>)
          .map((e) => RoundResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GameResultToJson(_$_GameResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeCreatedUTC': instance.timeCreatedUTC,
      'result': instance.result,
    };

_$_RoundResult _$$_RoundResultFromJson(Map<String, dynamic> json) =>
    _$_RoundResult(
      playersToAchievements:
          (json['playersToAchievements'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$$_RoundResultToJson(_$_RoundResult instance) =>
    <String, dynamic>{
      'playersToAchievements': instance.playersToAchievements,
    };
