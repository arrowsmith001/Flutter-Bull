import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_notifier_state.freezed.dart';

@freezed
class GameNotifierState with _$GameNotifierState {
  GameNotifierState._();

  factory GameNotifierState({
    required String gameId,
    required GameRoom gameRoom,
    required Map<String, PublicPlayer> players,
    required List<LobbyPlayer> presentPlayers,
    required Duration? timeRemaining,
    required RoundStatus? roundStatus,
    GameError? error,
    //GameResult? result,
    //@Default([]) List<AchievementWithIcon> achievementsWithIcons
  }) = _GameNotifierState;
}

class GameError {
  final Object error;

  GameError(this.error);
}
/* 
@freezed
class GamePhaseData with _$GamePhaseData {
  factory GamePhaseData({
    required GamePhase gamePhase,
    required RoundPhase roundPhase,
    @Default(null) Object? arg,
  }) = _GamePhaseData;
}

@freezed
class RoundsState with _$RoundsState {
  RoundsState._();
  factory RoundsState(
      {required List<String> order,
      required List<String> playerIds,
      required int progress}) = _RoundsState;

  String? get getCurrentPlayerWhoseTurn {
    if (progress < order.length) {
      return order[progress];
    }
    return null;
  }

  bool isItMyTurn(String userId) {
    final whoseTurn = getCurrentPlayerWhoseTurn;
    return whoseTurn != null && whoseTurn == userId;
  }
}

@freezed
class RoundState with _$RoundState {
  factory RoundState({required int? timeRemaining}) = _RoundState;
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
        ? ListChangeType.add
        : lengthAfter < lengthBefore
            ? ListChangeType.remove
            : ListChangeType.unchanged;

    int? changedItemIndex;
    String? changedItem;

    // TODO: Assumes only 1 single change
    try {
      if (listChange == ListChangeType.add) {
        changedItem =
            listNow.singleWhere((element) => !listBefore!.contains(element));
        changedItemIndex =
            listNow.indexWhere((element) => element == changedItem);
      } else if (listChange == ListChangeType.remove) {
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

 */
