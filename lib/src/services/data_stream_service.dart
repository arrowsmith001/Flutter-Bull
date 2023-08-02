import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';

abstract class DataStreamService {
  Stream<Player> streamPlayer(String userId);
  Stream<GameRoom> streamGameRoom(String gameRoomId);

  Stream<PlayerStatus> streamPlayerStatus(String userId);
}

class FirebaseDataStreamService extends DataStreamService {
  CollectionReference<Map<String, dynamic>> collection(String collectionName) =>
      FirebaseFirestore.instance.collection(collectionName);

  @override
  Stream<GameRoom> streamGameRoom(String? gameRoomId) {
    if (gameRoomId == null) throw Exception('streamGameRoom exception');
    return collection('rooms')
        .withConverter(
            fromFirestore: (snap, _) => GameRoom.fromJson(snap.data()!),
            toFirestore: (obj, _) => obj.toJson())
        .doc(gameRoomId)
        .snapshots()
        .skipWhile((test) => !test.exists)
        .map((event) => event.data()!);
  }

  @override
  Stream<Player> streamPlayer(String userId) {
    return collection('players')
        .withConverter(
            fromFirestore: (snap, _) => Player.fromJson(snap.data()!),
            toFirestore: (obj, _) => obj.toJson())
        .doc(userId)
        .snapshots()
        .skipWhile((dataMaybe) => !dataMaybe.exists)
        .map((data) => data.data()!);
  }


  @override
  Stream<PlayerStatus> streamPlayerStatus(String userId) {
    return collection('playerStatuses')
        .withConverter(
            fromFirestore: (snap, _) => PlayerStatus.fromJson(snap.data()!),
            toFirestore: (obj, _) => obj.toJson())
        .doc(userId)
        .snapshots()
        .skipWhile((dataMaybe) => !dataMaybe.exists)
        .map((data) => data.data()!);
  }
}
