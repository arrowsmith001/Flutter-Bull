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
  GameRoomStatePhase.lobby: 'lobby',
  GameRoomStatePhase.writing: 'writing',
  GameRoomStatePhase.selecting: 'selecting',
  GameRoomStatePhase.reading: 'reading',
  GameRoomStatePhase.results: 'results',
};
