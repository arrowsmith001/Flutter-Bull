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

    currentRoomController = BehaviorSubject<Room?>();

    currentRoomCodeSub = _firebaseProvider.streamCurrentPlayerRoomCode()
        .listen((roomCode)
    {
      currentRoomSub = _firebaseProvider.streamRoom(roomCode)
          .listen((room)
      {

        if(room != null)
        {
          List<Stream<Player>> list = [];

          for(String id in room.playerIds)
         {

            var playerAndImageStream = CombineLatestStream.combine2<Player, Image?, Player>(
                streamPlayer(id), streamPlayerImage(id), (player, image)
            {
              player.profileImage = image;
              return player;
            });
            _playerStreams.addAll({id : playerAndImageStream});


            var s = _playerStreams[id]!;
            list.add(s);
          }

          var s = CombineLatestStream.list(list);
          s.listen((value) {
            room.players = value;
            for(Player p in room.players) print(p.toJson().toString());
            currentRoomController.add(room);
          });


        }
      });
    });

  }

  void dispose(){
    currentRoomCodeSub.cancel();
    currentRoomSub.cancel();
  }


  final _firebaseProvider = FirebaseProvider();


  Stream<Room?> streamCurrentPlayerRoom() {
    return currentRoomController.stream;
  }

  Stream<Player> streamPlayer(String id) {
    return _firebaseProvider.streamPlayer(id);
  }


  Stream<Player?> streamCurrentPlayer() {
    return _firebaseProvider.streamCurrentPlayer();
  }

  Stream<Image?> streamCurrentPlayerImage() {
    return _firebaseProvider.streamCurrentPlayerImage();
  }

  Future<void> uploadProfileImage(File file) async {
    await _firebaseProvider.uploadProfileImage(file);
  }

  Future<String> getPrivacyPolicyString() async {
    return await _firebaseProvider.getPrivacyPolicyString();
  }

  Future<void> uploadPlayerName(String name) async {
    return await _firebaseProvider.setName(name);
  }

  Future<String?> createGame() async {
    return await _firebaseProvider.createGame();
  }

  Stream<Image?> streamPlayerImage(String id) {
    return _firebaseProvider.streamPlayerImage(id);
  }




}