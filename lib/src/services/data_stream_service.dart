import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';

abstract class DataStreamService {
  Stream<Player> streamPlayer(String? userId);
  Stream<GameRoom> streamGameRoom(String? gameRoomId);

  Stream<bool> streamPlayerExists(String? userId);
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
        .map((event) => event.data()!);
  }

  @override
  Stream<Player> streamPlayer(String? userId) {
    if (userId == null) throw Exception('streamPlayer exception');
    return collection('players')
        .withConverter(
            fromFirestore: (snap, _) => Player.fromJson(snap.data()!),
            toFirestore: (obj, _) => obj.toJson())
        .doc(userId)
        .snapshots()
        .map((event) => event.data()!);
  }
  
  @override
  Stream<bool> streamPlayerExists(String? userId) async* {
    
    if (userId == null) yield false;
    else yield* collection('players')
        .doc(userId)
        .snapshots()
        .map((event) => event.exists);
  }
}
