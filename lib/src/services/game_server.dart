import 'dart:io';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/enums/game_room_state_phase.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

// TODO: Move to cloud
abstract class UtterBullServer {
  Future<void> createRoom(String userId);
  Future<void> joinRoom(String userId, String roomCode);

  Future<void> createPlayerWithID(String userId);

  Future<void> removeFromRoom(String userId, String roomCode);
  Future<void> setRoomPhase(
      String gameRoomId, GameRoomStatePhase newPhase, Object? newPhaseArgs);

  Future<void> startGame(String roomId);

  Future<void> returnToLobby(String roomId);

  Future<void> submitText(String roomId, String userId, String text);
}

class UtterBullClientSideServer implements UtterBullServer {
  UtterBullClientSideServer(this.data, this.auth) {
    for (var a in auth) {
      if (a is FakeAuthService) {
        a.streamUserId().listen((userId) async {
          if (userId != null) {
            if (await data.doesPlayerExist(userId) == false) {
              _onUserCreated(userId);
            }
          }
        });
      }
    }
  }

  final List<AuthService> auth;
  final DataService data;

  void _onUserCreated(String id) async {
    final playerExists = await data.doesPlayerExist(id);
    if (!playerExists) {
      await createPlayerWithID(id);
    }
  }

  @override
  Future<void> createPlayerWithID(String userId) async {
    final func = FirebaseFunctions.instance.httpsCallable('invokeOnUserCreate');
    await func.call(userId);
  }

  @override
  Future<void> createRoom(String userId) async {
    final func = FirebaseFunctions.instance.httpsCallable('createGameRoom');
    await func.call(userId);
  }

  @override
  Future<void> joinRoom(String userId, String roomCode) async {
    final func = FirebaseFunctions.instance.httpsCallable('joinGameRoom');
    await func.call({'userId': userId, 'roomCode': roomCode});
  }

  @override
  Future<void> removeFromRoom(String userId, String roomId) async {
    final func = FirebaseFunctions.instance.httpsCallable('removeFromRoom');
    await func.call({'userId': userId, 'roomId': roomId});
  }

  @override
  Future<void> setRoomPhase(String roomCode, GameRoomStatePhase newPhase,
      Object? newPhaseArgs) async {
    await data.setRoomPhase(roomCode, newPhase, newPhaseArgs);
  }

  @override
  Future<void> startGame(String roomId) async {
    final func = FirebaseFunctions.instance.httpsCallable('startGame');
    await func.call(roomId);
  }

  @override
  Future<void> returnToLobby(String roomId) async {
    final func = FirebaseFunctions.instance.httpsCallable('returnToLobby');
    await func.call(roomId);
  }
  
  @override
  Future<void> submitText(String roomId, String userId, String text) async {
    final func = FirebaseFunctions.instance.httpsCallable('submitText');
    await func.call({'roomId' : roomId, 'userId' : userId, 'text' : text});
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
