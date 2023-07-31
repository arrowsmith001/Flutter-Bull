// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameRoom _$$_GameRoomFromJson(Map<String, dynamic> json) => _$_GameRoom(
      id: json['id'] as String?,
      roomCode: json['roomCode'] as String,
      phaseArgs: json['phaseArgs'],
      phase: $enumDecodeNullable(_$GameRoomStatePhaseEnumMap, json['phase']) ??
          GameRoomStatePhase.lobby,
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
    );

Map<String, dynamic> _$$_GameRoomToJson(_$_GameRoom instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomCode': instance.roomCode,
      'phaseArgs': instance.phaseArgs,
      'phase': _$GameRoomStatePhaseEnumMap[instance.phase],
      'playerIds': instance.playerIds,
      'targets': instance.targets,
      'texts': instance.texts,
    };

const _$GameRoomStatePhaseEnumMap = {
  GameRoomStatePhase.lobby: 0,
  GameRoomStatePhase.writing: 1,
  GameRoomStatePhase.selecting: 2,
  GameRoomStatePhase.reading: 3,
  GameRoomStatePhase.reveals: 4,
  GameRoomStatePhase.results: 5,
};
