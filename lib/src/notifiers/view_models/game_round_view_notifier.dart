import 'dart:async';

import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_round_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameRoundViewNotifier extends _$GameRoundViewNotifier {

  @override
  Stream<GameRoundViewModel> build(
      String userId, String roomId, String whoseTurnId) async* {
    final game = ref.watch(gameNotifierProvider(roomId));

    if (game is AsyncData) 
    {
      yield* _buildViewModel(userId, game.requireValue.gameRoom, game.requireValue.players, whoseTurnId);
    }
  }

  Stream<GameRoundViewModel> _buildViewModel(
      String userId, GameRoom game, Map<String, PublicPlayer> players, String whoseTurnId) async* {

    final roundPhase = RoundPhase.values[game.subPhase]; // TODO: Check index, check phase is round phase

    if (_isStrictIncrease(roundPhase)) {
      yield GameRoundViewModel(
          game: game,
          players: players,
          roundPhase: roundPhase,
          userId: userId,
          whoseTurnId: whoseTurnId);
    }
  }


  bool _isStrictIncrease(RoundPhase roundPhase) =>
      (state.valueOrNull?.roundPhase.index ?? -1) < roundPhase.index;
}


