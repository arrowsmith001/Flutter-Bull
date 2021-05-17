import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/utilities/_center.dart';
import 'package:flutter_bull/utilities/profile.dart';
import 'package:uuid/uuid.dart';

abstract class DatabaseOps implements Listenable {

  Future<String?> createGame(); // => room code, if error => null

  Future<bool> joinGame(String roomCode); // => success

  Stream<Player?> streamCurrentPlayer();

  void test(dynamic args);

  Stream<Image?>? streamCurrentPlayerImage();

  Future<void> uploadProfileImage(File file);

  Future<void> setName(String name);

  Stream<String?> streamCurrentPlayerRoomCode();

  Stream<Room?>? streamRoom(String? roomCode); // => id

}

class FirebaseDatabaseOps {
  static const String FIREBASE_DATABASE_URL = 'https://flutter-bull-default-rtdb.europe-west1.firebasedatabase.app/';

  final DatabaseReference _dbRef = FirebaseDatabase(databaseURL: FIREBASE_DATABASE_URL).reference();

  static const String DB_PLAYERS = 'players';
  static const String DB_ROOMS = 'rooms';

  static const String DB_PLAYER_PROFILEID = 'profileId';
  static const String DB_OCCUPIED_ROOM_CODE = 'occupiedRoomCode';


  Stream<Player?> streamPlayer(String? userId) {
    return _dbRef.child(DB_PLAYERS).child(userId).onValue
        .map((event) => Player.fromJson(Map.from(event.snapshot.value))
    );
  }

  Future<void> setRoom(Room room) async {
    await _dbRef.child('rooms').child(room.code).set(room.toJson());
  }

  void test(dynamic args) async {

  }

  Stream<String> streamProfileExt(String userId) {
    return _dbRef.child(DB_PLAYERS).child(userId).child(DB_PLAYER_PROFILEID).onValue
        .map((event) {
      return event.snapshot.value;
    });
  }

  Future<void> setProfileId(String uid, String fileExt) async {
    await _dbRef.child(DB_PLAYERS).child(uid).child(DB_PLAYER_PROFILEID).set(fileExt);
  }

  Future<void> setName(String? userId, String name) async {
    if(userId == null) return null;
    await _dbRef.child(DB_PLAYERS).child(userId).child('name').set(name);
  }

  Future<void> setRoomOccupancy(String userId, String roomCode) {
    return _dbRef.child(DB_PLAYERS).child(userId).child(DB_OCCUPIED_ROOM_CODE).set(roomCode);
  }

  Stream<String?> streamUserRoomCode(String? userId) {
    return _dbRef.child(DB_PLAYERS).child(userId).child(DB_OCCUPIED_ROOM_CODE).onValue
        .map((event) {
      return event.snapshot.value;
    });
  }

  Stream<Room?> streamRoom(String? roomCode) {
    return _dbRef.child(DB_ROOMS).child(roomCode).onValue
        .map((event) => Room.fromJson(Map.from(event.snapshot.value))
    );
  }


}
class FirebaseFirestoreOps {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getNewGameRoomCode() async {
    const MAX_ATTEMPTS = 10;
    int numberOfAttempts = 0;

    bool exists = true;
    String code = '';

    do
    {
      code = FirebaseUtilities.generateRandomRoomCode();
      var snap = await _firestore.collection('rooms').doc(code).get();
      exists = snap.exists;
      numberOfAttempts++;
    }
    while(exists && numberOfAttempts < MAX_ATTEMPTS);

    if(exists) return null;

    return code;
  }

  createNewRoom(String roomCode) async {
    await _firestore.collection('rooms').doc(roomCode).set({
    'date_created' : DateTime.now()
    });
  }

}
class FirebaseCloudOps {
  static const String PROFILE_IMAGE_PATH = 'images/profile/';
  final FirebaseStorage _cloud = FirebaseStorage.instance;

  Stream<Image?> streamImage(String? userId) async* {
    //var data = await _cloud.ref(PROFILE_IMAGE_PATH + userId + '.jpg').
  }

  Future<Image?> getImage(String profileId) async {

    String url = await _cloud.ref(PROFILE_IMAGE_PATH + profileId).getDownloadURL();
    return Image.network(url);
  }

  Future<void> uploadProfileImage(File file, String ext) async {
    await _cloud.ref(PROFILE_IMAGE_PATH + ext).putFile(file);
  }

}
class FirebaseAuthOps {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? getCurrentUserId() => _auth.currentUser == null ?  null : _auth.currentUser!.uid;

}

class FirebaseOps extends ChangeNotifier implements DatabaseOps {

  FirebaseOps();
  FirebaseDatabaseOps rtd = FirebaseDatabaseOps();
  FirebaseFirestoreOps fs = FirebaseFirestoreOps();
  FirebaseCloudOps cloud = FirebaseCloudOps();
  FirebaseAuthOps auth = FirebaseAuthOps();

  test(dynamic args) {
    //rtd.test(_getCurrentUserId());
  }

  String? _getCurrentUserId() => auth.getCurrentUserId();


  // Object Streams

  @override
  Stream<Player?> streamCurrentPlayer() {
    return rtd.streamPlayer(_getCurrentUserId());
  }

  Future<Image?> getProfileImage(String profileId){
    return cloud.getImage(profileId);
  }

  @override
  Stream<Image?> streamCurrentPlayerImage() async* {
    var userId = _getCurrentUserId();
    if(userId == null) yield null;

    yield* rtd.streamProfileExt(userId!)
      .asyncMap((profileId) async {

        return await getProfileImage(profileId);
    });
  }

  Stream<String?> streamCurrentPlayerRoomCode() {
    return rtd.streamUserRoomCode(_getCurrentUserId());
  }

  Stream<Room?>? streamRoom(String? roomCode){
    if(roomCode == null) return null;
    return rtd.streamRoom(roomCode);
  }


  // Change notifiers
  roomCodeModel() => _roomCodeModel;
  var _roomCodeModel = RoomCodeModel();


  // User functions

  @override
  Future<void> uploadProfileImage(File file) async {
    String uid = _getCurrentUserId()!;
    String photoId = Uuid().v4();

    String fileExt = photoId + '.' + file.path.split('.').last;

    await cloud.uploadProfileImage(file, fileExt);
    await rtd.setProfileId(uid, fileExt);
  }

  @override
  Future<String?> createGame() async {

    String? userId = _getCurrentUserId();
    if(userId == null) return null;

    String? roomCode = await fs.getNewGameRoomCode();
    if(roomCode == null) throw new Exception('Could not create room. Try again later.');
    
    await fs.createNewRoom(roomCode);

    Room room = new Room()
      ..code = roomCode
      ..playerIds = [ userId ];

    await rtd.setRoom(room);
    await rtd.setRoomOccupancy(userId, roomCode);

    return roomCode;
  }

  @override
  Future<bool> joinGame(String roomCode) async {
    return true;
  }

  @override
  Future<void> setName(String name) async {
    await rtd.setName(_getCurrentUserId(), name);
  }





}

class RoomCodeModel extends ChangeNotifier {
  String? _roomCode;
  String? get roomCode => _roomCode;

  void setRoomCode(String? newRoomCode){
    bool notify = roomCode != newRoomCode && newRoomCode != null;
    _roomCode = newRoomCode;
    if(notify) notifyListeners();
  }

}

class FirebaseUtilities {

  static const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String numbers = '0123456789';

  static String generateRandomRoomCode() {
    String codeOut = '';

    Random random = new Random();

    for(int i = 0; i < 3; i++) {  codeOut = codeOut + alphabet[random.nextInt(alphabet.length)];  }

    for(int i = 0; i < 2; i++) {  codeOut = codeOut + numbers[random.nextInt(numbers.length)];  }

    return codeOut;
  }

}

class FirebaseUserNotFoundException implements Exception { }