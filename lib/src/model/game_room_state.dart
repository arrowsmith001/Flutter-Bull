import 'package:flutter_bull/src/enums/game_room_state_phase.dart';
import 'package:json_annotation/json_annotation.dart';
part 'game_room_state.g.dart';

@JsonSerializable()
class GameRoomState {

  final GameRoomStatePhase phase;
  final Object? args;

  GameRoomState(this.phase, {this.args});
  
  Map<String, dynamic> toJson() => _$GameRoomStateToJson(this);

  factory GameRoomState.fromJson(Map<String, dynamic> map) =>
      _$GameRoomStateFromJson(map);
}
