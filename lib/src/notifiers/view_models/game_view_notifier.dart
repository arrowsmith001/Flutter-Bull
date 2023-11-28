import 'dart:async';

import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/view_models/2_main/game_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameViewNotifier extends _$GameViewNotifier {
  @override
  Stream<GameViewModel> build(String roomId, String userId) async* {
    final game = ref.watch(gameNotifierProvider(roomId));

    if (game is AsyncData) {
      yield _buildViewModel(game.requireValue.gameRoom!, userId);
    }
  }

  GameViewModel _buildViewModel(GameRoom game, String userId) {
    
    final phase = game.phase;
    final playerState = game.playerStates[userId];

    String? arg;

    if (phase == GamePhase.round) {
      final whoseTurn = game.playerOrder[game.progress];
      arg = whoseTurn;
    }

    return GameViewModel(
        path: GamePath(phase: phase!, arg: arg), playerState: playerState);
  }
}

class GamePath {
  final GamePhase phase;
  final String? arg;

  GamePath({required this.phase, required this.arg});

  String get getPathString => arg == null ? phase.name : '${phase.name}/$arg';

  
}
