import 'package:flutter_bull/classes/firebase.dart';
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

class RoomPageChangedState extends GameRoomState {
  const RoomPageChangedState(GameRoomModel model, this.newPage) : super(model);
  final String newPage;
}

class PlayerPhaseChangedState extends GameRoomState {
  const PlayerPhaseChangedState(GameRoomModel model, this.newPhase) : super(model);
  final String newPhase;
}

class RoomSettingsChangedState extends GameRoomState {
  const RoomSettingsChangedState(GameRoomModel model, this.newSettings) : super(model);
  final Map<String, dynamic> newSettings;
}



// Game

class StartGameRequestOutcome extends GameRoomState {
  const StartGameRequestOutcome(this.message, GameRoomModel model) : super(model);
  final String? message;
}

class TextEntrySuccessfullySubmittedState extends GameRoomState {
  const TextEntrySuccessfullySubmittedState(GameRoomModel model) : super(model);
}

class NewPlayerVotedState extends GameRoomState {
  const NewPlayerVotedState(this.voterId, this.vote, this.player, this.numberVotedSoFar, GameRoomModel model) : super(model);
  final String voterId;
  final Player? player;
  final Vote vote;
  final int numberVotedSoFar;
}

class RevealState extends GameRoomState {
  const RevealState(this.newRevealedNumber, GameRoomModel model) : super(model);
  final int newRevealedNumber;
}

class GoToNextRevealState extends GameRoomState {
  const GoToNextRevealState(GameRoomModel model) : super(model);
}

class GoToResultsState extends GameRoomState {
  const GoToResultsState(GameRoomModel model) : super(model);
}

class NewTurnState extends GameRoomState {
  const NewTurnState(this.newTurn, GameRoomModel model) : super(model);
  final int newTurn;
}

class NewPhaseState extends GameRoomState {
  const NewPhaseState(this.phase, GameRoomModel model) : super(model);
  final String phase;
}
