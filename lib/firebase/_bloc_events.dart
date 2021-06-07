
import 'dart:io';

import 'package:flutter_bull/classes/firebase.dart';

class FirebaseEvent {

}


class OnUserIdStreamEvent extends FirebaseEvent {
  OnUserIdStreamEvent(this.userId);
  String? userId;
}
class OnPlayerStreamEvent extends FirebaseEvent {
  OnPlayerStreamEvent(this.userId, this.player);
  String userId;
  Player? player;
}
class OnPlayerChangeStreamEvent extends FirebaseEvent {
  OnPlayerChangeStreamEvent(this.userId, this.changes);
  String userId;
  Map changes;
}


class ImagePicked extends FirebaseEvent {
  ImagePicked(this.file);
  File file;
}
class ChangeUsernameEvent extends FirebaseEvent {
  ChangeUsernameEvent(this.newName);
  String newName;
}
class PrivacyPolicyStringRequestedEvent extends FirebaseEvent {}

class CreateGameRequested extends FirebaseEvent {}

class JoinGameRequested extends FirebaseEvent {
  JoinGameRequested(this.roomCode);
  String roomCode;
}

class LeaveGameRequested extends FirebaseEvent {}



class OnRoomCodeStreamEvent extends FirebaseEvent {
  OnRoomCodeStreamEvent(this.roomCode);
  String? roomCode;
}

class OnRoomStreamEvent extends FirebaseEvent {
  OnRoomStreamEvent(this.room);
  Room? room;
}
class OnRoomChildChangesEvent extends FirebaseEvent {
  OnRoomChildChangesEvent(this.changes);
  Map changes;
}
class RoomPlayerAddedEvent extends FirebaseEvent {
  RoomPlayerAddedEvent(this.changes);
  Map changes;
}
class RoomPlayerRemovedEvent extends FirebaseEvent {
  RoomPlayerRemovedEvent(this.changes);
  Map changes;
}

// class RoomPlayerVoteEvent extends FirebaseEvent {
//   RoomPlayerVoteEvent(this.child);
//   Map child;
// }



class SetCurrentRoomFieldEvent extends FirebaseEvent {
  SetCurrentRoomFieldEvent(this.path, this.value);
  List<String> path;
  dynamic value;
}



class StartGameEvent extends FirebaseEvent {}

class StartRoundEvent extends FirebaseEvent {}

class PushNewVoteEvent extends FirebaseEvent {
  PushNewVoteEvent(this.voterId, this.vote);
  Vote vote;
  String voterId;
}

class TextEntrySubmittedEvent extends FirebaseEvent {
  TextEntrySubmittedEvent(this.text, this.targetId);
  String text;
  String targetId;
}


class SetPageOrTurnEvent extends FirebaseEvent{
  SetPageOrTurnEvent({this.page, this.turn});
  String? page;
  int? turn;

}

class OnVoteAddedEvent extends FirebaseEvent {
  OnVoteAddedEvent(this.roomCode, this.author, this.changes);
  String roomCode;
  String author;
  Map changes;
}

class AdvanceRevealNumberEvent extends FirebaseEvent {}

class GoToNextRevealTurnEvent extends FirebaseEvent {
  GoToNextRevealTurnEvent(this.currentTurn);
  int currentTurn;
}

class GoToResultsEvent extends FirebaseEvent {}
