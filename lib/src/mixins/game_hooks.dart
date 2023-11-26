import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin GameHooks<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  
  String? get userId => ref.watch(authNotifierProvider).valueOrNull?.userId;
  String? get gameId => ref.watch(authNotifierProvider).valueOrNull?.occupiedRoomId;

  GameNotifier get game => ref.read(gameNotifierProvider(gameId!).notifier);
  GameNotifierState? get _game => gameId == null ? null : ref.watch(gameNotifierProvider(gameId!)).valueOrNull;

  AppState? get _app => ref.watch(appStateNotifierProvider).valueOrNull;

  // Activities
  bool get isLeavingGame => isBusyWith(Busy.leavingGame);
  bool get isStartingGame => isBusyWith(Busy.startingGame);
  bool get isEndingRound => isBusyWith(Busy.endingRound);
  bool get isVoting => isBusyWith(Busy.voting);
  bool get isRevealing => isBusyWith(Busy.revealing);
  bool get isRevealingNext => isBusyWith(Busy.revealingNext);
  bool get isSubmittingText => isBusyWith(Busy.submittingText);


  // Page States
  bool get isMidGame => isGame((g) => g.phase.isNotIn([null, GamePhase.lobby, GamePhase.results]));
  bool get hasSubmittedText => isGame((g) => g.texts[userId] != null);




  bool isBusyWith(Busy busy) => _app?.busyWith.contains(busy) ?? false;
  bool isBusyWithAny(List<Busy> busy) => _app?.busyWith.any((e) => busy.contains(e)) ?? false;

  bool isGame(Function(GameRoom g) func) => _game?.gameRoom == null ? false : func(_game!.gameRoom);
}
