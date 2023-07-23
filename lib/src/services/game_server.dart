import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/custom/tools/utilities.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:logger/logger.dart';

abstract class UtterBullServer {
  void createRoom(String userId);
  void joinRoom(String userId, String roomCode);
  void createPlayer(String userId, String name);

  void removeFromRoom(String userId, String roomCode);
  void setRoomPhase(
      String gameRoomId, GameRoomStatePhase newPhase, Object? newPhaseArgs);
}

class UtterBullClientSideServer implements UtterBullServer {
  UtterBullClientSideServer(this.data, this.auth, this.roomCodeGenerator) {
    for (var a in auth) {
      a.streamUserId().listen((_) {
        if (a.isSignedIn) {
          onUserAuthStateChanged(a.getUserId!);
        }
      });
    }
  }

  final List<AuthService> auth;
  final DataLayer data;
  final RoomCodeGenerator roomCodeGenerator;

  void onUserAuthStateChanged(String id) async {
    final userId = id;
    final isSignedIn = userId != null;

    if (isSignedIn) {
      final playerExists = await data.doesPlayerExist(userId);
      if (!playerExists) {
        await createPlayer(userId, userId);
      }
    }
  }

  @override
  Future<void> createPlayer(String userId, String name) async {
    await data.createPlayer(Player(userId, name));
  }

  @override
  Future<void> createRoom(String userId) async {
    final code = roomCodeGenerator.generate();
    final count = await data.countRoomsByCode(code);

    if (count > 0) throw Exception('Room code "$code" already exists');

    final gameRoomId = await data.createNewGameRoom(code);
    await data.setOccupiedRoom(userId, gameRoomId);
  }

  @override
  Future<void> joinRoom(String userId, String roomCode) async {
    final room = await data.getRoomByCode(roomCode);
    await data.setOccupiedRoom(userId, room.id!);
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
