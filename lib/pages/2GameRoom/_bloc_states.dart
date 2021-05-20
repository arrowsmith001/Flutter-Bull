import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';

class GameRoomState {
  const GameRoomState(this.model);
  final GameRoomModel? model;
}

class InitialState extends GameRoomState {
  const InitialState(GameRoomModel? model) : super(model);
}

class RoomChangeState extends GameRoomState {
  const RoomChangeState(GameRoomModel? model) : super(model);
}
