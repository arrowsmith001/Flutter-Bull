import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:rxdart/rxdart.dart';

import '_bloc_events.dart';
import '_bloc_states.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/utilities/res.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState>{

  Repository repo;

  FirebaseBloc({required this.repo}) : super(new InitialState(new DataModel()))
  {
      // Initialize model
      this.model = state.model;

      // Initialize stream
      bs = new BehaviorSubject<FirebaseState>();
      bs.addStream(this.stream);

      // Immediately subscribe to receive changes in user ID
      userIdSub = repo.streamCurrentUserId().listen((userId)
      {
        add(OnUserIdStreamEvent(userId));
      });
  }

  late DataModel model;
  late BehaviorSubject<FirebaseState> bs;

  // Unsubs from all streams except userIdSub
  Future<void> _unsubFromAll() async
  {
    List<Future> futures = [];
    if(roomSub != null) futures.add(roomSub!.cancel());
    if(roomChangesSub != null) futures.add(roomChangesSub!.cancel());
    if(roomPlayerAdditionsSub != null) futures.add(roomPlayerAdditionsSub!.cancel());
    if(roomPlayerRemovalsSub != null) futures.add(roomPlayerRemovalsSub!.cancel());
    for(String userId in model.playerMap.keys) {futures.add(_unsubscribePlayer(userId));}
    await Future.wait(futures);
  }

  StreamSubscription<String?>? userIdSub; // Must not unsubscribe
  StreamSubscription<Room?>? roomSub;
  StreamSubscription<Map>? roomChangesSub;
  StreamSubscription<Map>? roomPlayerAdditionsSub;
  StreamSubscription<Map>? roomPlayerRemovalsSub;

  Map<String, StreamSubscription<Player?>> playerSubs = {};
  Map<String, StreamSubscription<Map>> playerChangeSubs = {};

  Future<void> _subscribePlayer(String userId) async {

    if(playerSubs.containsKey(userId) && playerChangeSubs.containsKey(userId)) return;

    StreamSubscription<Player?>? playerSub = playerSubs.containsKey(userId) ? playerSubs[userId] : null;
    StreamSubscription<Map>? playerChangeSub = playerChangeSubs.containsKey(userId) ? playerChangeSubs[userId] : null;

    if(playerSub != null) await playerSub.cancel();
    playerSub = repo.streamPlayer(userId).listen((player) {
      add(OnPlayerStreamEvent(userId, player));
    });

    if(playerChangeSub != null) await playerChangeSub.cancel();
    playerChangeSub = repo.streamPlayerChanges(userId).listen((changes) {
      add(OnPlayerChangeStreamEvent(userId, changes));
    });

    playerSubs.addAll({userId : playerSub});
    playerChangeSubs.addAll({userId : playerChangeSub});
  }

  Future<void> _unsubscribePlayer(String userId) async {

    if(!playerSubs.containsKey(userId) && !playerChangeSubs.containsKey(userId)) return;

    StreamSubscription<Player?>? playerSub = playerSubs.containsKey(userId) ? playerSubs[userId] : null;
    StreamSubscription<Map>? playerChangeSub = playerChangeSubs.containsKey(userId) ? playerChangeSubs[userId] : null;

    if(playerSub != null) await playerSub.cancel();
    if(playerChangeSub != null) await playerChangeSub.cancel();

    playerSubs.remove(userId);
    playerChangeSubs.remove(userId);
  }

  Future<void> _subscribeRoom(String roomCode) async
  {
    if(model.isRoom(roomCode)) return;

    if(roomSub != null) await roomSub!.cancel();
    if(roomChangesSub != null) await roomChangesSub!.cancel();
    if(roomPlayerAdditionsSub != null) await roomPlayerAdditionsSub!.cancel();
    if(roomPlayerRemovalsSub != null) await roomPlayerRemovalsSub!.cancel();

    roomSub = repo.streamRoom(roomCode).listen((room) {
      add(OnRoomStreamEvent(room));
    });

    roomChangesSub = repo.streamChildChanges(['rooms', roomCode])
        .listen((changes) {
      add(OnRoomChildChangesEvent(changes));
    });

    roomPlayerAdditionsSub = repo.streamChildAdditions(['rooms',roomCode,'playerIds'])
        .listen((changes) {
      add(RoomPlayerAddedEvent(changes));
    });
    roomPlayerRemovalsSub = repo.streamChildRemovals(['rooms',roomCode,'playerIds'])
        .listen((changes) {
      add(RoomPlayerRemovedEvent(changes));
    });
  }


  @override
  Stream<FirebaseState> mapEventToState(FirebaseEvent event) async* {

    if(event is OnUserIdStreamEvent)
    {
      String? userId = event.userId;

      if(userId == null)
        {
          print('OnUserIdStreamEvent: logged out');
          await _unsubFromAll();
          yield UserLoggedOutState(model);
        }
      else
        {
          print('OnUserIdStreamEvent: logged in ${userId}');

          model.setUserId(userId);

          // This is just to initialize the player if necessary
          await repo.setPlayerField(userId, Player.ID, userId);
          await _subscribePlayer(userId);

          // if(roomCodeSub != null) await roomCodeSub!.cancel();
          //
          // roomCodeSub = repo.streamPlayerField<String?>(userId, Player.OCCUPIED_ROOM_CODE).listen((roomCode) {
          //   add(OnRoomCodeStreamEvent(roomCode));
          // });
        }
    }

    if(event is OnPlayerStreamEvent) {
      print('OnPlayerStreamEvent: ${event.userId} : ' + (event.player == null ? 'null' : event.player.toString()));
      Player? streamedPlayer = event.player;
      String userId = event.userId;

      if(streamedPlayer != null)
        {
          // Establish image
          if(streamedPlayer.profileId != null && !model.hasImage(streamedPlayer.profileId))
            {
                Image? newProfileImage = await repo.getProfileImage(streamedPlayer.profileId);
                model.setProfileImage(streamedPlayer.profileId!, newProfileImage);
            }

          //If player is user
          if(streamedPlayer.id == model.userId)
            {
              String? roomCode = streamedPlayer.occupiedRoomCode;
              if(roomCode != null)
                {
                  if(!model.isRoom(roomCode))
                    {
                      await _subscribeRoom(roomCode);
                      yield RoomCodeChangedState(model);
                    }
                }
            }

        }

      model.setPlayer(userId, streamedPlayer);
      if(model.isUser(userId))
      {
        yield OnUserStreamState(userId, model);
      }
      else
      {
        yield OnPlayerStreamState(userId, model);
      }

    }

    if(event is OnPlayerChangeStreamEvent)
    {
      Map changes = event.changes;
      print('OnPlayerChangeStreamEvent: ${event.userId} : ' + changes.toString());
      if(changes.containsKey(Player.PROFILE_ID))
      {
        print('OnPlayerChangeStreamEvent: Profile Id Changed (user ${event.userId}');

        String profileId = changes[Player.PROFILE_ID];

        if(!model.hasImage(profileId))
        {
          Image? newProfileImage = await repo.getProfileImage(profileId);
          model.setProfileImage(profileId, newProfileImage);
        }

        yield ProfileImageUpdatedState(event.userId, model);
      }

      if(changes.containsKey(Player.NAME))
      {
        yield NameChangedState(event.userId, changes[Player.NAME], model);
      }

      if(changes.containsKey(Player.OCCUPIED_ROOM_CODE))
        {
          String roomCode = changes[Player.OCCUPIED_ROOM_CODE];
          if(!model.isRoom(roomCode))
            {
              await _subscribeRoom(roomCode);
            }
        }
    }









    if(event is ImagePicked)
    {
      String? fileExt = await repo.uploadProfileImage(event.file);
      await repo.setPlayerField(model.userId!, Player.PROFILE_ID, fileExt);
    }

    if(event is ChangeUsernameEvent)
    {
      await repo.setPlayerField(model.userId!, Player.NAME, event.newName);
    }

    if(event is PrivacyPolicyStringRequestedEvent)
    {
      String privacyPolicyString = await repo.getPrivacyPolicyString();
      yield PrivacyPolicyStringRetrievedState(privacyPolicyString, model);
    }

    if(event is CreateGameRequested)
    {
      String? roomCode = await repo.createGame(model.userId!);
      yield GameCreatedState(roomCode, model);
    }

    if(event is JoinGameRequested)
    {
      bool success = await repo.joinGame(model.userId!, event.roomCode);
      yield GameJoinedState(success, model);
    }


    if(event is OnRoomStreamEvent)
    {
      Room? room = event.room;

      if(room != null && room.playerIds != null)
      {
        // Player listeners
        for(String userId in room.playerIds!)
        {
          await _subscribePlayer(userId);
        }
      }

      bool hasChanged = model.setRoom(room);
      print('hasChanged: ' + hasChanged.toString());

      if(hasChanged) yield RoomCodeChangedState(model);
      else yield RoomChangeState(model);
    }

    if(event is OnRoomChildChangesEvent)
    {
      print('OnRoomChildChangesEvent: ' + event.changes.toString());
    }

    if(event is RoomPlayerAddedEvent)
    {
      print('RoomPlayerAddedEvent: ' + event.changes.toString());
      for(String index in event.changes.keys)
      {
        String userId = event.changes[index];
        await _subscribePlayer(userId);
        yield RoomPlayerAddedState(model, int.parse(index), userId);
      }
    }

    if(event is RoomPlayerRemovedEvent)
    {
      print('RoomPlayerRemovedEvent: ' + event.changes.toString());
      for(String index in event.changes.keys)
      {
        String userId = event.changes[index];
        await _unsubscribePlayer(userId);
        yield RoomPlayerRemovedState(model, int.parse(index), userId);
      }

    }



  }




}




class DataModel {

  // Id of the logged-in user
  String? userId;
  void setUserId(String? userId) {this.userId = userId;}

  // Room
  Room? room;
  bool isRoom(String roomCode) {
    if(room == null) return false;
    return (room!.code == roomCode);
  }
  int get roomPlayerCount => room == null || room!.playerIds == null ? 0 : room!.playerIds!.length;
  Player? getRoomMember(int i) {
    return room == null || room!.playerIds == null || i >= roomPlayerCount
        ? null
        : playerMap[room!.playerIds![i]];
  }

  bool setRoom(Room? room) {
    bool out = false;
    if(this.room == null) out = true;
    if(this.room != null && this.room!.code != room!.code) out = true;
    this.room = room;
    return out;
  }

  // Players
  Player? get user => userId == null ? null : playerMap[userId];
  Map<String, Player?> playerMap = {};
  Player? getPlayer(String userId) => playerMap.containsKey(userId) ? playerMap[userId] : null;
  void setPlayer(String userId, Player? player) {

    if(player != null)
      {
        if(player.profileId != null)
          {
            player.profileImage = getProfileImage(player.profileId!);
          }
      }

    playerMap.addAll({userId: player});
  }

  // Images
  bool hasImage(String? imageId) => imageId == null ? false : profileImagesMap.containsKey(imageId);
  Map<String, Image> profileImagesMap = {};
  void setProfileImage(String imageId, Image? image) {
    if(image == null) return;
    profileImagesMap.addAll({imageId: image});
    _refreshProfileImageForPlayers();
  }
  Image? getProfileImage(String profileId) => profileImagesMap.containsKey(profileId) ? profileImagesMap[profileId] : null;

  bool isUser(String userId) {
    return this.userId == userId;
  }

  void _refreshProfileImageForPlayers() {
    for(Player? p in playerMap.values)
      {
        if(p != null && p.profileId != null && hasImage(p.profileId))
          {
            p.profileImage = getProfileImage(p.profileId!);
          }
      }
  }





}

