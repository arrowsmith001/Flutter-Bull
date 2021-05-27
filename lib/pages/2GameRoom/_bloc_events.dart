import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc_states.dart';

class GameRoomEvent {}


class PrivateGameRoomEvent extends GameRoomEvent {}

class FirebaseStateEvent extends GameRoomEvent{
  FirebaseStateEvent(this.state);
  FirebaseState state;
}


// Players

class OnUserIdStreamEvent extends PrivateGameRoomEvent {
  OnUserIdStreamEvent(this.userId);
  String? userId;
}
class OnPlayerStreamEvent extends PrivateGameRoomEvent {
  OnPlayerStreamEvent(this.userId, this.player);
  String userId;
  Player? player;
}
class OnPlayerChangeStreamEvent extends PrivateGameRoomEvent {
  OnPlayerChangeStreamEvent(this.userId, this.changes);
  String userId;
  Map changes;
}


// Rooms

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


// Game

class StartGameRequestedEvent extends GameRoomEvent {}

class TextEntrySubmittedEvent extends GameRoomEvent {
  TextEntrySubmittedEvent(this.text, this.targetId);
  String text;
  String targetId;
}

class VoteEvent extends GameRoomEvent{
  VoteEvent(this.votedTrue, this.t);
  bool? votedTrue;
  int t;
}

class NextTurnRequestedEvent extends GameRoomEvent{}

class SetPageOrTurnEvent extends GameRoomEvent{
  SetPageOrTurnEvent({this.page, this.turn});
  String? page;
  int? turn;
}


