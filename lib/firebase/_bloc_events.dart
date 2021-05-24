
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