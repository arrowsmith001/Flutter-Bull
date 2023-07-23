import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'game_room_state.g.dart';

@JsonSerializable()
@immutable
class GameRoomState {

  final GameRoomStatePhase phase;
  final Object? args;

  GameRoomState(this.phase, {this.args});
  
  Map<String, dynamic> toJson() => _$GameRoomStateToJson(this);

  factory GameRoomState.fromJson(Map<String, dynamic> map) =>
      _$GameRoomStateFromJson(map);
}

enum GameRoomStatePhase { lobby, writing, selecting, reading, results }
