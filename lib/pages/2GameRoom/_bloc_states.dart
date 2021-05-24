import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';

class GameRoomState {
  const GameRoomState(this.model);
  final GameRoomModel model;
}

class InitialState extends GameRoomState {
  const InitialState(GameRoomModel model) : super(model);
}

class RoomChangeState extends GameRoomState {
  const RoomChangeState(GameRoomModel model) : super(model);
}

class RoomPlayerAddedState extends GameRoomState {
  const RoomPlayerAddedState(GameRoomModel model, this.index, this.userId) : super(model);
  final int index;
  final String userId;
}

class RoomPlayerRemovedState extends GameRoomState {
  const RoomPlayerRemovedState(GameRoomModel model, this.index, this.userId) : super(model);
  final int index;
  final String userId;
}

class NewRoomState extends GameRoomState {
  const NewRoomState(GameRoomModel model) : super(model);
}
