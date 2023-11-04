import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/services/data_layer.dart';

// TODO: Move to cloud
abstract class UtterBullServer {
  Future<void> createRoom(String userId);
  Future<void> joinRoom(String userId, String roomCode);

  Future<void> createPlayerWithID(String userId);

  Future<void> removeFromRoom(String userId, String roomId);
  Future<void> setRoomPhase(String gameRoomId, GamePhase newPhase);

  Future<void> startGame(String roomId);

  Future<void> returnToLobby(String roomId);

  Future<void> submitText(String roomId, String userId, String? text);

  Future<void> startRound(String roomId, String userId);

  Future<void> vote(String roomId, String userId, bool truthOrLie);

  Future<void> endRound(String roomId, String userId);

  Future<void> setSubPhase(String roomId, int phaseNum);

  Future<void> reveal(String roomId, String userId);

  Future<void> revealNext(String roomId, String userId);

  Future<void> calculateResults(String roomId);

  Future<void> setPlayerState(
      String roomId, String userId, PlayerState playerState);

  Future<void> setTruth(String roomId, String userId, bool truth);
}

class UtterBullClientSideServer implements UtterBullServer {
  UtterBullClientSideServer(this.data, [this.auth]) {
    for (var a in auth ?? []) {
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

  final List<AuthService>? auth;
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
  Future<void> setRoomPhase(String roomCode, GamePhase newPhase) async {
    await data.setRoomPhase(roomCode, newPhase);
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
  Future<void> submitText(String roomId, String userId, String? text) async {
    final func = FirebaseFunctions.instance.httpsCallable('submitText');
    await func.call({'roomId': roomId, 'userId': userId, 'text': text});
  }

  @override
  Future<void> startRound(String roomId, String userId) async {
    final func = FirebaseFunctions.instance.httpsCallable('startRound');
    await func.call({'roomId': roomId, 'userId': userId});
  }

  @override
  Future<void> vote(String roomId, String userId, bool truthOrLie) async {
    final func = FirebaseFunctions.instance.httpsCallable('vote');
    await func
        .call({'roomId': roomId, 'userId': userId, 'truthOrLie': truthOrLie});
  }

  @override
  Future<void> endRound(String roomId, String userId) async {
    final func = FirebaseFunctions.instance.httpsCallable('endRound');
    await func.call({'roomId': roomId, 'userId': userId});
  }

  // TODO: Deprecate?
  @override
  Future<void> setSubPhase(String roomId, int phaseNum) async {
    final func = FirebaseFunctions.instance.httpsCallable('setSubPhase');
    await func.call({'roomId': roomId, 'phaseNum': phaseNum});
  }

  @override
  Future<void> reveal(String roomId, String userId) async {
    final func = FirebaseFunctions.instance.httpsCallable('reveal');
    await func.call({'roomId': roomId, 'userId': userId});
  }

  @override
  Future<void> revealNext(String roomId, String userId) async {
    final func = FirebaseFunctions.instance.httpsCallable('revealNext');
    await func.call({'roomId': roomId, 'userId': userId});
  }

  @override
  Future<void> calculateResults(String roomId) async {
    final func = FirebaseFunctions.instance.httpsCallable('calculateResults');
    await func.call({'roomId': roomId});
  }

  @override
  Future<void> setPlayerState(
      String roomId, String userId, PlayerState playerState) async {
    await data.setPlayerState(roomId, userId, playerState);
  }
  
  @override
  Future<void> setTruth(String roomId, String userId, bool truth) async {
    await data.setTruth(roomId, userId, truth);
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

class MockServer extends UtterBullServer {
  @override
  Future<void> calculateResults(String s) async {}

  @override
  Future<void> createPlayerWithID(String userId) async {}

  @override
  Future<void> createRoom(String userId) async {}

  @override
  Future<void> endRound(String roomId, String userId) async {}

  @override
  Future<void> joinRoom(String userId, String roomCode) async {}

  @override
  Future<void> removeFromRoom(String userId, String roomId) async {}

  @override
  Future<void> returnToLobby(String roomId) async {}

  @override
  Future<void> reveal(String roomId, String userId) async {}

  @override
  Future<void> revealNext(String roomId, String userId) async {}

  @override
  Future<void> setRoomPhase(String gameRoomId, GamePhase newPhase) async {}

  @override
  Future<void> setSubPhase(String roomId, int phaseNum) async {}

  @override
  Future<void> startGame(String roomId) async {}

  @override
  Future<void> startRound(String roomId, String userId) async {}

  @override
  Future<void> submitText(String roomId, String userId, String? text) async {}

  @override
  Future<void> vote(String roomId, String userId, bool truthOrLie) async {}

  @override
  Future<void> setPlayerState(
      String roomId, String userId, PlayerState playerState) async {}
      
        @override
        Future<void> setTruth(String roomId, String userId, bool truth) async {
        }
}
