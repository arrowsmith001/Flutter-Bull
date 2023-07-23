import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_room.g.dart';

@JsonSerializable()
class GameRoom extends Entity {
  //GameRoom(super.id, this.roomCode);//, this.state);

  GameRoom(super.id, this.roomCode, this.phase, this.phaseArgs, {this.playerIds = const []}) {
   // state = GameRoomState(GameRoomStatePhase.lobby);
  }

  final String roomCode;
  final List<String> playerIds;

  final GameRoomStatePhase phase;
  final Object? phaseArgs;

  @override
  Map<String, dynamic> toJson() => _$GameRoomToJson(this);

  factory GameRoom.fromJson(Map<String, dynamic> map) =>
      _$GameRoomFromJson(map);

  @override
  Entity clone() {
    // TODO: implement clone
    throw UnimplementedError();
  }

  @override
  Entity cloneWithId(String newId) {
    // TODO: implement cloneWithId
    throw UnimplementedError();
  }

  @override
  GameRoom cloneWithUpdates(Map<String, dynamic> map) {
    return GameRoom.fromJson(
        toJson()..updateAll((key, value) => map[key] ?? value));
  }
}
