import 'dart:async';

import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/3_game/4_result_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'result_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class ResultViewNotifier extends _$ResultViewNotifier {
  @override
  Stream<ResultViewModel> build(
      String roomId, String userId) async* {
        
    final gameAsync = ref.watch(gameNotifierProvider(roomId));

    if (gameAsync is AsyncData) {
      final game = gameAsync.requireValue;
      yield _buildViewModel(game.gameRoom,
          game.players, userId);
    }
  }

  ResultViewModel _buildViewModel(GameRoom game, List<PlayerWithAvatar> players,
      String userId) {
    return ResultViewModel(
        game: game, players: players, userId: userId);
  }
}
