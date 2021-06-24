import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/utilities/misc.dart';
import 'package:flutter_bull/utilities/profile.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bull/classes/classes.dart';

import '../widgets.dart';

// Assumes FirebaseApp has been initialized
class FirebaseProvider {

  FirebaseProvider();

  FirebaseDatabaseProvider rtd = FirebaseDatabaseProvider();
  FirebaseFirestoreProvider fs = FirebaseFirestoreProvider();
  FirebaseCloudProvider cloud = FirebaseCloudProvider();
  FirebaseAuthProvider auth = FirebaseAuthProvider();

  Stream<String?> streamCurrentUserId() => auth.streamCurrentUserId();

  Stream<Player?> streamPlayer(String id) {
    return rtd.streamPlayer(id);
  }

  Stream<Map<String,dynamic>> streamPlayerChanges(String userId) {
    return rtd.streamPlayerChanges(userId);
  }

  Future<void> setPlayerField(String userId, String fieldId, dynamic value) async {
    await rtd.setPlayerField(userId, fieldId, value);
  }

  Stream<Map<String,dynamic>> streamChildChanges(List<String> path) {
    return rtd.streamChildChanges(path);
  }
  Stream<Map<String,dynamic>> streamChildAdditions(List<String> path) {
    return rtd.streamChildAdditions(path);
  }
  Stream<Map<String,dynamic>> streamChildRemovals(List<String> path) {
    return rtd.streamChildRemovals(path);
  }



  // Object Streams


  Future<Image?> getProfileImage(String? profileId){
    return cloud.getProfileImage(profileId);
  }




  Stream<Room?> streamRoom(String? roomCode){
    return rtd.streamRoom(roomCode);
  }


  Future<String?> uploadProfileImage(File file) async {
    String photoId = Uuid().v4();

    String fileExt = photoId + '.' + file.path.split('.').last;

    await cloud.uploadProfileImage(file, fileExt);

    return fileExt;
  }

  Future<void> setProfileId(String userId, String fileExt) async
  {
    await rtd.setProfileId(userId, fileExt);
  }

  // User functions







  @override
  Future<String?> createGame(String userId) async {

    String? roomCode = await fs.getNewGameRoomCode();
    if(roomCode == null) throw new Exception('Could not create room. Try again later.');

    await fs.createNewRoom(roomCode);

    Room room = new Room.created(roomCode, userId);

    await rtd.setRoom(room);
    await rtd.setRoomOccupancy(userId, roomCode);

    return roomCode;
  }

  @override
  Future<bool> joinGame(String userId, String roomCode) async {
    bool roomExists = await fs.doesRoomExist(roomCode);
    if(!roomExists) return false;
    return await rtd.joinRoom(userId, roomCode);
  }

  @override
  Future<void> setName(String name) async {
    //await rtd.setName(_getCurrentUserId(), name);
  }

  Future<String> getPrivacyPolicyString() async {
    return await fs.getFieldFromDocumentFromCollection('content','privacy_policy','strings');
  }

  Stream<T> streamPlayerField<T>(String userId, String fieldName) {
    return rtd.streamPlayerField<T>(userId, fieldName);
  }

  Future<bool> setRoomLockedStatus(String roomCode, bool locked) async {
    return await fs.setFieldsInDocumentInCollection({'locked' : locked}, roomCode, 'rooms');
  }

  Future<void> updateRoom(Room room) async {
    return rtd.updateRoom(room);
  }

  Future<bool> setRoomField(String roomCode, List<String> path, dynamic value) async {
    return await rtd.setRoomField(roomCode, path, value);
  }

  Future<bool> setRoomFields(String roomCode, Map<String, dynamic> changes, [List<String> path = const []]) async {
    return await rtd.setRoomFields(roomCode, changes, path);
  }

  Future<bool> pushVote(String userId, String roomCode, Vote vote, int turn) async {
    return await rtd.pushVote(userId, roomCode, vote, turn);
  }

  Future<bool> leaveGame(String userId, String roomCode) async {
    // TODO Delete room in firestore and rtd
    try {
      return await rtd.removePlayerFromRoom(userId, roomCode);
    }catch(e)
    {
      Utils.printError(this, 'leaveGame', e);
      return false;
    }
  }

}

class FirebaseDatabaseProvider {
  static const String FIREBASE_DATABASE_URL = 'https://flutter-bull-default-rtdb.europe-west1.firebasedatabase.app/';

  final DatabaseReference _dbRef = FirebaseDatabase(databaseURL: FIREBASE_DATABASE_URL).reference();

  static const String DB_PLAYERS = 'players';
  static const String DB_ROOMS = 'rooms';


  Stream<Player?> streamPlayer(String? userId) {
      return _dbRef.child(DB_PLAYERS).child(userId!).onValue.map((event) =>
          event.snapshot.value == null
              ? null
              : Player.fromJson(Map.from(event.snapshot.value)));
  }

  Stream<Map<String,dynamic>> streamPlayerChanges(String userId) {
    return _dbRef.child(DB_PLAYERS).child(userId).onChildChanged
        .map((event) => {event.snapshot.key! : event.snapshot.value});
  }

  Stream<Map<String,dynamic>> streamChildChanges(List<String> path) {
    DatabaseReference ref = _dbRef.reference();
    for(String s in path) ref = ref.child(s);
    return ref.onChildChanged
        .map((event) => {event.snapshot.key! : event.snapshot.value});
  }
  Stream<Map<String,dynamic>> streamChildAdditions(List<String> path) {
    DatabaseReference ref = _dbRef.reference();
    for(String s in path) ref = ref.child(s);
    return ref.onChildAdded
        .map((event) => {event.snapshot.key! : event.snapshot.value});
  }
  Stream<Map<String,dynamic>> streamChildRemovals(List<String> path) {
    DatabaseReference ref = _dbRef.reference();
    for(String s in path) ref = ref.child(s);
    return ref.onChildRemoved
        .map((event) => {event.snapshot.key! : event.snapshot.value});
  }


  Future<void> setRoom(Room room) async {
    print(room.toJson().toString());
    await _dbRef.child('rooms').child(room.code!).set(room.toJson());
  }

  Future<void> updateRoom(Room room) async {
    await _dbRef.child('rooms').child(room.code!).update(room.toJson());
  }


  Stream<T> streamPlayerField<T>(String userId, String fieldName) {
    return _dbRef.child(DB_PLAYERS).child(userId).child(fieldName).onValue
        .map((event) => event.snapshot.value as T);
  }

  Future<bool> joinRoom(String userId, String roomCode) async {

    TransactionResult transactionResult;
    bool success = false;
    bool playerAddedToRoom = false;

    int attempts = 0;
    const int MAX_ATTEMPTS = 1;

    var data = await _dbRef.child('rooms').child(roomCode).once(); // Why the fuck should I have to do this for it to work?

    do {
      try{
        transactionResult = await _dbRef.child('rooms').child(roomCode).runTransaction((data) async {

          Room room = Room.fromJson(Map.from(data.value));

          List<String>? ids = room.playerIds;
          Map<String, int>? scores = room.playerScores;

          if(ids == null) room.playerIds = [userId];
          if(scores == null) room.playerScores = {userId : 0};

          if(!room.playerIds!.contains(userId))
          {
            room.playerIds!.add(userId);
            room.playerScores!.addAll({userId : 0});
            playerAddedToRoom = true;
          }
          data.value = room.toJson();

          return data;
        });
        success = (transactionResult.committed);
      }
      catch(e)
      {
        print('Join room error: ' + e.toString());
        playerAddedToRoom = false;
      }

      attempts++;
    }
    while(success == false && attempts < MAX_ATTEMPTS);

    if(success == false) return false;

    await setRoomOccupancy(userId, roomCode);
    return true;
  }

  Stream<String> streamProfileExt(String userId) {
    return _dbRef.child(DB_PLAYERS).child(userId).child(Player.PROFILE_ID).onValue
        .map((event) {
      return event.snapshot.value;
    });
  }

  Future<void> setProfileId(String uid, String fileExt) async {
  }

  Future<void> setPlayerField(String userId, [String fieldId = '', value]) async {
    await _dbRef.child(DB_PLAYERS).child(userId).child(fieldId).set(value);
  }



  Future<void> setName(String? userId, String name) async {
    if(userId == null) return null;
    await _dbRef.child(DB_PLAYERS).child(userId).child('name').set(name);
  }

  Future<void> setRoomOccupancy(String userId, String? roomCode) async {
    return await _dbRef.child(DB_PLAYERS).child(userId).child(Player.OCCUPIED_ROOM_CODE).set(roomCode);
  }

  Stream<String?> streamUserRoomCode(String? userId) {
    return _dbRef.child(DB_PLAYERS).child(userId!).child(Player.OCCUPIED_ROOM_CODE).onValue
        .map((event) {
      return event.snapshot.value;
    });
  }

  Stream<Room?> streamRoom(String? roomCode) {
    return _dbRef.child(DB_ROOMS).child(roomCode!).onValue
        .map((event) => event.snapshot.value == null ? null : Room.fromJson(Map.from(event.snapshot.value))
    );
  }

  Future<bool> setRoomField(String roomCode, List<String> path, dynamic value) async {
    DatabaseReference ref = _dbRef.child('rooms').child(roomCode);
    for(String s in path) ref = ref.child(s);
    await ref.set(value);
    return true;
  }

  Future<bool> setRoomFields(String roomCode, Map<String, dynamic> changes, [List<String> path = const []]) async {
    DatabaseReference ref = _dbRef.child('rooms').child(roomCode);
    for(String s in path) ref = ref.child(s);
    await ref.update(changes);
    return true;
  }

  Future<bool> pushVote(String userId, String roomCode, Vote vote, int turn) async {
    TransactionResult result;
    bool success = false;
    const int MAX_ATTEMPTS = 1;
    int attempts = 0;

    int votesLength = 0;

    do{
      try{
        result = await _dbRef.child('rooms').child(roomCode).child(Room.PLAYER_VOTES).child(userId)
            .runTransaction((data) async
        {

          List votes;
          if(data.value == null) votes = [vote.toJson()];
          else
            {
              votes = List.from(data.value as List);
              votesLength = votes.length;
              assert(votesLength <= turn);
              votes.add(vote.toJson());
            }
          data.value = votes;
          return data;

        });
        success = (result.committed);
      }catch(e)
      {
        print(e.toString());
        //print('VL: ${votesLength.toString()} TURN: ${turn.toString()}');
        success = false;
      }
      attempts++;
    }while(attempts < MAX_ATTEMPTS && success == false);

    return success;

  }

  Future<bool> setAllChildValuesAt(List<String> list, value) async {
    DatabaseReference ref = _dbRef.reference();
    for(String s in list) ref = ref.child(s);
    TransactionResult result;
    bool success = false;
    result = await ref.runTransaction((data) async {
      Map map = Map<String, dynamic>.from(data.value as Map);
      for(String key in map.keys)
        {
          map[key] = value;
        }
      data.value = map;
      return await data;
    });
    success = result.committed;
    return success;
  }

  Future<bool> removePlayerFromRoom(String userId, String roomCode) async {
    TransactionResult transactionResult;
    bool success = false;

    int attempts = 0;
    const int MAX_ATTEMPTS = 10;

    do {
      try{
        transactionResult = await _dbRef.child('rooms').child(roomCode).runTransaction((data) async {

          Room room = Room.fromJson(Map.from(data.value));
          List<String>? ids = room.playerIds;
          Map<String, int>? scores = room.playerScores;

          // if(ids == null) room.playerIds = [userId];
          // if(scores == null) room.playerScores = {userId : 0};

          if(room.playerIds!.contains(userId))
          {
            room.playerIds!.remove(userId);
            room.playerScores!.remove(userId);
          }
          data.value = room.toJson();
          return data;
        });
        success = (transactionResult.committed);
      }
      catch(e)
      {
        print('Leave room error: ' + e.toString());
      }

      attempts++;
    }
    while(success == false && attempts < MAX_ATTEMPTS);

    if(success == false) return false;

    await setRoomOccupancy(userId, null);
    return true;
  }



}
class FirebaseFirestoreProvider {
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

  Future<void> createNewRoom(String roomCode) async {
    await _firestore.collection('rooms').doc(roomCode).set({
    'date_created' : DateTime.now()
    });
  }

  Future<dynamic> getFieldFromDocumentFromCollection(String field, String document, String collection) async {
    var task = await _firestore.collection(collection).doc(document).get();
    var data = task.data();
    if(data == null) return null;
    return data[field];
  }

  Future<bool> setFieldsInDocumentInCollection(Map<String, dynamic> values, String document, String collection) async {
    await _firestore.collection(collection).doc(document).set(values, SetOptions(merge: true));
    return true;
  }

  Future<bool> doesRoomExist(String roomCode) async {
    var task = await _firestore.collection('rooms').doc(roomCode).get();
    return task.exists;
  }


}
class FirebaseCloudProvider {
  static const String PROFILE_IMAGE_PATH = 'images/profile/';
  final FirebaseStorage _cloud = FirebaseStorage.instance;

  Stream<Image?> streamImage(String? userId) async* {
    //var data = await _cloud.ref(PROFILE_IMAGE_PATH + userId + '.jpg').
  }

  Future<Image?> getProfileImage(String? profileId) async {

    try{

      Uint8List? data = await _cloud.ref(PROFILE_IMAGE_PATH + profileId!).getData();
      return Image.memory(data!);

    }catch(e)
    {
      print('ERROR: ${this.runtimeType.toString()} ${e.toString()}');
      return null;
    }
  }

  Future<void> uploadProfileImage(File file, String ext) async {
    await _cloud.ref(PROFILE_IMAGE_PATH + ext).putFile(file);
  }

}
class FirebaseAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<String?> streamCurrentUserId() => _auth.authStateChanges().map((user) => user == null ? null : user.uid);

}
class FirebaseMessagingProvider{
  FirebaseMessagingProvider() {
    // _messaging.requestPermission(
    //     alert: true,
    //     badge: true,
    //     provisional: false,
    //     sound: true
    // ).whenComplete(() {
    //   print('FirebaseMessagingProvider : permissions requested');
    // });
    //
    // void pushNotification(){
    //
    // }
  }

  //FirebaseMessaging _messaging = FirebaseMessaging.instance;
  
  void pushMessage(){

  }
}



// class RoomCodeModel extends ChangeNotifier {
//   String? _roomCode;
//   String? get roomCode => _roomCode;
//
//   void setRoomCode(String? newRoomCode){
//     bool notify = roomCode != newRoomCode && newRoomCode != null;
//     _roomCode = newRoomCode;
//     if(notify) notifyListeners();
//   }
//
// }

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