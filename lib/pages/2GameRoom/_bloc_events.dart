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

class NewRoomSettingsEvent extends GameRoomEvent {
  NewRoomSettingsEvent(this.newSettings);
  Map<String, dynamic> newSettings;

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
  int? t;
}

class NextTurnRequestedFromPlayEvent extends GameRoomEvent{}
class NextTurnRequestedFromRevealsEvent extends GameRoomEvent{}

class SetPagePhaseOrTurnEvent extends GameRoomEvent{
  SetPagePhaseOrTurnEvent({this.page, this.turn, this.phase});
  String? page;
  int? turn;
  String? phase;
}


// Play

class StartRoundEvent extends GameRoomEvent {}

class AdvanceRevealNumberEvent extends GameRoomEvent {}


