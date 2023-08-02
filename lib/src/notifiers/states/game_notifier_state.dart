import 'package:flutter_bull/src/enums/game_room_state_phase.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_notifier_state.freezed.dart';

@freezed
class GameNotifierState with _$GameNotifierState {
  factory GameNotifierState(
      {
        required String roomCode,
        required GamePhaseData phaseData,
      required ListState playerListState,
      required RolesState rolesState,
      required RoundsState roundsState}) = _GameNotifierState;

}

@freezed
class GamePhaseData with _$GamePhaseData {
  factory GamePhaseData({
    required GameRoomPhase? phase,
    @Default(null) Object? arg,
  }) = _GamePhaseData;
}

@freezed
class RoundsState with _$RoundsState {
  RoundsState._();
  factory RoundsState(
      {required List<int> order,
      required List<String> playerIds,
      required int progress}) = _RoundsState;

  String? get getCurrentPlayerWhoseTurn {
    if (progress < order.length) {
      final playerIndex = order[progress];
      if (playerIndex < playerIds.length) {
        return playerIds[playerIndex];
      }
    }
    return null;
  }

  bool isItMyTurn(String userId) {
    final whoseTurn = getCurrentPlayerWhoseTurn;
    return whoseTurn != null && whoseTurn == userId;
  }
}

@freezed
class RolesState with _$RolesState {
  const RolesState._();

  String getWritingPhaseMessage(String userId) {
    bool isPlayerTruther = isTruther(userId);
    return 'Write a ${isPlayerTruther ? 'TRUTH' : 'LIE'} about ${isPlayerTruther ? 'YOURSELF' : getTarget(userId)}';
  }

  int get numberOfParticipants => participants.length;
  List<String> get participants => targets.keys.toSet().toList();

  String getTarget(String id) => targets[id]!;
  bool isTruther(String id) => targets[id] == id;

  factory RolesState(
      {@Default({}) Map<String, String> targets,
      @Default({}) Map<String, String> texts}) = _RolesState;

  String getMyText(String participantId) {
    return texts.containsKey(participantId) ? texts[participantId]! : '';
  }
}

@freezed
class ListState with _$ListState {
  factory ListState.fromLists(List<String>? listBefore, List<String> listNow) {
    listBefore ??= List.from(listNow);

    final lengthBefore = listBefore.length;
    final lengthAfter = listNow.length;

    // TODO: Assumptions too simple
    final listChange = lengthBefore < lengthAfter
        ? ListChangeType.increased
        : lengthAfter < lengthBefore
            ? ListChangeType.decreased
            : ListChangeType.unchanged;

    int? changedItemIndex;
    String? changedItem;

    // TODO: Assumes only 1 single change
    try {
      if (listChange == ListChangeType.increased) {
        changedItem =
            listNow.singleWhere((element) => !listBefore!.contains(element));
        changedItemIndex =
            listNow.indexWhere((element) => element == changedItem);
      } else if (listChange == ListChangeType.decreased) {
        changedItem =
            listBefore.singleWhere((element) => !listNow.contains(element));
        changedItemIndex =
            listBefore.indexWhere((element) => element == changedItem);
      }
    } catch (e) {}

    return ListState(
        list: listNow,
        lengthBefore: listBefore.length,
        length: listNow.length,
        hasChanged: listBefore != listNow,
        listChangeType: listChange,
        changeIndex: changedItemIndex,
        changedItemId: changedItem);
  }

  factory ListState(
      {required List<String> list,
      required int lengthBefore,
      required int length,
      @Default(false) bool hasChanged,
      @Default(ListChangeType.unchanged) ListChangeType listChangeType,
      int? changeIndex,
      String? changedItemId}) = _ListState;
}

enum ListChangeType { unchanged, increased, decreased }
