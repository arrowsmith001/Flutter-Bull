// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRoomState _$GameRoomStateFromJson(Map<String, dynamic> json) =>
    GameRoomState(
      $enumDecode(_$GameRoomStatePhaseEnumMap, json['phase']),
      args: json['args'],
    );

Map<String, dynamic> _$GameRoomStateToJson(GameRoomState instance) =>
    <String, dynamic>{
      'phase': _$GameRoomStatePhaseEnumMap[instance.phase]!,
      'args': instance.args,
    };

const _$GameRoomStatePhaseEnumMap = {
  GameRoomStatePhase.lobby: 0,
  GameRoomStatePhase.writing: 1,
  GameRoomStatePhase.selecting: 2,
  GameRoomStatePhase.reading: 3,
  GameRoomStatePhase.results: 4,
};
