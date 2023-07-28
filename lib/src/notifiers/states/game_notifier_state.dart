import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_notifier_state.freezed.dart';

@freezed
class GameNotifierState with _$GameNotifierState {
  factory GameNotifierState(
      {required Player signedInPlayer,
      required GameRoom gameRoom,
      required ListState playerListState}) = _GameNotifierState;
}

@freezed
class ListState with _$ListState {

  factory ListState.init(List<String> list) => ListState.fromLists(list, list);

  factory ListState.fromLists(List<String> listBefore, List<String> listNow) {
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
            listNow.singleWhere((element) => !listBefore.contains(element));
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
        lengthBefore: listBefore.length,
        length: listNow.length,
        hasChanged: listBefore != listNow,
        listChangeType: listChange,
        changeIndex: changedItemIndex,
        changedItemId: changedItem);
  }

  factory ListState(
      {
      required int lengthBefore,
      required int length,
      @Default(false) bool hasChanged,
      @Default(ListChangeType.unchanged) ListChangeType listChangeType,
      int? changeIndex,
      String? changedItemId}) = _ListState;
}

enum ListChangeType { unchanged, increased, decreased }
