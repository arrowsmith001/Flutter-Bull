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


@JsonEnum()
enum GameRoomStatePhase 
{ 
  @JsonValue(0)
  lobby, 
  @JsonValue(1)
  writing, 
  @JsonValue(2)
  selecting,
  @JsonValue(3)
   reading, 
  @JsonValue(4)
   results 
}
