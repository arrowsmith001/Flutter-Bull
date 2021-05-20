import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/utilities/res.dart';

import '_bloc_events.dart';
import '_bloc_states.dart';

class GameRoomBloc extends Bloc<GameRoomEvent, GameRoomState>{
  GameRoomBloc({required this.repo}) : super(InitialState(null)){

  }

  Repository repo;
  GameRoomModel _model = GameRoomModel();

  StreamSubscription<String?>? userIdSub;
  StreamSubscription<String?>? roomCodeSub;
  StreamSubscription<Room?>? roomSub;
  StreamSubscription<Map>? roomChangesSub;
  StreamSubscription<Map>? roomPlayerAdditionsSub;
  StreamSubscription<Map>? roomPlayerRemovalsSub;

  Map<String, StreamSubscription<Player?>> playerSubs = {};
  Map<String, StreamSubscription<Map>> playerChangeSubs = {};

  Future<void> subscribePlayer(String userId) async {
    StreamSubscription<Player?>? playerSub = playerSubs.containsKey(userId) ? playerSubs[userId] : null;
    StreamSubscription<Map>? playerChangeSub = playerChangeSubs.containsKey(userId) ? playerChangeSubs[userId] : null;

    if(playerSub != null) await playerSub.cancel();
    playerSub = repo.streamPlayer(userId).listen((player) {
      if (player != null) {
        //print('streamPlayer: ${player.toJson().toString()}' + DateTime.now().toString());
        add(OnPlayerStreamEvent(userId, player));
      }
    });

    if(playerChangeSub != null) await playerChangeSub.cancel();
    playerChangeSub = repo.streamPlayerChanges(userId).listen((changes) {
      if (changes != null) {
        //print('streamPlayerChanges: ${changes.toString()}' + DateTime.now().toString());
        add(OnPlayerChangeStreamEvent(userId, changes));
      }
    });

    playerSubs.addAll({userId : playerSub});
    playerChangeSubs.addAll({userId : playerChangeSub});
  }

  Future<void> unsubscribePlayer(String userId) async {
    StreamSubscription<Player?>? playerSub = playerSubs.containsKey(userId) ? playerSubs[userId] : null;
    StreamSubscription<Map>? playerChangeSub = playerChangeSubs.containsKey(userId) ? playerChangeSubs[userId] : null;

    if(playerSub != null) await playerSub.cancel();
    if(playerChangeSub != null) await playerChangeSub.cancel();

    playerSubs.remove(userId);
    playerChangeSubs.remove(userId);
  }

  @override
  Stream<GameRoomState> mapEventToState(GameRoomEvent event) async* {
    if(event is SetupEvent)
      {
        if(userIdSub != null) await userIdSub!.cancel();
        userIdSub = repo.streamCurrentUserId().listen((userId) {
          if(userId != null)
          {
            add(OnUserIdStreamEvent(userId));
          }
        });


      }

    if(event is OnUserIdStreamEvent)
      {
        if(roomCodeSub != null) await roomCodeSub!.cancel();
        roomCodeSub = repo.streamPlayerField<String?>(event.userId!, Player.OCCUPIED_ROOM_CODE).listen((roomCode) {
          if(roomCode != null)
          {
            add(OnRoomCodeStreamEvent(roomCode));
          }
        });

      }

    if(event is OnRoomCodeStreamEvent)
      {
        if(roomSub != null) await roomSub!.cancel();
        if(roomChangesSub != null) await roomChangesSub!.cancel();
        if(roomPlayerAdditionsSub != null) await roomPlayerAdditionsSub!.cancel();
        if(roomPlayerRemovalsSub != null) await roomPlayerRemovalsSub!.cancel();

        roomSub = repo.streamRoom(event.roomCode!).listen((room) {
          if(room != null)
          {
            add(OnRoomStreamEvent(room));
          }
        });

        roomChangesSub = repo.streamChildChanges(['rooms', event.roomCode!])
            .listen((changes) {
          add(OnRoomChildChangesEvent(changes));
        });

        roomPlayerAdditionsSub = repo.streamChildAdditions(['rooms',event.roomCode!,'playerIds'])
            .listen((changes) {
          add(RoomPlayerAddedEvent(changes));
        });
        roomPlayerRemovalsSub = repo.streamChildRemovals(['rooms',event.roomCode!,'playerIds'])
            .listen((changes) {
          add(RoomPlayerRemovedEvent(changes));
        });

      }

    if(event is OnRoomStreamEvent)
      {
        Room? room = event.room;

        if(room != null)
          {
            // Try to preserve list
            room.players = List.generate(room.playerIds.length, (index) => new Player());
            if(_model.room != null)
              {
                for(String userId in room.playerIds)
                  {
                    Player? p = _model.getPlayerById(userId);
                    if(p != null) room.players[room.playerIds.indexOf(userId)] = p;
                  }
              }

            // Player listeners
            for(String userId in room.playerIds)
            {
              subscribePlayer(userId);
            }
          }

        _model.setRoom(room);
        yield RoomChangeState(_model);
      }

    if(event is OnRoomChildChangesEvent)
    {

    }

    if(event is RoomPlayerAddedEvent)
    {
      for(String s in event.changes.values) await subscribePlayer(s);
    }

    if(event is RoomPlayerRemovedEvent)
    {
      for(String s in event.changes.values) await unsubscribePlayer(s);
    }

    if(event is OnPlayerStreamEvent)
    {
      Player player = event.player;
      String userId = event.userId;
      Player? currentPlayer = _model.getPlayerById(userId);

      if(currentPlayer == null || currentPlayer.profileImage == null)
      {
        print('event is OnPlayerStreamEvent : Initializing ${userId} image');

        Image? newProfileImage = await repo.getProfileImage(player.profileId);
        player.profileImage = newProfileImage;
      }
      else player.profileImage = currentPlayer.profileImage;

      _model.setPlayer(userId, player);
      yield RoomChangeState(_model);
    }

    if(event is OnPlayerChangeStreamEvent)
    {
      if(event.changes.containsKey(Player.PROFILE_ID))
      {
        print('OnPlayerChangeStreamEvent: Profile Id Changed (user ${event.userId}');

        String profileId = event.changes[Player.PROFILE_ID];
        String userId = event.userId;
        Player? player = _model.getPlayerById(userId);

        if(player != null)
          {
            player.profileImage = await repo.getProfileImage(profileId);
          }

        //yield ProfileImageUpdatedState(_model);
        yield RoomChangeState(_model);
      }


    }

  }





}


class GameRoomModel  extends ChangeNotifier{

  Room? room;

  Player? getPlayer(int i) => room == null || i > playerCount ? null : room!.players[i];
  Player? getPlayerById(String userId) => room == null || !room!.playerIds.contains(userId) ? null : room!.players[room!.playerIds.indexOf(userId)];

  int get playerCount => room == null ? 0 : room!.playerIds.length;

  void setPlayer(String userId, Player player) {
    if(room != null)
      if(room!.playerIds.indexOf(userId) != -1)
        room!.players[room!.playerIds.indexOf(userId)] = player;
  }

  void setRoom(Room? newRoom) {
    // Try to preserve player info
    // List<Player> prevPlayers = [];
    // if(room != null) {  prevPlayers = room!.players; }

    this.room = newRoom;
    // if(room != null)
    //   {
    //     for(String uid in room!.playerIds)
    //     {
    //       prevPlayers.forEach((player) { setPlayer(uid, player); });
    //     }
    //   }

  }
}

