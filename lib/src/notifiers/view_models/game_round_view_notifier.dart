import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'game_round_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameRoundViewNotifier extends _$GameRoundViewNotifier {
  @override
  Stream<GameRoundViewModel> build(String roomId) async* {
    final game = ref.watch(gameNotifierProvider(roomId));
    
    if (game is AsyncData) {
      yield _buildViewModel(game.requireValue.gameRoom);
    }
  }

  GameRoundViewModel _buildViewModel(GameRoom gameround) {
    final subPhase = gameround.subPhase;
    final roundPhase = RoundPhase
        .values[subPhase]; // TODO: Check index, check phase is round phase

    return GameRoundViewModel(path: roundPhase.name);
  }
}
