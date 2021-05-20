import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/utilities/firebase.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class Repository {

  late BehaviorSubject<Room?> currentRoomController;
  late StreamSubscription currentRoomCodeSub, currentRoomSub;

  Map<String, Stream<Player>> _playerStreams = {};

  Repository(){

    // currentRoomController = BehaviorSubject<Room?>();
    //
    // currentRoomCodeSub = _firebaseProvider.streamCurrentPlayerRoomCode()
    //     .listen((roomCode)
    // {
    //   currentRoomSub = _firebaseProvider.streamRoom(roomCode)
    //       .listen((room)
    //   {
    //
    //     if(room != null)
    //     {
    //       List<Stream<Player>> list = [];
    //
    //       for(String id in room.playerIds)
    //      {
    //        if(!_playerStreams.containsKey(id))
    //          {
    //            var playerAndImageStream = CombineLatestStream.combine2<Player, Image?, Player>(
    //                streamPlayer(id), streamPlayerImage(id), (player, image)
    //            {
    //              player.profileImage = image;
    //              return player;
    //            });
    //            _playerStreams.addAll({id : playerAndImageStream});
    //          }
    //
    //         var s = _playerStreams[id]!;
    //         list.add(s);
    //       }
    //
    //       var s = CombineLatestStream.list(list);
    //       s.listen((value) {
    //         room.players = value;
    //         for(Player p in room.players) print(p.toJson().toString());
    //         currentRoomController.add(room);
    //       });
    //
    //
    //     }
    //   });
    // });

  }

  void dispose(){
    currentRoomCodeSub.cancel();
    currentRoomSub.cancel();
  }


  final _firebaseProvider = FirebaseProvider();

  Stream<String?> streamCurrentUserId(){
    return _firebaseProvider.streamCurrentUserId();
  }

  Stream<Player?> streamPlayer(String userId) {
    return _firebaseProvider.streamPlayer(userId);
  }

  Stream<Map<String, dynamic>> streamPlayerChanges(String userId) {
    return _firebaseProvider.streamPlayerChanges(userId);
  }

  Future<Image?> getProfileImage(String? profileId) {
    return _firebaseProvider.getProfileImage(profileId);
  }

  Future<String?> uploadProfileImage(File file) async {
    return await _firebaseProvider.uploadProfileImage(file);
  }

  Future<void> setPlayerField(String userId, String childId, dynamic value) async {
    await _firebaseProvider.setPlayerField(userId, childId, value);
  }


  Stream<Map<String,dynamic>> streamChildChanges(List<String> path) {
    return _firebaseProvider.streamChildChanges(path);
  }
  Stream<Map<String,dynamic>> streamChildAdditions(List<String> path) {
    return _firebaseProvider.streamChildAdditions(path);
  }
  Stream<Map<String,dynamic>> streamChildRemovals(List<String> path) {
    return _firebaseProvider.streamChildRemovals(path);
  }


///////////////////////




  Stream<Room?> streamCurrentPlayerRoom() {
    return currentRoomController.stream;
  }


  Future<String> getPrivacyPolicyString() async {
    return await _firebaseProvider.getPrivacyPolicyString();
  }

  Future<void> uploadPlayerName(String name) async {
    return await _firebaseProvider.setName(name);
  }

  Future<String?> createGame(String userId) async {
    return await _firebaseProvider.createGame(userId);
  }

  Stream<T> streamPlayerField<T>(String userId, String fieldName) {
    return _firebaseProvider.streamPlayerField<T>(userId, fieldName);
  }

  Stream<Room?> streamRoom(String roomCode) {
    return _firebaseProvider.streamRoom(roomCode);
  }

  // Stream<Image?> streamPlayerImage(String id) {
  //   return _firebaseProvider.streamPlayerImage(id);
  // }





}