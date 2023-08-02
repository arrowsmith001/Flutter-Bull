// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameRoomState _$GameRoomStateFromJson(Map<String, dynamic> json) =>
    GameRoomState(
      $enumDecode(_$GameRoomPhaseEnumMap, json['phase']),
      args: json['args'],
    );

Map<String, dynamic> _$GameRoomStateToJson(GameRoomState instance) =>
    <String, dynamic>{
      'phase': _$GameRoomPhaseEnumMap[instance.phase]!,
      'args': instance.args,
    };

const _$GameRoomPhaseEnumMap = {
  GameRoomPhase.lobby: 0,
  GameRoomPhase.writing: 1,
  GameRoomPhase.selecting: 2,
  GameRoomPhase.reading: 3,
  GameRoomPhase.reveals: 4,
  GameRoomPhase.results: 5,
};
