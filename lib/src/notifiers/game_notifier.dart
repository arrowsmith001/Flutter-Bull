import 'dart:async';

import 'package:flutter_bull/extensions/iterable.dart';
import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/timer_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/utils/game_data_functions.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameNotifier extends _$GameNotifier {
  AppStateNotifier get appNotifier =>
      ref.read(appStateNotifierProvider.notifier);

  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  UtterBullServer get _server => ref.read(utterBullServerProvider);

  String? get roomId => state.value!.gameId;

  @override
  Stream<GameNotifierState> build(String gameRoomId) async* {
    yield* _streamService
        .streamGameRoom(gameRoomId)
        // .switchMap((room) {
        //   _streamService.strea
        // })
        .asyncMap((room) {
      return _buildState(room);
    });
  }

  // TODO: Create parallel combined streams
  Future<GameNotifierState> _buildState(GameRoom game) async {
    final playerAvatars = await _getPlayerAvatars(game.playerIds);

    final presentPlayers = playerAvatars.entries
        .where((entry) => game.playerIds.contains(entry.key))
        .map((p) => LobbyPlayer(
            player: p.value,
            isLeader: p.key == game.leaderId,
            isReady: game.playerStates[p.key] == PlayerState.ready,
            isAbsent: game.playerIds.doesNotContain(p.key)))
        .toList();

    final timeRemaining = ref
        .watch(timerNotifierProvider(game.roundEndUTC))
        .valueOrNull
        ?.timeRemaining;

    final roundStatus = getRoundStatus(game, timeRemaining);

    //final result = await _getResult(room.resultId);
    //final achievementsWithIcons = await _getAchievements(result);

    return GameNotifierState(
      gameId: game.id!,
      gameRoom: game,
      players: playerAvatars,
      presentPlayers: presentPlayers,
      timeRemaining: timeRemaining,
      roundStatus: roundStatus,
      //result: result,
      //achievementsWithIcons: achievementsWithIcons
    );
  }

  Future<Map<String, PublicPlayer>> _getPlayerAvatars(
      List<String> playerIds) async {
    final prevList = state.valueOrNull?.players.keys ?? [];
    final allPlayers = {...playerIds, ...prevList}.toList();

    final playerFutureAvatars =
        allPlayers.map((p) => ref.read(playerNotifierProvider(p).future));

    final avatarList = await Future.wait(playerFutureAvatars);

    return Map.fromEntries(avatarList.map((e) => MapEntry(e.player.id!, e)));
  }

  Future<void> startGame() async {
    try {
      appNotifier.addBusy(Busy.startingGame);
      await _server.startGame(roomId!);
    } catch (e) {
      setData(value.copyWith(error: GameError(e)));
    } finally {
      appNotifier.removeBusy(Busy.startingGame);
    }
  }

  Future<void> leaveGame(String? userId) async {
    try {
      appNotifier.addBusy(Busy.leavingGame);
      await _server.removeFromRoom(userId!, roomId!);
    } catch (e) {
      setData(value.copyWith(error: GameError(e)));
    } finally {
      appNotifier.removeBusy(Busy.leavingGame);
    }
  }

  Future<void> setReady(String userId, PlayerState playerState) async {
    try {
      appNotifier.addBusy(Busy.settingReady);
      await _server.setPlayerState(roomId!, userId, playerState);
    } catch (e) {
      setError(e);
    } finally {
      appNotifier.removeBusy(Busy.settingReady);
    }
  }

  Future<void> submitText(String? userId, String? text) async {
    try {
      appNotifier.addBusy(Busy.submittingText);
      await _server.submitText(roomId!, userId!, text);
    } catch (e) {
      setError(e);
    } finally {
      appNotifier.removeBusy(Busy.submittingText);
    }
  }

  Future<void> vote(String userId, bool truthOrLie) async {
    try {
      appNotifier.addBusy(Busy.voting);
      await _server.vote(roomId!, userId, truthOrLie);
    } catch (e) {
      setError(e);
    } finally {
      appNotifier.removeBusy(Busy.voting);
    }
  }

  Future<void> startRound(String userId) async {
    try {
      appNotifier.addBusy(Busy.startingRound);
      await _server.startRound(roomId!, userId);
    } catch (e) {
      setError(e);
    } finally {
      appNotifier.removeBusy(Busy.startingRound);
    }
  }

  Future<void> endRound(String userId) async {
    try {
      appNotifier.addBusy(Busy.endingRound);
      await _server.endRound(roomId!, userId);
    } catch (e) {
      setError(e);
    } finally {
      appNotifier.removeBusy(Busy.endingRound);
    }
  }

  Future<void> reveal(String userId) async {
    try {
      appNotifier.addBusy(Busy.revealing);
      await _server.reveal(roomId!, userId);
    } catch (e) {
      setError(e);
    } finally {
      appNotifier.removeBusy(Busy.revealing);
    }
  }

  Future<void> revealNext(String userId) async {
    try {
      appNotifier.addBusy(Busy.revealingNext);
      await _server.revealNext(roomId!, userId);
    } catch (e) {
      setError(e);
    } finally {
      appNotifier.removeBusy(Busy.revealingNext);
    }
  }

  Future<void> setTruth(String userId, bool truth) async {
    try {
      appNotifier.addBusy(Busy.settingTruth);
      await _server.setTruth(roomId!, userId, truth);
    } catch (e) {
      setError(e);
    } finally {
      appNotifier.removeBusy(Busy.settingTruth);
    }
  }

  GameNotifierState get value {
    if (state.value == null) throw Exception();
    return state.value!;
  }

  void setData(GameNotifierState newState) {
    Logger().d('new GameNotifierState: $newState');
    state = AsyncData(newState);
  }

  void setError(Object e) => setData(value.copyWith(error: GameError(e)));

  RoundStatus? getRoundStatus(GameRoom game, Duration? timeRemaining) {
    final int numberOfPlayersVoted =
        GameDataFunctions.playersVoted(game, game.playerOrder[game.progress]);
    final int numberOfPlayersVoting = game.playerOrder.length - 1;

    final bool hasEveryoneVoted = numberOfPlayersVoted == numberOfPlayersVoting;
    final bool hasTimeRunOut = timeRemaining == Duration.zero;

    late RoundStatus roundStatus;

    if (!hasEveryoneVoted && !hasTimeRunOut) {
      roundStatus = RoundStatus.inProgress;
    } else {
      if (hasEveryoneVoted) {
        roundStatus = RoundStatus.endedDueToVotes;
      } else {
        roundStatus = RoundStatus.endedDueToTime;
      }
    }

    return roundStatus;
  }

  // Future<GameResult?> _getResult(String? resultId) async {
  //   if (resultId == null) return null;
  //   final result = await _db.getResult(resultId);

  //   if (result != null)
  //     Logger().d('result: ' + result.toJson().toString());
  //   else
  //     Logger().d('null result');

  //   return result;
  // }

  // Future<List<AchievementWithIcon>> _getAchievements(GameResult? result) async {
  //   if (result == null) return [];

  //   final uniqueAchievements = <String>{};

  //   for (var r in result.result) {
  //     final lists = r.playersToAchievements.values;
  //     for (var l in lists) {
  //       for (var a in l) {
  //         uniqueAchievements.add(a);
  //       }
  //     }
  //   }

  //   final List<Future<AchievementWithIcon>> futures = [];
  //   for (var a in uniqueAchievements) {
  //     final f = ref.read(achievementNotifierProvider(a).future);
  //     futures.add(f);
  //   }
  //   final achievements = await Future.wait(futures);
  //   return achievements;
  // }
}
