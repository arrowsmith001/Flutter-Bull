import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '0_lobby_phase_view_model.freezed.dart';

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
class LobbyPhaseViewModel with _$LobbyPhaseViewModel {
  factory LobbyPhaseViewModel({
    required GameRoom game,
    required List<PlayerWithAvatar> players,
    required String userId,
    required ListChangeData<PlayerWithAvatar> listChangeData,
  }) =>
      LobbyPhaseViewModel._(
          roomCode: game.roomCode,
          listChangeData: listChangeData,
          presentPlayers: players
              .where((p) => game.playerIds.contains(p.player.id))
              .toList(),
          absentPlayers: players
              .where((p) => !game.playerIds.contains(p.player.id))
              .toSet(),
          playerReadies: {});

  factory LobbyPhaseViewModel._({
    required String roomCode,
    required List<PlayerWithAvatar> presentPlayers,
    required Set<PlayerWithAvatar> absentPlayers,
    required ListChangeData<PlayerWithAvatar> listChangeData,
    required Map<String, bool> playerReadies,
  }) = _LobbyPhaseViewModel;
}
