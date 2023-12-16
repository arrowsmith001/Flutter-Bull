import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/view_models/3_game/1_writing_phase_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin GameHooks<T extends ConsumerStatefulWidget> on ConsumerState<T> {

  late final String userId = ref.watch(getSignedInPlayerIdProvider);
  late final String gameId = ref.watch(getCurrentGameRoomIdProvider);

  GameNotifier get game => ref.read(gameNotifierProvider(gameId).notifier);

  String? get gameCode => _watchThen(_getGameCode);
  GamePhase? get phase => _watchThen(_getGamePhase);
  int? get subPhase => _watchThen(_getGameSubphase);


  // Lobby
  List<LobbyPlayer> get lobbyListInitialData => _watchThen(_getLobbyList) ?? [];

  late String? leaderId =_watchThen((game) => game.gameRoom.leaderId);

  late bool isLeader = userId == leaderId;
  late bool isReady = isPublicPlayerReady(me);
  bool get enoughPlayers =>
      _watchThen((game) => game.gameRoom.playerIds.length >= 3) ?? false;
  PublicPlayer? get me => _watchPlayer(userId);
  // bool get canStartGame =>
  //     _playerIds.every((id) => isPlayerReady(id) || id == _leaderId);
  int get numberOfPlayers => _watchThen(_getNumberOfPlayers) ?? 0;


  // Writing
  String get playersSubmittedTextPrompt =>
      '${_texts.length}/$numberOfPlayers ready';
  bool? get writingTruthOrLie => _watchThen(_getTruthOrLie);
  WritingPrompt get writingPrompt =>
      WritingPrompt(_watchThen((game) => game.gameRoom.targets[userId]));
  PublicPlayer? get playerWritingFor => _watchThen(_getPlayerWritingFor);


  // Page States
  bool get isMidGame =>
      _watchThen((g) => g.gameRoom.phase
          .isNotIn([null, GamePhase.lobby, GamePhase.results])) ??
      false;
  bool get hasSubmittedText =>
      _watchThen((g) => g.gameRoom.texts[g.gameRoom.targets[userId]] != null) ??
      false;
  bool get isFinalRound =>
      _watchThen(
          (g) => g.gameRoom.progress == g.gameRoom.playerIds.length - 1) ??
      false;


  // Common
  Map<String, PublicPlayer> get allPlayers =>
      _watchThen((game) => game.players) ?? {};

  List<PublicPlayer> get presentPlayers =>
      _watchThen((game) => game.players.values
          .where((p) => game.gameRoom.playerIds.contains(p.player.id))
          .toList()) ??
      [];

  String _getGameCode(GameNotifierState game) => game.gameRoom.roomCode;
  GamePhase? _getGamePhase(GameNotifierState game) => game.gameRoom.phase;
  int? _getGameSubphase(GameNotifierState game) => game.gameRoom.subPhase;
  int? _getNumberOfPlayers(GameNotifierState game) => game.gameRoom.playerIds.length;



  List<LobbyPlayer> _getLobbyList(GameNotifierState game) {
    return game.players.values
        .where((p) => game.gameRoom.playerIds.contains(p.player.id))
        .map((p) => _playerToLobbyPlayer(p, game.gameRoom.playerIds))
        .toList();
  }

  LobbyPlayer _playerToLobbyPlayer(PublicPlayer p, List<String> ids) => LobbyPlayer(
      player: p, isLeader: _isPlayerLeader(p), isReady: isPublicPlayerReady(p), isAbsent: ids.contains(p.player.id));

  bool _isPlayerLeader(PublicPlayer p) =>
      p.player.id != null && p.player.id == leaderId;

  PublicPlayer? _getPlayerWritingFor(GameNotifierState game) =>
      game.players[game.gameRoom.targets[userId]];

  bool isPublicPlayerReady(PublicPlayer? p) =>
      p?.player.id != null && isPlayerReady(p!.player.id);

  bool isPlayerReady(String? id) =>
      id != null && (_getPlayerState(id) == PlayerState.ready);

  PlayerState? _getPlayerState(String? id) =>
      _watchThen((game) => game.gameRoom.playerStates[id]);

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

  List<String> get _playerIds =>
      _watchThen((game) => game.gameRoom.playerIds) ?? [];
  List<String> get _playerOrder =>
      _watchThen((game) => game.gameRoom.playerOrder) ?? [];
  String? get _leaderId => _watchThen((game) => game.gameRoom.leaderId);
  Map<String, String?> get _texts =>
      _watchThen((game) => game.gameRoom.texts) ?? {};
  Map<String, String> get _targets =>
      _watchThen((game) => game.gameRoom.targets) ?? {};

// TODO: Convert all of below to correct format

  // To listen to game events in the UI build method

  R? _watchThen<R>(R? Function(GameNotifierState game) transform) =>
      ref.watch(gameNotifierProvider(gameId).select((value) =>
          value.valueOrNull == null ? null : transform(value.valueOrNull!)));

  PublicPlayer? _watchPlayer(String id) =>
      _watchThen((game) => game.players[id]);

  bool? _getTruthOrLie(GameNotifierState game) => game.gameRoom.truths[userId];
}
