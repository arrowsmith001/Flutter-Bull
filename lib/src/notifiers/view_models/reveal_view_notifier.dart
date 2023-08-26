import 'dart:async';

import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/5_reveals_phase/reveal_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reveal_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class RevealViewNotifier extends _$RevealViewNotifier {
  @override
  Stream<RevealViewModel> build(
      String roomId, String userId, String whoseTurnId) async* {
        
    final gameAsync = ref.watch(gameNotifierProvider(roomId));

    if (gameAsync is AsyncData) {
      final game = gameAsync.requireValue;
      yield _buildViewModel(game.gameRoom,
          game.players, userId, whoseTurnId);
    }
  }

  RevealViewModel _buildViewModel(GameRoom game, List<PlayerWithAvatar> players,
      String userId, String whoseTurnId) {
    return RevealViewModel(
        game: game, players: players, userId: userId, whoseTurnId: whoseTurnId);
  }
}
