import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_event_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:flutter_bull/src/view_models/3_game/1_writing_phase_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin GameHooks<T extends ConsumerStatefulWidget> on ConsumerState<T> {

  late final String _userId = ref.watch(getSignedInPlayerIdProvider);
  late final String _gameId = ref.watch(getCurrentGameRoomIdProvider);

  GameEventNotifierProvider get gameEvents => gameEventNotifierProvider(_gameId);

  GameNotifier get game => ref.read(gameNotifierProvider(_gameId).notifier);
  GameNotifierState? get _game =>
      ref.watch(gameNotifierProvider(_gameId)).valueOrNull;

  AppState? get _app => ref.watch(appStateNotifierProvider).valueOrNull;

  // Activities
  bool get isLeavingGame => isBusyWith(Busy.leavingGame);
  bool get isStartingGame => isBusyWith(Busy.startingGame);
  bool get isEndingRound => isBusyWith(Busy.endingRound);
  bool get isVoting => isBusyWith(Busy.voting);
  bool get isRevealing => isBusyWith(Busy.revealing);
  bool get isRevealingNext => isBusyWith(Busy.revealingNext);
  bool get isSubmittingText => isBusyWith(Busy.submittingText);

  bool isBusyWith(Busy busy) => _app?.busyWith.contains(busy) ?? false;
  bool isBusyWithAny(List<Busy> busy) =>
      _app?.busyWith.any((e) => busy.contains(e)) ?? false;

  //  Lobby
  String? get gameCode => _game?.gameRoom.roomCode;
  GamePhase? get phase => _game?.gameRoom.phase;
  int? get subPhase => _game?.gameRoom.subPhase;
  List<LobbyPlayer> get lobbyListInitialData =>
      presentPlayers.map<LobbyPlayer>(playerToLobbyPlayer).toList();

  LobbyPlayer playerToLobbyPlayer(PublicPlayer p) => LobbyPlayer(
      player: p, isLeader: isPlayerLeader(p), isReady: isPublicPlayerReady(p));

  bool isPlayerLeader(PublicPlayer p) =>
      p.player.id != null && p.player.id == _game?.gameRoom.leaderId;

  bool get isLeader => _userId != null && _game?.gameRoom.leaderId == _userId;
  bool get isReady => isPublicPlayerReady(me);
  bool get enoughPlayers => (_game?.gameRoom.playerIds.length ?? 0) >= 3;
  PublicPlayer? get me => _game?.players[_userId];
  bool get canStartGame =>
      _playerIds.every((id) => isPlayerReady(id) || id == _leaderId);
  int get numberOfPlayers => _playerIds.length;

  // Writing
  String get playersSubmittedTextPrompt =>
      '${_texts.length}/${_playerIds.length} ready';
  bool get writingTruthOrLie => _targets[_userId] == _userId;
  WritingPrompt get writingPrompt => WritingPrompt(_myTarget);
  PublicPlayer get playerWritingFor => _game!.players[_targets[_userId]]!;

  // Page States
  bool get isMidGame => isGame(
      (g) => g.phase.isNotIn([null, GamePhase.lobby, GamePhase.results]));
  bool get hasSubmittedText =>
      isGame((g) => g.texts[g.targets[_userId]] != null);
  bool get isFinalRound => isGame((g) => g.progress == g.playerIds.length - 1);

  // Common
  Map<String, PublicPlayer> get allPlayers => _game?.players ?? {};

  List<PublicPlayer> get presentPlayers =>
      _game?.players.values.where(isPlayerPresent).toList() ?? [];

  bool isGame(Function(GameRoom g) func) =>
      _game?.gameRoom == null ? false : func(_game!.gameRoom);

  bool isPublicPlayerReady(PublicPlayer? p) =>
      p?.player.id != null && isPlayerReady(p!.player.id);

  bool isPlayerReady(String? id) =>
      id != null && (getPlayerState(id) == PlayerState.ready);

  PlayerState? getPlayerState(String? id) => _game?.gameRoom.playerStates[id];

  bool isPlayerPresent(PublicPlayer p) =>
      p.player.id != null && _game!.gameRoom.playerIds.contains(p.player.id);
  bool isPlayerAbsent(PublicPlayer p) => !isPlayerPresent(p);

  // String whoseTurn(int fixedProgress) => _playerOrder[fixedProgress];
  // List<String> playersLeftToPlay(int fixedProgress) {
  //   if(_game?.gameRoom == null) return [];

  //       final List<String> pseudoShuffledIds =
  //       GameDataFunctions.getShuffledIds(_game!.gameRoom);

  //   return pseudoShuffledIds
  //       .where((id) => (fixedProgress - 1) < _game!.gameRoom.playerOrder.indexOf(id))
  //       .toList();
  // }

  //PublicPlayer playerWhoseTurn(int fixedProgress) => allPlayers[whoseTurn(fixedProgress)]!;

  List<String> get readyRoster => _playerIds.where(isPlayerReady).toList();

  List<String> get _playerIds => _game?.gameRoom.playerIds ?? [];
  List<String> get _playerOrder => _game?.gameRoom.playerOrder ?? [];
  String? get _leaderId => _game?.gameRoom.leaderId;
  String? get _myTarget => _targets[_userId];
  Map<String, String?> get _texts => _game?.gameRoom.texts ?? {};
  Map<String, String> get _targets => _game?.gameRoom.targets ?? {};
}
