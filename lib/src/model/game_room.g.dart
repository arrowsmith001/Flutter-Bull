// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRoom _$GameRoomFromJson(Map<String, dynamic> json) => GameRoom(
      json['id'] as String?,
      json['roomCode'] as String,
      $enumDecode(_$GameRoomStatePhaseEnumMap, json['phase']),
      json['phaseArgs'],
      playerIds: (json['playerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GameRoomToJson(GameRoom instance) => <String, dynamic>{
      'id': instance.id,
      'roomCode': instance.roomCode,
      'playerIds': instance.playerIds,
      'phase': _$GameRoomStatePhaseEnumMap[instance.phase]!,
      'phaseArgs': instance.phaseArgs,
    };

const _$GameRoomStatePhaseEnumMap = {
  GameRoomStatePhase.lobby: 'lobby',
  GameRoomStatePhase.writing: 'writing',
  GameRoomStatePhase.selecting: 'selecting',
  GameRoomStatePhase.reading: 'reading',
  GameRoomStatePhase.results: 'results',
};
