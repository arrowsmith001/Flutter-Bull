import 'dart:typed_data';

import 'package:flutter_bull/extensions/iterable.dart';
import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/mixins/voting_phase_view_model.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:flutter_bull/src/view_models/3_game/1_writing_phase_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_data.g.dart';


// @Riverpod(keepAlive: true)
// AsyncValue<GameNotifierState> streamGameState(Ref ref, String? id) {
//   if (id == null) return;

//   DataStreamService streamService = ref.read(dataStreamServiceProvider);

//   yield* streamService.streamGameRoom(id).asyncMap((game) async {

//     final playerFutureAvatars =
//         game.playerIds.map((p) => ref.read(playerNotifierProvider(p).future));

//     final avatarList = await Future.wait(playerFutureAvatars);

//     final playerAvatars = Map.fromEntries(avatarList.map((e) => MapEntry(e.player.id!, e)));

//     final presentPlayers = playerAvatars.entries
//         .where((entry) => game.playerIds.contains(entry.key))
//         .map((p) => LobbyPlayer(
//             player: p.value,
//             isLeader: p.key == game.leaderId,
//             isReady: game.playerStates[p.key] == PlayerState.ready,
//             isAbsent: game.playerIds.doesNotContain(p.key)))
//         .toList();

//     // final timeRemaining = ref
//     //     .watch(timerNotifierProvider(game.roundEndUTC))
//     //     .valueOrNull
//     //     ?.timeRemaining;

//     // final roundStatus = getRoundStatus(game, timeRemaining);

//     //final result = await _getResult(room.resultId);
//     //final achievementsWithIcons = await _getAchievements(result);
    
//     return GameNotifierState(
//       gameId: game.id!,
//       gameRoom: game,
//       players: playerAvatars,
//       presentPlayers: presentPlayers,
//       timeRemaining: Duration.zero,// timeRemaining,
//       roundStatus: RoundStatus.inProgress
//       //result: result,
//       //achievementsWithIcons: achievementsWithIcons
//     );
//   });
// }

// @Riverpod(keepAlive: true)
// Stream<PublicPlayer> streamPlayer(Ref ref, String? id) async* {
//   if (id == null) return;

//   DataStreamService streamService = ref.read(dataStreamServiceProvider);
//   ImageStorageService imgService = ref.read(imageStorageServiceProvider);

//   yield* streamService.streamPlayer(id).asyncMap((p) async {
//     final Uint8List? img = p.occupiedRoomId == null
//         ? null
//         : await imgService.downloadImage(p.occupiedRoomId!);
//     return PublicPlayer(p, img);
//   });
// }

@Riverpod(keepAlive: true, dependencies: [getCurrentGameRoomId])
GameRoom? getGame(Ref ref) {
  // return GameRoom(roomCode: ref.watch(gameNotifierProvider(roomId)
  //     .select((value) => value.valueOrNull?.gameRoom?.toJson().toString() ?? '')));
  final String roomId = ref.watch(getCurrentGameRoomIdProvider);
  return ref.watch(gameNotifierProvider(roomId).select((value) => value.valueOrNull?.gameRoom));
}

@Riverpod(keepAlive: true, dependencies: [getCurrentGameRoomId])
Map<String, PublicPlayer>? getPlayers(Ref ref) {
  final String roomId = ref.watch(getCurrentGameRoomIdProvider);
  return ref.watch(gameNotifierProvider(roomId).select((value) => value.valueOrNull?.players));
}

@Riverpod(keepAlive: true, dependencies: [getGame])
String? getGameCode(Ref ref) {
  return ref.watch(getGameProvider.select((value) => value?.roomCode));
}

@Riverpod(keepAlive: true, dependencies: [getGame])
GamePhase? getPhase(Ref ref) {
  return ref.watch(getGameProvider.select((value) => value?.phase));
}

@Riverpod(keepAlive: true, dependencies: [getGame])
int? getSubphase(Ref ref) {
  return ref.watch(getGameProvider.select((value) => value?.subPhase));
}

@Riverpod(keepAlive: true, dependencies: [getGame])
String? getLeaderId(Ref ref) {
  return ref.watch(getGameProvider.select((value) => value?.leaderId));
}

@Riverpod(keepAlive: true, dependencies: [getGame])
List<String> getPseudoShuffledIds(Ref ref) {
  final GameRoom? g = ref.watch(getGameProvider);
  if (g == null) return [];
  return GameDataFunctions.getShuffledIds(g);
}

@Riverpod(keepAlive: true, dependencies: [isPlayerLeader, getSignedInPlayerId])
bool? getIsUserLeader(Ref ref) {
  final String? userId = ref.watch(getSignedInPlayerIdProvider);
  return ref.watch(isPlayerLeaderProvider(userId));
}

@Riverpod(keepAlive: true, dependencies: [getGame, getSignedInPlayerId])
bool getIsUserReady(Ref ref) {
  final String? userId = ref.watch(getSignedInPlayerIdProvider);
  return ref.watch(getPlayerStateProvider(userId)) == PlayerState.ready;
}

@Riverpod(keepAlive: true, dependencies: [getGame])
PlayerState? getPlayerState(Ref ref, String? id) {
  if (id == null) return null;
  return ref.watch(getGameProvider.select((value) => value?.playerStates[id]));
}

@Riverpod(keepAlive: true, dependencies: [getGame])
int getNumberOfPlayers(Ref ref) {
  return ref.watch(getGameProvider.select((value) => value?.playerIds.length ?? 0));
}

@Riverpod(keepAlive: true, dependencies: [getNumberOfPlayers])
bool getHasEnoughPlayers(Ref ref) {
  return ref.watch(getNumberOfPlayersProvider) >= 3;
}

@Riverpod(
    keepAlive: true, dependencies: [getGame, getPlayers, isPlayerLeader, isPlayerReady])
List<LobbyPlayer> lobbyListInitialData(Ref ref) {
  final GameRoom? g = ref.watch(getGameProvider);
  if (g == null) return [];

  final List<LobbyPlayer> lobbyList = ref
          .watch(getPlayersProvider)
          ?.values
          .where((p) => g.playerIds.contains(p.player.id))
          .map((p) => LobbyPlayer(
              player: p,
              isLeader: ref.watch(isPlayerLeaderProvider(p.player.id)) ?? false,
              isReady: ref.watch(isPlayerReadyProvider(p.player.id)) ?? false,
              isAbsent: g.playerIds.contains(p.player.id)))
          .toList() ??
      [];
  return lobbyList;
}

@Riverpod(dependencies: [getSignedInPlayerId, getPlayers])
PublicPlayer? user(Ref ref) {
  final String userId = ref.watch(getSignedInPlayerIdProvider);
  return ref.watch(getPlayersProvider)?[userId];
}


@Riverpod(keepAlive: true, dependencies: [getGame, isPlayerReady, isPlayerLeader])
bool canStartGame(Ref ref) {
  final List<String>? playerIds = ref.watch(getGameProvider.select((value) => value?.playerIds));
  if(playerIds == null) return false;
  return playerIds
      .every((id) => (ref.watch(isPlayerReadyProvider(id)) ?? false) || (ref.watch(isPlayerLeaderProvider(id)) ?? false));
}

@Riverpod(keepAlive: true, dependencies: [getPhase])
bool? isMidGame(Ref ref) {
  return ref
      .watch(getPhaseProvider)
      .isNotIn([null, GamePhase.lobby, GamePhase.results]);
}

@Riverpod(keepAlive: true, dependencies: [getGame, getPlayerState])
bool? isPlayerReady(Ref ref, String? id) {
  if (id == null) return false;
  return ref.watch(getPlayerStateProvider(id)) == PlayerState.ready;
}

@Riverpod(keepAlive: true, dependencies: [getLeaderId])
bool? isPlayerLeader(Ref ref, String? id) {
  if (id == null) return false;
  return ref.watch(getLeaderIdProvider) == id;
}

@Riverpod(keepAlive: true, dependencies: [getGame])
int? numberOfPlayersSubmittedText(Ref ref) {
  return ref.watch(getGameProvider)?.texts.length ?? 0;
}

@Riverpod(keepAlive: true, dependencies: [getGame])
bool? isPlayerTruthOrLie(Ref ref, String? id) {
  if (id == null) return false;
  return ref.watch(getGameProvider)?.truths[id];
}

@Riverpod(keepAlive: true, dependencies: [getGame, getSignedInPlayerId])
WritingPrompt userWritingPrompt(Ref ref) {
  final String userId = ref.watch(getSignedInPlayerIdProvider);
  final GameRoom? g = ref.watch(getGameProvider);
  return WritingPrompt(g?.targets[userId]);
}

@Riverpod(dependencies: [getPlayers, getSignedInPlayerId])
PublicPlayer? playerWritingFor(Ref ref) {
  final String userId = ref.watch(getSignedInPlayerIdProvider);
  final String? targetId = ref.watch(getGameProvider.select((value) => value?.targets[userId]));
  if (targetId == null) return null;
  return ref.watch(getPlayersProvider)?[targetId];
}

@Riverpod(keepAlive: true, dependencies: [getGame, getSignedInPlayerId])
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

@Riverpod(dependencies: [getPlayers])
List<PublicPlayer> presentPlayers(Ref ref) {
  final GameRoom? game = ref.watch(getGameProvider);
  final List<PublicPlayer> players =
      ref.watch(getPlayersProvider)?.values.toList() ?? [];
  if (game == null) return [];
  return players.where((p) => game.playerIds.contains(p.player.id)).toList();
}

@Riverpod(keepAlive: true, dependencies: [getGame, isPlayerReady])
List<String> readyRoster(Ref ref) {
  final GameRoom? game = ref.watch(getGameProvider);
  if (game == null) return [];
  return game.playerIds.where((id) => ref.watch(isPlayerReadyProvider(id)) ?? false).toList();
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

