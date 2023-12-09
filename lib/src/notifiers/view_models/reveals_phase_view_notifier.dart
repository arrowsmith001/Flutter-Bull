import 'dart:async';

import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/view_models/3_game/3_reveals_phase_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reveals_phase_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class RevealsPhaseViewNotifier extends _$RevealsPhaseViewNotifier {
  @override
  Stream<RevealsPhaseViewModel> build(String roomId) async* {
    final revealsphase = ref.watch(gameNotifierProvider(roomId));

    if (revealsphase is AsyncData) {
      
      yield*_buildViewModel(revealsphase.requireValue.gameRoom);
    }
  }

  Stream<RevealsPhaseViewModel> _buildViewModel(GameRoom game) async* {

    final phase = game.phase;

    if (phase == GamePhase.reveals) {
      final path = game.playerOrder[game.progress];
      yield RevealsPhaseViewModel(path: path, progress: game.progress);
    }
  }
}
