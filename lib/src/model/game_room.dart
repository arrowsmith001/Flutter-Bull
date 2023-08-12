import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_room.freezed.dart';
part 'game_room.g.dart';


@freezed
class GameRoom extends Entity with _$GameRoom {

  factory GameRoom({
    String? id,
    required String roomCode,
    @Default(GamePhase.lobby) GamePhase phase,
    @Default(0) int subPhase,
    @Default([]) List<String> playerIds,
    @Default({}) Map<String, String> targets,
    @Default({}) Map<String, String> texts,
    @Default({}) Map<String, String> votes,
    @Default([]) List<String> playerOrder,
    @Default(0) int progress,
    int? roundEndUTC,
    @Default(GameRoomSettings(roundTimeSeconds: 60*3)) GameRoomSettings settings,
  }) = _GameRoom;


  factory GameRoom.fromJson(Map<String, dynamic> map) =>
      _$GameRoomFromJson(map);
}

@freezed
class GameRoomSettings with _$GameRoomSettings {

  const factory GameRoomSettings({
    required int roundTimeSeconds
  }) = _GameRoomSettings;


  factory GameRoomSettings.fromJson(Map<String, dynamic> map) =>
      _$GameRoomSettingsFromJson(map);
}
