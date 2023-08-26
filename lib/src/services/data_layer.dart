import 'package:flutter_bull/src/custom/data/abstract/repository.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataService {
  Future<void> createPlayer(Player player);

  Future<int> countRoomsByCode(String code);

  Future<String> createNewGameRoom(String code);

  Future<void> setOccupiedRoom(String userId, String gameRoomId);

  Future<void> removeFromRoom(String userId, String gameRoomId);

  Future<bool> doesPlayerExist(String userId);

  Future<void> setRoomPhase(
      String roomCode, GamePhase newPhase);

  Future<String> getRoomIdFromCode(String roomCode);

  Future<void> setName(String id, String text);

  Future<void> setImagePath(String userId, String path);

}

class FakeDataLayer extends DataService implements DataStreamService {
  FakeDataLayer({List<GameRoom>? gameRoomsInit, List<Player>? playersInit}) {
    gameRooms.addAll({
      for (GameRoom room in gameRoomsInit ?? [])
        room.id!: BehaviorSubject.seeded(room)
    });
    players.addAll({
      for (Player player in playersInit ?? [])
        player.id!: BehaviorSubject.seeded(player)
    });
  }

  Map<String, BehaviorSubject<GameRoom>> gameRooms = {};
  Map<String, BehaviorSubject<Player>> players = {};

  @override
  Future<int> countRoomsByCode(String code) async {
    return gameRooms.values
        .where((element) => element.value.roomCode == code)
        .length;
  }

  @override
  Future<void> setOccupiedRoom(String userId, String gameRoomId) async {
    final playerStream = players[userId]!;
    final gameStream = gameRooms[gameRoomId]!;

    Player newPlayer = playerStream.value.copyWith(occupiedRoomId: gameRoomId);
    GameRoom newRoom = gameStream.value
        .copyWith(playerIds: [...gameStream.value.playerIds, userId]);

    playerStream.add(newPlayer);
    gameStream.add(newRoom);
  }

  @override
  Future<void> removeFromRoom(String userId, String gameRoomId) async {
    final playerStream = players[userId]!;
    final gameStream = gameRooms[gameRoomId]!;

    Player newPlayer = playerStream.value.copyWith(occupiedRoomId: null);
    GameRoom newRoom = gameStream.value.copyWith(
        playerIds:
            gameStream.value.playerIds.where((id) => id != userId).toList());

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
    return gameRooms[gameRoomId]!;
  }

  @override
  Stream<Player> streamPlayer(String? userId) {
    return players[userId]!;
  }

  @override
  Future<void> createPlayer(Player player) async {
    final newId = player.id!;
    // _newPlayerId().toString();
    players.addAll({newId: BehaviorSubject.seeded(player)});
  }

  @override
  Future<bool> doesPlayerExist(String userId) async {
    return players.keys.any((element) => element == userId);
  }

  @override
  Future<void> setRoomPhase(
      String gameRoomId, GamePhase newPhase) async {
    final gameRoomStream = gameRooms[gameRoomId]!;
    final gameRoom = gameRoomStream.value;
    final newGameRoom = gameRoom.copyWith(phase: newPhase);
    gameRoomStream.add(newGameRoom);
  }

  @override
  Future<String> createNewGameRoom(String code) async {
    final id = _newGameRoomId();
    gameRooms.addAll({id: BehaviorSubject.seeded(GameRoom(roomCode: code))});
    return id;
  }

  @override
  Future<String> getRoomIdFromCode(String roomCode) async {
    return gameRooms.keys
        .singleWhere((k) => gameRooms[k]!.value.roomCode == roomCode);
  }

  @override
  Future<void> setName(String id, String text) {
    // TODO: implement setName
    throw UnimplementedError();
  }

  @override
  Stream<bool> streamPlayerExists(String? userId) {
    throw UnimplementedError();
  }

  @override
  Stream<PlayerStatus> streamPlayerStatus(String? userId) {
    // TODO: implement streamPlayerStatus
    throw UnimplementedError();
  }
  
  @override
  Future<void> setImagePath(String userId, String path) {
    // TODO: implement setImagePath
    throw UnimplementedError();
  }
  
}

class DatabaseDrivenDataLayer extends DataService {
  DatabaseDrivenDataLayer(
      {required this.gameRoomRepo,
      required this.playerRepo,
      required this.playerStatusRepo});

  final Repository<GameRoom> gameRoomRepo;
  final Repository<Player> playerRepo;
  final Repository<PlayerStatus> playerStatusRepo;

  @override
  Future<int> countRoomsByCode(String code) async {
    return await gameRoomRepo.countByEqualsCondition('roomCode', code);
  }

  @override
  Future<void> setOccupiedRoom(String userId, String gameRoomId) async {
    await playerRepo.setField(userId, 'occupiedRoomId', gameRoomId);

    final room = await gameRoomRepo.getItemById(gameRoomId);
    await gameRoomRepo.setField(
        gameRoomId, 'playerIds', List.from(room.playerIds)..add(userId));
  }

  @override
  Future<void> createPlayer(Player player) async {
    await playerRepo.createItem(player);
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
      String roomId, GamePhase newPhase) async {
    await Future.wait([
      gameRoomRepo.setField(roomId, 'phase', newPhase)
    ]);
  }

  @override
  Future<String> createNewGameRoom(String code) async {
    return await gameRoomRepo
        .createItem(GameRoom(roomCode: code))
        .then((value) => value.id!);
  }

  @override
  Future<String> getRoomIdFromCode(String roomCode) async {
    return await gameRoomRepo
        .getItemsByField('roomCode', roomCode)
        .then((value) => value.single.id!);
  }

  @override
  Future<void> setName(String id, String text) async {
    return await playerRepo.setField(id, 'name', text);
  }
  
  @override
  Future<void> setImagePath(String userId, String path) async {
    await playerRepo.setField(userId, 'profilePhotoPath', path);
  }
  
}
