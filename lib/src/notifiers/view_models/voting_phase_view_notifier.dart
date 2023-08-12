import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/timer_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'voting_phase_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class VotingPhaseViewNotifier extends _$VotingPhaseViewNotifier {
  @override
  Stream<VotingPhaseViewModel> build(
      String roomId, String userId, String whoseTurnId) async* {
    final gameAsync = ref.watch(gameNotifierProvider(roomId));

    if (gameAsync is AsyncData) {
      final game = gameAsync.requireValue;
      yield _buildViewModel(game.gameRoom, game.players, userId, whoseTurnId);
    }
  }

  VotingPhaseViewModel _buildViewModel(GameRoom game,
      List<PlayerWithAvatar> players, String userId, String whoseTurnId) {

    final int? roundEndUTC = game.roundEndUTC;
    final duration = ref.watch(timerNotifierProvider(roundEndUTC));

    return VotingPhaseViewModel(
        game: game,
        players: players,
        userId: userId,
        whoseTurnId: whoseTurnId,
        timeRemaining: duration.value?.timeRemaining);
  }
}
