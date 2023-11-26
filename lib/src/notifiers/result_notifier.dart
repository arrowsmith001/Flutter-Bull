import 'dart:async';

import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/result_notifier_state_0.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'result_notifier.g.dart';

@Riverpod(keepAlive: true)
class ResultNotifier extends _$ResultNotifier {

  DataService get _db => ref.read(dataServiceProvider);

  //String? get roomId => state.value!..id;

  @override
  Stream<ResultNotifierState0> build(String roomId) async* {
    final gameAsync = ref.watch(gameNotifierProvider(roomId));

    if (gameAsync is AsyncData) {
      final game = gameAsync.requireValue;
      yield await _buildState(game.gameRoom!);
    }
  }

  // TODO: Use?
  bool isResultPossible(GameRoom game) {
    final bool sufficientVotes = game.votes.entries
        .every((entry) => entry.value.every((vote) => vote != '-'));

    return sufficientVotes;
  }

  // Given room, build result
  Future<ResultNotifierState0> _buildState(GameRoom game) async {
    final Map<String, Achievement> achievements =
        await _db.getAllAchievements();
        
    return ResultNotifierState0(game: game, achievements: achievements);
  }
}
