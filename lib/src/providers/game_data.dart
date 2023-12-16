import 'dart:typed_data';

import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/custom/data/abstract/storage_service.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:flutter_bull/src/view_models/3_game/1_writing_phase_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_data.g.dart';

// TODO: Continue

@Riverpod(keepAlive: true)
Stream<GameRoom> streamGame(Ref ref, String? id) async* {
  // return GameRoom(roomCode: ref.watch(gameNotifierProvider(roomId)
  //     .select((value) => value.valueOrNull?.gameRoom?.toJson().toString() ?? '')));
  if (id == null) return;
  DataStreamService streamService = ref.read(dataStreamServiceProvider);
  yield* streamService.streamGameRoom(id);
}

@Riverpod(keepAlive: true)
Stream<PublicPlayer> streamPlayer(Ref ref, String? id) async* {
  if (id == null) return;

  DataStreamService streamService = ref.read(dataStreamServiceProvider);
  ImageStorageService imgService = ref.read(imageStorageServiceProvider);

  yield* streamService.streamPlayer(id).asyncMap((p) async {
    final Uint8List? img = p.occupiedRoomId == null ? null : await imgService.downloadImage(p.occupiedRoomId!);
    return PublicPlayer(p, img);
  });
}

@Riverpod(keepAlive: true, dependencies: [getCurrentGameRoomId, streamGame])
GameRoom? getGame(Ref ref) {
  final String roomId = ref.watch(getCurrentGameRoomIdProvider);
  // return GameRoom(roomCode: ref.watch(gameNotifierProvider(roomId)
  //     .select((value) => value.valueOrNull?.gameRoom?.toJson().toString() ?? '')));
  return ref.watch(streamGameProvider(roomId)).asData?.value;
}

@Riverpod(keepAlive: true, dependencies: [getCurrentGameRoomId])
Map<String, PublicPlayer>? getPlayers(Ref ref) {
  final String roomId = ref.watch(getCurrentGameRoomIdProvider);
  return ref.watch(gameNotifierProvider(roomId)
      .select((value) => value.valueOrNull?.players));
}

@Riverpod(keepAlive: true, dependencies: [getCurrentGameRoomId])
String? getGameCode(Ref ref) {
  return ref.watch(getGameProvider.select((value) => value?.roomCode));
}

@Riverpod(keepAlive: true, dependencies: [getGame])
GamePhase? getPhase(Ref ref) {
  return ref.watch(getGameProvider.select((value) => value?.phase));
}

@Riverpod(keepAlive: true)
int? getSubphase(Ref ref) {
  return ref.watch(getGameProvider)?.subPhase;
}

@Riverpod(keepAlive: true)
String? getLeaderId(Ref ref) {
  return ref.watch(getGameProvider)?.leaderId;
}

@Riverpod(keepAlive: true)
List<String> getPseudoShuffledIds(Ref ref) {
  final GameRoom? g = ref.watch(getGameProvider);
  if (g == null) return [];
  return GameDataFunctions.getShuffledIds(g);
}

@Riverpod()
bool getIsUserLeader(Ref ref) {
  final String? userId = ref.watch(getSignedInPlayerIdProvider);
  return isPlayerLeader(ref, userId);
}

@Riverpod()
bool getIsUserReady(Ref ref) {
  final String? userId = ref.watch(getSignedInPlayerIdProvider);
  return ref.watch(getPlayerStateProvider(userId)) == PlayerState.ready;
}

@Riverpod(keepAlive: true)
PlayerState? getPlayerState(Ref ref, String? id) {
  if (id == null) return null;
  return ref.watch(getGameProvider)?.playerStates[id];
}

@Riverpod(keepAlive: true)
int getNumberOfPlayers(Ref ref) {
  return ref.watch(getGameProvider)?.playerIds.length ?? 0;
}

@Riverpod()
bool getHasEnoughPlayers(Ref ref) {
  return ref.watch(getNumberOfPlayersProvider) >= 3;
}

@Riverpod(keepAlive: true, dependencies: [getCurrentGameRoomId, getGame])
List<LobbyPlayer> lobbyListInitialData(Ref ref) {
  final GameRoom? g = ref.watch(getGameProvider);
  if (g == null) return [];

  final List<LobbyPlayer> lobbyList = ref
          .watch(getPlayersProvider)
          ?.values
          .where((p) => g.playerIds.contains(p.player.id))
          .map((p) => LobbyPlayer(
              player: p,
              isLeader: isPlayerLeader(ref, p.player.id),
              isReady: isPlayerReady(ref, p.player.id),
              isAbsent: g.playerIds.contains(p.player.id)))
          .toList() ??
      [];
  return lobbyList;
}

@Riverpod()
PublicPlayer? user(Ref ref) {
  final String userId = getSignedInPlayerId(ref);
  return ref.watch(getPlayersProvider)?[userId];
}

@Riverpod()
bool canStartGame(Ref ref) {
  final List<String> playerIds = ref.watch(getGameProvider)?.playerIds ?? [];
  return playerIds
      .every((id) => isPlayerReady(ref, id) || isPlayerLeader(ref, id));
}

@Riverpod()
bool isMidGame(Ref ref) {
  return ref
      .watch(getPhaseProvider)
      .isNotIn([null, GamePhase.lobby, GamePhase.results]);
}

@Riverpod()
bool isPlayerReady(Ref ref, String? id) {
  if (id == null) return false;
  return ref.watch(getPlayerStateProvider(id)) == PlayerState.ready;
}

@Riverpod()
bool isPlayerLeader(Ref ref, String? id) {
  if (id == null) return false;
  return ref.watch(getLeaderIdProvider) == id;
}

@Riverpod()
int numberOfPlayersSubmittedText(Ref ref) {
  return ref.watch(getGameProvider)?.texts.length ?? 0;
}

@Riverpod(keepAlive: true)
bool isPlayerTruthOrLie(Ref ref, String? id) {
  if (id == null) return false;
  return ref.watch(getGameProvider)?.truths[id] ?? false;
}

@Riverpod()
WritingPrompt userWritingPrompt(Ref ref) {
  final String userId = getSignedInPlayerId(ref);
  final GameRoom? g = ref.watch(getGameProvider);
  return WritingPrompt(g?.targets[userId]);
}

@Riverpod()
PublicPlayer? playerWritingFor(Ref ref) {
  final String userId = getSignedInPlayerId(ref);
  final String? targetId = ref.watch(getGameProvider)?.targets[userId];
  if (targetId == null) return null;
  return ref.watch(getPlayersProvider)?[targetId];
}

@Riverpod()
bool? hasSubmittedText(Ref ref) {
  final String userId = ref.watch(getSignedInPlayerIdProvider);
  final GameRoom? game = ref.watch(getGameProvider);
  return game?.texts[game.targets[userId] ?? ''] != null;
}

@Riverpod()
bool isFinalRound(Ref ref) {
  final GameRoom? game = ref.watch(getGameProvider);
  final int? progress = game?.progress;
  final int finalRound = (game?.playerIds.length ?? 0) - 1;
  return progress != null && progress == finalRound;
}

@Riverpod()
List<PublicPlayer> presentPlayers(Ref ref) {
  final GameRoom? game = ref.watch(getGameProvider);
  final List<PublicPlayer> players =
      ref.watch(getPlayersProvider)?.values.toList() ?? [];
  if (game == null) return [];
  return players.where((p) => game.playerIds.contains(p.player.id)).toList();
}

@Riverpod()
List<String> readyRoster(Ref ref) {
  final GameRoom? game = ref.watch(getGameProvider);
  if (game == null) return [];
  return game.playerIds.where((id) => isPlayerReady(ref, id)).toList();
}


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


// TODO: Convert all of below to correct format

// To listen to game events in the UI build method

