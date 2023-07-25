import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
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
    Object? phaseArgs,
    @Default(GameRoomStatePhase.lobby) GameRoomStatePhase? phase,
    @Default([]) List<String> playerIds
  }) = _GameRoom;


  factory GameRoom.fromJson(Map<String, dynamic> map) =>
      _$GameRoomFromJson(map);
}
