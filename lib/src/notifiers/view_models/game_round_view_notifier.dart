import 'dart:async';

import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_round_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameRoundViewNotifier extends _$GameRoundViewNotifier {
  @override
  Stream<GameRoundViewModel> build(String roomId, String whoseTurnId) async* {
    final game = ref.watch(gameNotifierProvider(roomId));
    
    if (game is AsyncData) {
      yield* _buildViewModel(game.requireValue.gameRoom, whoseTurnId);
    }
  }

  Stream<GameRoundViewModel> _buildViewModel(GameRoom gameround, String whoseTurnId) async* {

    final subPhase = gameround.subPhase;
    final roundPhase = RoundPhase
        .values[subPhase]; // TODO: Check index, check phase is round phase

    // RoundPhase is a strict increase
    if((state.valueOrNull?.roundPhase.index ?? -1) < roundPhase.index)
    {
      yield GameRoundViewModel(roundPhase: roundPhase);
    }

  }
}
