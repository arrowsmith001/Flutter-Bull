import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/3_game/0_lobby_phase_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'lobby_phase_view_notifier.g.dart';

@Riverpod(keepAlive: true)
class LobbyPhaseViewNotifier extends _$LobbyPhaseViewNotifier {
  @override
  Stream<LobbyPhaseViewModel> build(String roomId, String userId) async* {
    final game = ref.watch(gameNotifierProvider(roomId));
    if (game is AsyncData) {
      yield _buildViewModel(
          game.requireValue.gameRoom, game.requireValue.players, userId);
    }
  }

  LobbyPhaseViewModel _buildViewModel(
      GameRoom game, Map<String, PlayerWithAvatar> players, String userId) {
        
    final prevPlayers =
        state.value?.presentPlayers.keys.toList() ?? [];
    final nextPlayers = game.playerIds;

    Logger().d('prev $prevPlayers - next $nextPlayers');

    ListChangeData<PlayerWithAvatar> listChange =
        _getListChange(players, prevPlayers, nextPlayers);

    return LobbyPhaseViewModel(
      game: game,
      players: players,
      listChangeData: listChange,
      userId: userId,
    );
  }

  ListChangeData<PlayerWithAvatar> _getListChange(
      Map<String, PlayerWithAvatar> allPlayers,
      List<String> prevPlayers,
      List<String> nextPlayers) {
    if (prevPlayers.isEmpty || ListEquality().equals(prevPlayers, nextPlayers)) {
      return ListChangeData(ListChangeType.unchanged, null, null);
    } else if (prevPlayers.length < nextPlayers.length) {
      final newPlayerId =
          nextPlayers.singleWhere((p) => !prevPlayers.contains(p));
      final newPlayer =
          allPlayers[newPlayerId];
      final newPlayerIndex = nextPlayers.indexWhere((p) => p == newPlayerId);
      assert(newPlayerIndex >= 0, 'newPlayerIndex < 0');
      return ListChangeData(ListChangeType.add, newPlayer, newPlayerIndex);
    } else //(prevPlayers.length > nextPlayers.length)
    {
      final oldPlayerId =
          prevPlayers.singleWhere((p) => !nextPlayers.contains(p));
      final oldPlayer =
          allPlayers[oldPlayerId];
      final oldPlayerIndex = prevPlayers.indexWhere((p) => p == oldPlayerId);
      assert(oldPlayerIndex >= 0, 'oldPlayerIndex < 0');
      return ListChangeData(ListChangeType.remove, oldPlayer, oldPlayerIndex);
    }
  }
}
