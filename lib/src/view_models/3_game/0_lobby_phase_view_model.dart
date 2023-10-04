import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '0_lobby_phase_view_model.freezed.dart';


// TODO: Outsource variable
const int numberOfPlayersNeededForGame = 3;

enum ListChangeType { unchanged, add, remove }

class ListChangeData<T> {
  @override
  String toString() {
    return '${listChangeType.name} ${data} $changeIndex';
  }

  final int? changeIndex;
  final ListChangeType listChangeType;
  final T? data;

  ListChangeData(this.listChangeType, this.data, this.changeIndex);
}

@freezed
class LobbyPhaseViewModel with _$LobbyPhaseViewModel 
{
  factory LobbyPhaseViewModel({
    required GameRoom game,
    required Map<String, PlayerWithAvatar> players,
    required String userId,
    required ListChangeData<PlayerWithAvatar> listChangeData,
  }) {

    final presentPlayers = Map.fromEntries(players.entries
    .where((entry) => game.playerIds.contains(entry.key)));

    final absentPlayers = Set<PlayerWithAvatar>.from(players.entries
    .where((entry) => !game.playerIds.contains(entry.key)).map((e) => e.value));

    final int numberOfPlayersPresent = presentPlayers.length;
    final int playerDiff = numberOfPlayersNeededForGame - numberOfPlayersPresent;
    String numberOfPlayersString = '$numberOfPlayersPresent players in game';
    if(playerDiff > 0)
    {
      numberOfPlayersString += ' ($playerDiff more needed)';
    }
      
    return LobbyPhaseViewModel._(
          roomCode: game.roomCode,
          listChangeData: listChangeData,
          presentPlayers: presentPlayers,
          absentPlayers: absentPlayers,
          playerReadies: {},
          numberOfPlayersString: numberOfPlayersString,
          enoughPlayers: numberOfPlayersPresent >= numberOfPlayersNeededForGame,
          isStartingGame : game.state == 'startingGame');
  }

  factory LobbyPhaseViewModel._({
    required String roomCode,
    required Map<String, PlayerWithAvatar> presentPlayers,
    required Set<PlayerWithAvatar> absentPlayers,
    required ListChangeData<PlayerWithAvatar> listChangeData,
    required Map<String, bool> playerReadies,
    required String numberOfPlayersString,
    required bool enoughPlayers,
    required bool isStartingGame,
  }) = _LobbyPhaseViewModel;

}
