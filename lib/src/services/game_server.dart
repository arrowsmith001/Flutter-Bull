import 'dart:io';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

// TODO: Move to cloud
abstract class UtterBullServer {
  void createRoom(String userId);
  void joinRoom(String userId, String roomCode);

  void createPlayerWithID(Player player);

  void removeFromRoom(String userId, String roomCode);
  void setRoomPhase(
      String gameRoomId, GameRoomStatePhase newPhase, Object? newPhaseArgs);
}

class UtterBullClientSideServer implements UtterBullServer {
  UtterBullClientSideServer(this.data, this.auth) {
    for (var a in auth) {
      if (a is FakeAuthService) {
        a.streamUserId().listen((userId) async {
          if (userId != null) {
            if (await data.doesPlayerExist(userId) == false) {
              onUserCreated(userId);
            }
          }
        });
      }
    }
  }

  final List<AuthService> auth;
  final DataService data;

  void onUserCreated(String id) async {
    // TODO: Actually invoke cloud function
    final playerExists = await data.doesPlayerExist(id);
    if (!playerExists) {
      await createPlayerWithID(Player(id: id, name: 'Bob $id'));
    }
  }

  @override
  Future<void> createPlayerWithID(Player player) async {
    assert(player.id != null);
    await data.createPlayerWithID(player);
  }

  @override
  Future<void> createRoom(String userId) async {
    final func = FirebaseFunctions.instance.httpsCallable('createGameRoom');
    func.call(userId);
  }

  @override
  Future<void> joinRoom(String userId, String roomCode) async {
    final roomId = await data.getRoomIdFromCode(roomCode);
    await data.setOccupiedRoom(userId, roomId);
  }

  @override
  Future<void> removeFromRoom(String userId, String roomCode) async {
    await data.removeFromRoom(userId, roomCode);
  }

  @override
  void setRoomPhase(String roomCode, GameRoomStatePhase newPhase,
      Object? newPhaseArgs) async {
    await data.setRoomPhase(roomCode, newPhase, newPhaseArgs);
  }
}

abstract class RoomCodeGenerator {
  String generate();
}

class FiveDigit3Alpha2NumericCodeGenerator implements RoomCodeGenerator {
  static const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const numbers = '0123456789';
  final r = Random();

  @override
  String generate() {
    return List.generate(3, (_) => _getRandomLetter())
        .followedBy(List.generate(2, (_) => _getRandomNumber()))
        .join();
  }

  String _getRandomLetter() {
    return alphabet[r.nextInt(alphabet.length)];
  }

  String _getRandomNumber() {
    return numbers[r.nextInt(numbers.length)];
  }
}
