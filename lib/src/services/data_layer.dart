import 'package:flutter_bull/src/custom/data/abstract/database_service.dart';
import 'package:flutter_bull/src/custom/data/abstract/repository.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/local_achievement_service.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataService {
  Future<void> createPlayer(Player player);

  Future<int> countRoomsByCode(String code);

  Future<String> createNewGameRoom(String code);

  Future<void> setOccupiedRoom(String userId, String gameRoomId);

  Future<void> removeFromRoom(String userId, String gameRoomId);

  Future<bool> doesPlayerExist(String userId);

  Future<void> setRoomPhase(String roomCode, GamePhase newPhase);

  Future<String> getRoomIdFromCode(String roomCode);

  Future<void> setName(String id, String text);

  Future<void> setImagePath(String userId, String path);

  Future<GameResult?> getResult(String resultId);

  Future<Achievement> getAchievement(String achievementId);

  Future<Map<String, Achievement>> getAllAchievements();

  Future<void> setPlayerState(
      String roomId, String userId, PlayerState playerState);

  Future<void> setTruth(String roomId, String userId, bool truth);
}

class DatabaseDrivenDataLayer extends DataService {
  DatabaseDrivenDataLayer({
    required this.gameRoomRepo,
    required this.playerRepo,
    required this.playerStatusRepo,
    required this.resultRepo,
    required this.achievementRepo,
  });

  final Repository<GameRoom> gameRoomRepo;
  final Repository<Player> playerRepo;
  final Repository<PlayerStatus> playerStatusRepo;
  final Repository<GameResult> resultRepo;
  final Repository<Achievement> achievementRepo;

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
  Future<void> setRoomPhase(String roomId, GamePhase newPhase) async {
    await Future.wait([gameRoomRepo.setField(roomId, 'phase', newPhase)]);
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

  @override
  Future<GameResult?> getResult(String resultId) async {
    return await resultRepo.getItemById(resultId);
  }

  @override
  Future<Achievement> getAchievement(String achievementId) async {
    return await achievementRepo.getItemById(achievementId);
  }

  @override
  Future<Map<String, Achievement>> getAllAchievements() async {
    final List<Achievement> achievementsByIds = await achievementRepo
        .getItemsByIds(AchievementId.values.map((e) => e.name));

    return {for (Achievement ach in achievementsByIds) ach.id!: ach};
  }

  @override
  Future<void> setPlayerState(
      String roomId, String userId, PlayerState playerState) async {
    return await gameRoomRepo.setField(
        roomId, 'playerStates.$userId', playerState.index);
  }

  @override
  Future<void> setTruth(String roomId, String userId, bool truth) async {
    return await gameRoomRepo.setField(roomId, 'truths.$userId', truth);
  }
}

class InMemoryDataLayer extends DataService implements DataStreamService {
  InMemoryDataLayer(
      {List<GameRoom>? gameRoomsInit, List<Player>? playersInit}) {
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
  Future<void> setRoomPhase(String gameRoomId, GamePhase newPhase) async {
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

  @override
  Future<GameResult?> getResult(String resultId) {
    // TODO: implement getResult
    throw UnimplementedError();
  }

  @override
  Future<Achievement> getAchievement(String achievementId) {
    // TODO: implement getAchievement
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Achievement>> getAllAchievements() {
    // TODO: implement getAllAchievements
    throw UnimplementedError();
  }

  @override
  Future<void> setPlayerState(
      String roomId, String userId, PlayerState playerState) {
    // TODO: implement setPlayerState
    throw UnimplementedError();
  }

  @override
  Future<void> setTruth(String roomId, String userId, bool truth) {
    // TODO: implement setTruth
    throw UnimplementedError();
  }
}

class StaticDataLayer extends DataService implements DataStreamService {
  StaticDataLayer(this.game, this.players);

  final GameRoom game;
  final Map<String, Player> players;

  final LocalAchievementService achievementService = LocalAchievementService();

  void staticSetRoom(GameRoom newGame) {
    gameStream.add(newGame);
  }

  late BehaviorSubject<GameRoom> gameStream = BehaviorSubject.seeded(game);
  //late BehaviorSubject<Map<String, Player>> playersStream = BehaviorSubject.seeded(game);

  @override
  Stream<GameRoom> streamGameRoom(String gameRoomId) {
    return gameStream;
  }

  @override
  Stream<Player> streamPlayer(String userId) {
    return Stream.value(players[userId]!);
  }

  @override
  Future<int> countRoomsByCode(String code) {
    // TODO: implement countRoomsByCode
    throw UnimplementedError();
  }

  @override
  Future<String> createNewGameRoom(String code) {
    // TODO: implement createNewGameRoom
    throw UnimplementedError();
  }

  @override
  Future<void> createPlayer(Player player) {
    // TODO: implement createPlayer
    throw UnimplementedError();
  }

  @override
  Future<bool> doesPlayerExist(String userId) {
    // TODO: implement doesPlayerExist
    throw UnimplementedError();
  }

  @override
  Future<Achievement> getAchievement(String achievementId) {
    return achievementService.read(achievementId);
  }

  @override
  Future<Map<String, Achievement>> getAllAchievements() async {
    return Map.fromEntries(
        achievementService.getAll().map((e) => MapEntry(e.id!, e)));
  }

  @override
  Future<GameResult?> getResult(String resultId) {
    // TODO: implement getResult
    throw UnimplementedError();
  }

  @override
  Future<String> getRoomIdFromCode(String roomCode) {
    // TODO: implement getRoomIdFromCode
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromRoom(String userId, String gameRoomId) {
    // TODO: implement removeFromRoom
    throw UnimplementedError();
  }

  @override
  Future<void> setImagePath(String userId, String path) {
    // TODO: implement setImagePath
    throw UnimplementedError();
  }

  @override
  Future<void> setName(String id, String text) {
    // TODO: implement setName
    throw UnimplementedError();
  }

  @override
  Future<void> setOccupiedRoom(String userId, String gameRoomId) {
    // TODO: implement setOccupiedRoom
    throw UnimplementedError();
  }

  @override
  Future<void> setRoomPhase(String roomCode, GamePhase newPhase) {
    // TODO: implement setRoomPhase
    throw UnimplementedError();
  }

  @override
  Stream<PlayerStatus> streamPlayerStatus(String userId) {
    // TODO: implement streamPlayerStatus
    throw UnimplementedError();
  }

  @override
  Future<void> setPlayerState(
      String roomId, String userId, PlayerState playerState) {
    // TODO: implement setPlayerState
    throw UnimplementedError();
  }

  @override
  Future<void> setTruth(String roomId, String userId, bool truth) async {
    staticSetRoom(gameStream.value.copyWith(
        truths: gameStream.value.truths.map(
            (key, value) => MapEntry(key, key == userId ? truth : value))));
  }
}
