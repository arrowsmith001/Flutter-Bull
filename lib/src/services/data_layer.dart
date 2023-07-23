import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bull/src/custom/data/abstract/repository.dart';
import 'package:flutter_bull/src/custom/tools/utilities.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataLayer {

  Future<String> createPlayer(Player player);

  Future<int> countRoomsByCode(String code);

  Future<String> createNewGameRoom(String code);

  Future<void> setOccupiedRoom(String userId, String gameRoomId);

  Future<void> removeFromRoom(String userId, String gameRoomId);

  Future<GameRoom> getRoomByCode(String code);

  Future<bool> doesPlayerExist(String userId);

  Future<void> setRoomPhase(
      String roomCode, GameRoomStatePhase newPhase, Object? newPhaseArgs);
}

class FakeDataLayer extends DataLayer implements DataStreamService {
  List<BehaviorSubject<GameRoom>> gameRooms = [];
  List<BehaviorSubject<Player>> players = [];

  @override
  Future<int> countRoomsByCode(String code) async {
    return gameRooms.where((element) => element.value.roomCode == code).length;
  }

  @override
  Future<String> createNewGameRoom(String code) async {
    final newId = _newGameRoomId().toString();
    gameRooms.add(BehaviorSubject.seeded(
        GameRoom(newId, code, GameRoomStatePhase.lobby, null)));
    return newId;
  }

  @override
  Future<GameRoom> getRoomByCode(String code) async {
    return gameRooms
        .where((element) => element.value.roomCode == code)
        .single
        .value;
  }

  @override
  Future<void> setOccupiedRoom(String userId, String gameRoomId) async {
    final playerStream =
        players.where((element) => element.value.id == userId).single;
    final gameStream =
        gameRooms.where((element) => element.value.id == gameRoomId).single;

    Player newPlayer =
        playerStream.value.cloneWithUpdates({'occupiedRoomId': gameRoomId});
    GameRoom newRoom = gameStream.value.cloneWithUpdates(
        {'playerIds': List.from(gameStream.value.playerIds)..add(userId)});

    //Logger().d('clonedPlayer: ${newPlayer.toJson()}');
    playerStream.add(newPlayer);
    gameStream.add(newRoom);
  }

  @override
  Future<void> removeFromRoom(String userId, String gameRoomId) async {
    final playerStream =
        players.where((element) => element.value.id == userId).single;
    final gameStream =
        gameRooms.where((element) => element.value.id == gameRoomId).single;

    Player newPlayer = Player.fromJson(
        playerStream.value.clone().toJson()..remove('occupiedRoomId'));
    GameRoom newRoom = gameStream.value.cloneWithUpdates(
        {'playerIds': List.from(gameStream.value.playerIds)..remove(userId)});

    //Logger().d('clonedPlayer: ${newPlayer.toJson()}');
    playerStream.add(newPlayer);
    gameStream.add(newRoom);
  }

  String _newGameRoomId() {
    return (gameRooms.length + 1).toString();
  }

  String _newPlayerId() {
    return (players.length + 1).toString();
  }

  @override
  Stream<GameRoom> streamGameRoom(String? gameRoomId) {
    return gameRooms.singleWhere((element) => element.value.id == gameRoomId);
  }

  @override
  Stream<Player> streamPlayer(String? userId) {
    return players.singleWhere((element) => element.value.id == userId);
  }

  @override
  Future<String> createPlayer(Player player) async {
    final newId = _newPlayerId().toString();
    players.add(BehaviorSubject.seeded(player));
    return newId;
  }

  @override
  Future<bool> doesPlayerExist(String userId) async {
    return players.any((element) => element.value.id == userId);
  }

  @override
  Future<void> setRoomPhase(String gameRoomId, GameRoomStatePhase newPhase,
      Object? newPhaseArgs) async {
    final gameRoomStream =
        gameRooms.singleWhere((element) => element.value.id == gameRoomId);
    final gameRoom = gameRoomStream.value;
    final newGameRoom = gameRoom
        .cloneWithUpdates({'phase': newPhase, 'phaseArgs': newPhaseArgs});
    gameRoomStream.add(newGameRoom);
  }
}

class DatabaseDrivenDataLayer extends DataLayer {
  
  DatabaseDrivenDataLayer({required this.gameRoomRepo, required this.playerRepo});

  final Repository<GameRoom> gameRoomRepo;
  final Repository<Player> playerRepo;
  
  @override
  Future<int> countRoomsByCode(String code) async {
    return await gameRoomRepo.countByEqualsCondition('roomCode', code);
  }

  @override
  Future<String> createNewGameRoom(String code) async {
    return await gameRoomRepo
        .createItem(GameRoom(null, code, GameRoomStatePhase.lobby, null))
        .then((value) => value.id!);
  }

  @override
  Future<void> setOccupiedRoom(String userId, String gameRoomId) async {
    await playerRepo.setField(userId, 'occupiedRoomId', gameRoomId);

    final room = await gameRoomRepo!.getItemById(gameRoomId);
    await gameRoomRepo!.setField(
        gameRoomId, 'playerIds', List.from(room.playerIds)..add(userId));
  }

  @override
  Future<GameRoom> getRoomByCode(String code) async {
    return await gameRoomRepo
        .getItemsByField('roomCode', code)
        .then((value) => value.single);
  }

  @override
  Future<String> createPlayer(Player player) async {
    return await playerRepo.createItem(player).then((value) => value.id!);
  }

  @override
  Future<bool> doesPlayerExist(String userId) async {
    return await playerRepo.itemExists(userId);
  }

  @override
  Future<void> removeFromRoom(String userId, String gameRoomId) async {
    await playerRepo.setField(userId, 'occupiedRoomId', null);

    final room = await gameRoomRepo!.getItemById(gameRoomId);
    await gameRoomRepo.setField(
        gameRoomId, 'playerIds', List.from(room.playerIds)..remove(userId));
  }

  @override
  Future<void> setRoomPhase(
      String roomId, GameRoomStatePhase newPhase, Object? newPhaseArgs) async {

    await Future.wait([
      gameRoomRepo.setField(roomId, 'phase', newPhase),
      gameRoomRepo.setField(roomId, 'phaseArgs', newPhaseArgs)
    ]);
  }
}
