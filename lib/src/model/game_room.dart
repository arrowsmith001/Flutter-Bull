import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:flutter_bull/src/enums/game_room_state_phase.dart';
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
    @Default(GameRoomPhase.lobby) GameRoomPhase? phase,
    @Default([]) List<String> playerIds,
    @Default({}) Map<String, String> targets,
    @Default({}) Map<String, String> texts,
    @Default([]) List<int> playerOrder,
    @Default(0) int progress,
  }) = _GameRoom;


  factory GameRoom.fromJson(Map<String, dynamic> map) =>
      _$GameRoomFromJson(map);
}
