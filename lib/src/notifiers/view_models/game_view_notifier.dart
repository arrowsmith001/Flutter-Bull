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
  Stream<GameViewModel> build(String roomId) async* {
    final game = ref.watch(gameNotifierProvider(roomId));
    
    if (game is AsyncData) {
      yield _buildViewModel(game.requireValue.gameRoom);
    }
  }


  GameViewModel _buildViewModel(GameRoom game) {
    final phase = game.phase;
    String path = phase.name;
    if (phase == GamePhase.round) {
      final whoseTurn = game.playerOrder[game.progress];
      path += '/$whoseTurn';
    }
    
    return GameViewModel(path: path);
  }
}
