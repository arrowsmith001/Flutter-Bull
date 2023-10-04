import 'dart:async';

import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/result_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/result_notifier_state_0.dart';
import 'package:flutter_bull/src/utils/result_generator.dart';
import 'package:flutter_bull/src/view_models/3_game/4_result_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'result_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class ResultViewNotifier extends _$ResultViewNotifier {

  @override
  Stream<ResultViewModel> build(String roomId, String userId) async* {

    final gameAsync = ref.watch(gameNotifierProvider(roomId));
    final resultAsync = ref.watch(resultNotifierProvider(roomId));

    if (gameAsync is AsyncData && resultAsync is AsyncData) {
      final game = gameAsync.requireValue;
      final result = resultAsync.requireValue;

      yield _buildViewModel(game.gameRoom, game.players, userId, result.resultGenerator);
    }
  }

  ResultViewModel _buildViewModel(GameRoom game, Map<String, PlayerWithAvatar> players, 
  String userId, ResultGenerator resultGenerator) {
        
    return ResultViewModel(
        game: game, players: players, userId: userId, rg: resultGenerator);
  }
}
