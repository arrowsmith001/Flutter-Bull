import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../notifiers/view_models/lobby_player.dart';

part '0_lobby_phase_view_model.freezed.dart';


const int numberOfPlayersNeededForGame = 3;

enum ListChangeType { unchanged, add, remove }

class ListChangeData<T> {
  @override
  String toString() {
    return '${listChangeType.name} $data $changeIndex';
  }

  final int? changeIndex;
  final ListChangeType listChangeType;
  final T? data;

  ListChangeData(
      this.listChangeType, this.data, this.changeIndex);
}

@freezed
class LobbyPhaseViewModel with _$LobbyPhaseViewModel {

  factory LobbyPhaseViewModel({
    required GameRoom game,
    required Map<String, LobbyPlayer> players,
    required String userId,
    required ListChangeData<LobbyPlayer> listChangeData,
  }) {

    final presentPlayers = Map.fromEntries(
        players.entries.where((entry) => game.playerIds.contains(entry.key)));

    final absentPlayers = Set<PublicPlayer>.from(players.entries
        .where((entry) => !game.playerIds.contains(entry.key))
        .map((e) => e.value.player));

    final int numberOfPlayersPresent = presentPlayers.length;
    final int playerDiff =
        numberOfPlayersNeededForGame - numberOfPlayersPresent;
    String numberOfPlayersString = '$numberOfPlayersPresent players in game';
    if (playerDiff > 0) {
      numberOfPlayersString += ' ($playerDiff more needed)';
    }

    final readyRoster = game.playerIds
            .where((id) => game.playerStates[id] == PlayerState.ready)
            .toSet();

    return LobbyPhaseViewModel._(
        roomCode: game.roomCode,
        leaderId: game.leaderId ?? '',
        isLeader: game.leaderId == userId,
        isReady: readyRoster.contains(userId),
        canStartGame: game.playerIds.every((id) => readyRoster.contains(id) || id == game.leaderId),
        listChangeData: listChangeData,
        presentPlayers: presentPlayers,
        absentPlayers: absentPlayers,
        playerReadies: game.playerStates.map((key, value) => MapEntry(key, value == PlayerState.ready)),
        numberOfPlayersString: numberOfPlayersString,
        enoughPlayers: numberOfPlayersPresent >= numberOfPlayersNeededForGame,
        isStartingGame: game.state == 'startingGame');
  }

  factory LobbyPhaseViewModel._({
    required String roomCode,
    required String leaderId,
    required bool isLeader,
    required bool isReady,
    required bool canStartGame,
    required Map<String, LobbyPlayer> presentPlayers,
    required Set<PublicPlayer> absentPlayers,
    required ListChangeData<LobbyPlayer> listChangeData,
    required Map<String, bool> playerReadies,
    required String numberOfPlayersString,
    required bool enoughPlayers,
    required bool isStartingGame,
  }) = _LobbyPhaseViewModel;
}

