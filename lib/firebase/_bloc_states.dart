
import 'package:flutter_bull/classes/firebase.dart';

import '_bloc.dart';

// class FirebaseStates {
//
//   static FirebaseState firebaseState(FirebaseModel model) => new FirebaseState(model);
//   static InitialState initialState(FirebaseModel model) => new InitialState(model);
//
//   static UserLoggedOutState userLoggedOutState(FirebaseModel model) => new UserLoggedOutState(model);
//   static UserLoggedInState userLoggedInState(FirebaseModel model) => new UserLoggedInState(model);
//
//   static OnUserStreamState onUserStreamState(String userId, FirebaseModel model) => new OnUserStreamState(userId, model);
//   static OnPlayerStreamState onPlayerStreamState(String userId, FirebaseModel model)  => new OnPlayerStreamState(userId, model);
//   static ProfileImageUpdatedState profileImageUpdatedState(String userId, FirebaseModel model)  => new ProfileImageUpdatedState(userId, model);
// }

class FirebaseState {
  const FirebaseState(this.model);
  final DataModel model;
}

class InitialState extends FirebaseState {
  const InitialState(DataModel model) : super(model);
}


// Auth

class UserLoggedOutState extends FirebaseState {
  const UserLoggedOutState(DataModel model) : super(model);
}

class UserLoggedInState extends FirebaseState {
  const UserLoggedInState(DataModel model) : super(model);
}


// Players

class OnUserStreamState extends FirebaseState {
  const OnUserStreamState(this.userId, DataModel model) : super(model);
  final String userId;
}

class OnPlayerStreamState extends FirebaseState {
  const OnPlayerStreamState(this.userId, DataModel model) : super(model);
  final String userId;
}

class ProfileImageUpdatedState extends FirebaseState {
  const ProfileImageUpdatedState(this.userId, DataModel model) : super(model);
  final String userId;
}

class NameChangedState extends FirebaseState {
  const NameChangedState(this.userId, this.newName, DataModel model) : super(model);
  final String userId;
  final String newName;
}

class PrivacyPolicyStringRetrievedState extends FirebaseState {
  const PrivacyPolicyStringRetrievedState(this.privacyPolicy, DataModel model) : super(model);
  final String privacyPolicy;
}


// Game creation/joining
class GameCreatedState extends FirebaseState {
  const GameCreatedState(this.roomCode, DataModel model) : super(model);
  final String? roomCode;
}

class GameJoinedState extends FirebaseState {
  const GameJoinedState(this.success, DataModel model) : super(model);
  final bool success;
}

class GameLeftState extends FirebaseState {
  const GameLeftState(this.success, DataModel model) : super(model);
  final bool success;
}




// Room
class RoomChangeState extends FirebaseState {
  const RoomChangeState(DataModel model) : super(model);
}

class RoomPlayerAddedState extends FirebaseState {
  const RoomPlayerAddedState(DataModel model, this.index, this.userId) : super(model);
  final int index;
  final String userId;
}

class RoomPlayerRemovedState extends FirebaseState {
  const RoomPlayerRemovedState(DataModel model, this.index, this.userId) : super(model);
  final int index;
  final String userId;
}

class NewRoomState extends FirebaseState {
  const NewRoomState(DataModel model) : super(model);
}

class RoomPageChangedState extends FirebaseState {
  const RoomPageChangedState(DataModel model, this.newPage) : super(model);
  final String newPage;
}


// Game

class TextEntryOutcomeState extends FirebaseState {
  const TextEntryOutcomeState(this.success, DataModel model) : super(model);
  final bool success;
}

class PlayerPhasesChangeState extends FirebaseState {
  const PlayerPhasesChangeState(this.changes, DataModel model) : super(model);
  final Map<String, String> changes;
}

class PlayerVotesChangeState extends FirebaseState {
  const PlayerVotesChangeState(this.changes, DataModel model) : super(model);
  final Map<String, List<Vote>> changes;
}

class AllPlayersAtSamePhaseState extends FirebaseState {
  const AllPlayersAtSamePhaseState(this.phase, DataModel model) : super(model);
  final String phase;
}

class NewVoteState extends FirebaseState {
  const NewVoteState(this.voterId, this.vote, DataModel model) : super(model);
  final Vote vote;
  final String voterId;
}

class NewRevealedNumberState extends FirebaseState {
  const NewRevealedNumberState(this.newRevealedNumber, DataModel model) : super(model);
  final int newRevealedNumber;
}

class NewTurnNumberState extends FirebaseState {
  const NewTurnNumberState(this.newTurn, DataModel model) : super(model);
  final int newTurn;
}

