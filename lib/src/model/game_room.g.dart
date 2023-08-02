// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameRoom _$$_GameRoomFromJson(Map<String, dynamic> json) => _$_GameRoom(
      id: json['id'] as String?,
      roomCode: json['roomCode'] as String,
      phase: $enumDecodeNullable(_$GameRoomPhaseEnumMap, json['phase']) ??
          GameRoomPhase.lobby,
      playerIds: (json['playerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      targets: (json['targets'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      texts: (json['texts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      playerOrder: (json['playerOrder'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
      progress: json['progress'] as int? ?? 0,
    );

Map<String, dynamic> _$$_GameRoomToJson(_$_GameRoom instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomCode': instance.roomCode,
      'phase': _$GameRoomPhaseEnumMap[instance.phase],
      'playerIds': instance.playerIds,
      'targets': instance.targets,
      'texts': instance.texts,
      'playerOrder': instance.playerOrder,
      'progress': instance.progress,
    };

const _$GameRoomPhaseEnumMap = {
  GameRoomPhase.lobby: 0,
  GameRoomPhase.writing: 1,
  GameRoomPhase.selecting: 2,
  GameRoomPhase.reading: 3,
  GameRoomPhase.reveals: 4,
  GameRoomPhase.results: 5,
};
