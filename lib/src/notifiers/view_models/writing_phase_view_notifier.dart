import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/view_models/3_game/1_writing_phase_view_model.dart';
import 'package:flutter_bull/src/view_models/5_reveals_phase/reveal_view_model.dart';
import 'package:flutter_bull/src/views/5_reveals_phase/reveal_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'writing_phase_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class WritingPhaseViewNotifier extends _$WritingPhaseViewNotifier {
  
  @override
  Stream<WritingPhaseViewModel> build(
      String roomId, String userId) async* {
    final game = ref.watch(gameNotifierProvider(roomId));
    if(game is AsyncData)
    {
      yield _buildViewModel(game.requireValue.gameRoom, game.requireValue.players, userId);
    }
  }

  WritingPhaseViewModel _buildViewModel(GameRoom game, List<PlayerWithAvatar> players,
      String userId) 
      {
    return WritingPhaseViewModel(
        game: game, players: players, userId: userId);
  }
}
