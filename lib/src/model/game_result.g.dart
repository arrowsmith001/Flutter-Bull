// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameResultImpl _$$GameResultImplFromJson(Map<String, dynamic> json) =>
    _$GameResultImpl(
      id: json['id'] as String?,
      timeCreatedUTC: json['timeCreatedUTC'] as int,
      result: (json['result'] as List<dynamic>)
          .map((e) => RoundResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GameResultImplToJson(_$GameResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timeCreatedUTC': instance.timeCreatedUTC,
      'result': instance.result,
    };

_$RoundResultImpl _$$RoundResultImplFromJson(Map<String, dynamic> json) =>
    _$RoundResultImpl(
      playersToAchievements:
          (json['playersToAchievements'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$$RoundResultImplToJson(_$RoundResultImpl instance) =>
    <String, dynamic>{
      'playersToAchievements': instance.playersToAchievements,
    };
