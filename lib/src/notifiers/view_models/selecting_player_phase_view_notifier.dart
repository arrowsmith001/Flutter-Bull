import 'dart:async';

import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/timer_notifier.dart';
import 'package:flutter_bull/src/view_models/4_game_round/2_selecting_player_phase_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'selecting_player_phase_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class SelectingPlayerPhaseViewNotifier extends _$SelectingPlayerPhaseViewNotifier {

  @override
  Stream<SelectingPlayerPhaseViewModel> build(
      String roomId, String userId, String whoseTurnId) async* {
        
    final gameAsync = ref.watch(gameNotifierProvider(roomId));

    if (gameAsync is AsyncData) {
      final game = gameAsync.requireValue;
      yield _buildViewModel(game.gameRoom, game.players, userId, whoseTurnId);
    }
  }

  SelectingPlayerPhaseViewModel _buildViewModel(GameRoom game,
      List<PlayerWithAvatar> players, String userId, String whoseTurnId)  {
    
    return SelectingPlayerPhaseViewModel(game: game, players: players, userId: userId, whoseTurnId: whoseTurnId);
  }
}
