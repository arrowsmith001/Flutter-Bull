import 'package:flutter_bull/classes/firebase.dart';

class GameRoomEvent {}


class PrivateGameRoomEvent extends GameRoomEvent {}

class OnUserIdStreamEvent extends PrivateGameRoomEvent {
  OnUserIdStreamEvent(this.userId);
  String? userId;
}
class OnPlayerStreamEvent extends PrivateGameRoomEvent {
  OnPlayerStreamEvent(this.userId, this.player);
  String userId;
  Player player;
}
class OnPlayerChangeStreamEvent extends PrivateGameRoomEvent {
  OnPlayerChangeStreamEvent(this.userId, this.changes);
  String userId;
  Map changes;
}

class OnRoomCodeStreamEvent extends GameRoomEvent {
  OnRoomCodeStreamEvent(this.roomCode);
  String? roomCode;
}

class OnRoomStreamEvent extends GameRoomEvent {
  OnRoomStreamEvent(this.room);
  Room? room;
}
class OnRoomChildChangesEvent extends GameRoomEvent {
  OnRoomChildChangesEvent(this.changes);
  Map changes;
}
class RoomPlayerAddedEvent extends GameRoomEvent {
  RoomPlayerAddedEvent(this.changes);
  Map changes;
}
class RoomPlayerRemovedEvent extends GameRoomEvent {
  RoomPlayerRemovedEvent(this.changes);
  Map changes;
}

class SetupEvent extends GameRoomEvent {}

