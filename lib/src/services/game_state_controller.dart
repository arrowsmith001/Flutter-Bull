

import "package:flutter_bull/src/model/game_room.dart";
import "package:state_notifier/state_notifier.dart";

abstract class GameStateController extends StateNotifier<GameState> {
  GameStateController(super.state);
}

abstract class GameState {
  GameState(this.gameRoom);

  GameRoom gameRoom;
}

enum GamePhase { lobby, writing, choosing, voting, results }
