import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bull/classes/classes.dart';
import 'package:flutter_bull/utilities/game.dart';
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
    //if(roomPlayerVotesChildChangesSub != null) futures.add(roomPlayerVotesChildChangesSub!.cancel());
    for(String userId in playerSubs.keys) { futures.add(_unsubscribePlayer(userId)); }
    for(String roomCode in roomPlayerVotesChildAdditionsSub.keys)
      {
        for(String userId in roomPlayerVotesChildAdditionsSub[roomCode]!.keys)
          {
            futures.add(_unsubscribePlayerVotes(userId, roomCode));
          }
      }
    await Future.wait(futures);
  }

  StreamSubscription<String?>? userIdSub; // Must not unsubscribe
  StreamSubscription<Room?>? roomSub;
  StreamSubscription<Map>? roomChangesSub;
  StreamSubscription<Map>? roomPlayerAdditionsSub;
  StreamSubscription<Map>? roomPlayerRemovalsSub;

  Map<String, StreamSubscription<Player?>> playerSubs = {};
  Map<String, StreamSubscription<Map>> playerChangeSubs = {};
  Map<String, Map<String, StreamSubscription<Map>>> roomPlayerVotesChildAdditionsSub = {};

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

    if(userId == model.userId) return; // Expressly forbid unsubscription from main player!

    if(!playerSubs.containsKey(userId) && !playerChangeSubs.containsKey(userId)) return;

    StreamSubscription<Player?>? playerSub = playerSubs.containsKey(userId) ? playerSubs[userId] : null;
    StreamSubscription<Map>? playerChangeSub = playerChangeSubs.containsKey(userId) ? playerChangeSubs[userId] : null;

    if(playerSub != null) await playerSub.cancel();
    if(playerChangeSub != null) await playerChangeSub.cancel();

    playerSubs.remove(userId);
    playerChangeSubs.remove(userId);
  }

  Future<void> _subscribePlayerVotes(String userId, String roomCode) async {

    StreamSubscription<Map>? votesSub;

    if(roomPlayerVotesChildAdditionsSub.containsKey(roomCode)) {
      if(roomPlayerVotesChildAdditionsSub[roomCode]!.containsKey(userId))
      {
        return;
      }
    }

    if(votesSub != null) await votesSub.cancel();
    votesSub = repo.streamChildAdditions(['rooms', roomCode, Room.PLAYER_VOTES, userId]).listen((map) {
      add(OnVoteAddedEvent(roomCode, userId, map));
    });

    var newPair = {userId : votesSub};

    if(!roomPlayerVotesChildAdditionsSub.containsKey(roomCode)) roomPlayerVotesChildAdditionsSub.addAll({roomCode : newPair});
    else roomPlayerVotesChildAdditionsSub[roomCode]!.addAll(newPair);
  }

  Future<void> _unsubscribePlayerVotes(String userId, String roomCode) async {

    StreamSubscription<Map>? votesSub;

    if(roomPlayerVotesChildAdditionsSub.containsKey(roomCode)) {
      if(roomPlayerVotesChildAdditionsSub[roomCode]!.containsKey(userId))
      {
        votesSub = roomPlayerVotesChildAdditionsSub[roomCode]![userId];
      }
    }

    if(votesSub != null) await votesSub.cancel();

    if(roomPlayerVotesChildAdditionsSub.containsKey(roomCode)) {
      roomPlayerVotesChildAdditionsSub[roomCode]!.remove(userId);
    }
  }

  Future<void> _subscribeRoom(String roomCode) async {
    print('_subscribeRoom: ' + roomCode);
    // TODO await concurrently
    if(roomSub != null) await roomSub!.cancel();
    if(roomChangesSub != null) await roomChangesSub!.cancel();
    if(roomPlayerAdditionsSub != null) await roomPlayerAdditionsSub!.cancel();
    if(roomPlayerRemovalsSub != null) await roomPlayerRemovalsSub!.cancel();
    //if(roomPlayerVotesChildChangesSub != null) await roomPlayerVotesChildChangesSub!.cancel();

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

    // roomPlayerVotesChildChangesSub = repo.streamChildChanges(['rooms', roomCode, Room.PLAYER_VOTES])
    //   .listen((child) {
    //   add(RoomPlayerVoteEvent(child));
    // });
  }

  // TODO: Unsubscribe room

  @override
  Stream<FirebaseState> mapEventToState(FirebaseEvent event) async* {

    if(event is OnUserIdStreamEvent) yield* _onUserIdStreamEvent(event);

    if(event is OnPlayerStreamEvent) yield* _onPlayerStreamEvent(event);

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

    if(event is LeaveGameRequested)
    {
      await _unsubFromAll();
      bool success = await repo.leaveGame(model.userId!, model.room!.code!); // TODO Unjustified ! ?
      yield GameLeftState(success, model);
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
          await _subscribePlayerVotes(userId, room.code!); // TODO Unjustified !
        }
      }

      // TODO DELETE THIS TEMPORARY FIX TO DETECT REMOVED PLAYERS
      List<RoomPlayerRemovedState> statesToYield = [];
      if(model.room != null && model.room!.playerIds != null && room != null && room.playerIds != null)
        {
          model.room!.playerIds!.forEach((id) {
            if(!room.playerIds!.contains(id))
              {
                statesToYield.add(RoomPlayerRemovedState(model, model.room!.playerIds!.indexOf(id), id));
              }
          });
        }
      /////////////////////////////////////////////////////////////

      bool hasChanged = model.setRoom(room);

      // TODO ALSO DELETE
      for(RoomPlayerRemovedState state in statesToYield) yield state;
      /////////////////////////////////////////////////////////////

      if(hasChanged) {
        print('ROOM HAS CHANGED');
        yield NewRoomState(model);
      }
      else yield RoomChangeState(model);
    }

    if(event is OnRoomChildChangesEvent)
    {
      print('OnRoomChildChangesEvent: ' + event.changes.toString());
      if(event.changes.containsKey(Room.PAGE))
      {
        print("Room page changed: " + event.changes[Room.PAGE]);
        yield RoomPageChangedState(model, event.changes[Room.PAGE]);
      }

      if(event.changes.containsKey(Room.SETTINGS))
      {
        print("Room settings changed: " + event.changes[Room.SETTINGS].toString());
        yield RoomSettingsChangedState(model, Map.from(event.changes[Room.SETTINGS]));
      }

      if(event.changes.containsKey(Room.PLAYER_TEXTS))
      {
        Map<String, String> phases = Map.from(event.changes[Room.PLAYER_TEXTS]);
        yield PlayerTextsChangeState(phases, model);
      }

      if(event.changes.containsKey(Room.REVEALED))
        {
          int newRevealedNumber = event.changes[Room.REVEALED] as int;
          yield NewRevealedNumberState(newRevealedNumber, model);
        }

      if(event.changes.containsKey(Room.TURN))
        {
          int newTurn = event.changes[Room.TURN] as int;
          yield NewTurnNumberState(newTurn, model);
        }

      if(event.changes.containsKey(Room.PHASE))
        {
          String phase = event.changes[Room.PHASE] as String;
          yield NewPhaseState(phase, model);
        }

      // if(event.changes.containsKey(Room.PLAYER_VOTES))
      // {
      //   Map<String, List> map = Map.from(event.changes[Room.PLAYER_VOTES]);
      //   Map<String, List<Vote>> changes = map
      //       .map((id, list) => MapEntry(id, list
      //       .map((json) => Vote.fromJson(Map<String, dynamic>.from(json))).toList()));
      //
      //   yield PlayerVotesChangeState(changes, model);
      // }
    }

    if(event is RoomPlayerAddedEvent)
    {
      print('RoomPlayerAddedEvent: ' + event.changes.toString());
      for(String index in event.changes.keys)
      {
        String userId = event.changes[index];
        await _subscribePlayer(userId);
        if(model.room != null) await _subscribePlayerVotes(userId, model.room!.code!); // TODO Unjustified !
        yield RoomPlayerAddedState(model, int.parse(index), userId);
      }
    }

    if(event is RoomPlayerRemovedEvent)
    {
      // TODO Address onChildRemoved bug
      // print('RoomPlayerRemovedEvent: ' + event.changes.toString());
      // for(String index in event.changes.keys)
      // {
      //   String userId = event.changes[index];
      //   int i = model.room!.playerIds!.indexOf(userId);
      //   await _unsubscribePlayer(userId);
      //   if(model.room != null) await _unsubscribePlayerVotes(userId, model.room!.code!); // TODO Unjustified !
      //   yield RoomPlayerRemovedState(model, i, userId);
      // }
    }

    if(event is OnVoteAddedEvent)
      {
        print('VOTE ADDED: ' + event.changes.toString());
        String roomCode = event.roomCode;
        for(String voteNum in event.changes.keys)
          {
            Vote vote = Vote.fromJson(Map.from(event.changes[voteNum]));
            if(model.isRoom(roomCode) && model.room!.turn! == int.parse(voteNum)) yield NewVoteState(event.author, vote, model);
          }
      }

    // if(event is RoomPlayerVoteEvent)
    //   {
    //     print('RoomPlayerVoteEvent: ' + event.child.toString());
    //     Map<String, List<Vote>> map = Map<String, List<Vote>>.from(event.child);
    //     int turn = model.room!.turn!; // TODO Unjustified !
    //     for(String voterId in map.keys)
    //       {
    //         List<Vote> votes = map[voterId]!;
    //         if(votes.length == turn + 1)
    //           {
    //             // New vote has been added
    //             Vote newVote = votes.last;
    //             yield NewVoteState(voterId, newVote, model);
    //           }
    //
    //       }
    //   }

    if(event is NewRoomSettingsEvent)
      {
        var settings = event.newSettings;
        await repo.setRoomFields(model.room!.code!, settings, path: [Room.SETTINGS]);
      }

    // TODO: (potentially) refactor game logic out of firebase bloc (???)

    if(event is StartGameEvent)
      {
        // TODO unjustified !s
        Room room = model.room!;
        String roomCode = room.code!;

        await repo.setRoomLockedStatus(roomCode, true);
        List<String> playerIds = room.playerIds!; // TODO unjustified !

        RoleAssigner ra = new RoleAssigner(playerIds);
        ra.assignRoles();

        List<String> shuffledPlayers = List.from(playerIds);
        shuffledPlayers.shuffle();

        room.playerTargets = ra.playerTargets!;
        room.playerTruths = ra.playerTruths!;
        room.playerOrder = shuffledPlayers;
        room.page = RoomPages.WRITE;
        room.playerTexts = null;
        room.playerVotes = null;
        room.turn = 0;
        room.revealed = 0;

        await repo.updateRoom(room);
      }

    if(event is TextEntrySubmittedEvent)
    {
      if(model.room != null && model.room!.code != null)
      {
        bool success = await repo.setRoomField(model.room!.code!, [Room.PLAYER_TEXTS, event.targetId], event.text);
        yield TextEntryOutcomeState(success, model);
      }
    }

    if(event is PushNewVoteEvent)
      {
        Vote vote = event.vote;
        await repo.pushVote(event.voterId, model.room!.code!, vote, model.room!.turn!);
      }

    if(event is SetCurrentRoomFieldEvent)
    {
      if(model.room != null && model.room!.code != null)
      {
        bool success = await repo.setRoomField(model.room!.code!, event.path, event.value);
      }
    }

    if(event is SetPagePhaseOrTurnEvent)
    {
      if(model.room != null && model.room!.code != null)
      {
        Map<String, dynamic> changes = {};
        if(event.page != null) changes.addAll({ Room.PAGE: event.page});
        if(event.turn != null) changes.addAll({ Room.TURN : event.turn});
        if(event.phase != null) changes.addAll({ Room.PHASE : event.phase});
        bool success = await repo.setRoomFields(model.room!.code!, changes);
      }
    }

    if(event is StartRoundEvent)
      {
        await repo.setRoomField(model.room!.code!, [Room.ROUND_START_UNIX], GameParams.convertUnixForUpload(DateTime.now().millisecondsSinceEpoch));
        await repo.setRoomField(model.room!.code!, [Room.PAGE], RoomPages.PLAY);
        add(new PushNewVoteEvent(
            model.getPlayerWhoseTurn()!.id!,
            new Vote.reader()));
      }

    if(event is AdvanceRevealNumberEvent)
      {
        int? revealNumber = model.room!.revealed;
        if(revealNumber != null){

          await repo.setRoomFields(model.room!.code!,
              {
                Room.PHASE : RoomPhases.JUST_REVEALED,
                Room.REVEALED : revealNumber + 1
              });
        }
      }

    if(event is GoToNextRevealTurnEvent)
    {
      await repo.setRoomField(model.room!.code!, [Room.TURN], event.currentTurn + 1);
      //await repo.setRoomField(model.room!.code!, [Room.PHASE], RoomPhases.GO_TO_NEXT_REVEAL);
    }

    if(event is GoToResultsEvent)
    {
      await repo.setRoomField(model.room!.code!, [Room.PHASE], RoomPhases.GO_TO_RESULTS);
    }

    // if(event is TextEntryWithdrawnEvent)
    // {
    //   if(model.room != null && model.room!.code != null)
    //   {
    //     bool success = await repo.setRoomField(model.room!.code!, [Room.PLAYER_PHASES, model.userId!], PlayerPhases.?);
    //   }
    // }



  }

  // TODO Extract methods
  Stream<FirebaseState> _onUserIdStreamEvent(OnUserIdStreamEvent event) async* {
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

  Stream<FirebaseState> _onPlayerStreamEvent(OnPlayerStreamEvent event) async* {
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




}



class DataModel {

  // Id of the logged-in user
  String? userId;

  bool get amIHost => isHost(userId);

  bool get haveISubmittedText => hasPlayerSubmittedText(userId);

  Player? get me => getPlayer(userId);
  bool hasPlayerSubmittedText(String? userId) => getPlayerText(getPlayerTarget(userId)) != null;



  void setUserId(String? userId) {this.userId = userId;}

  // Room
  Room? room;
  bool isRoom(String roomCode) {
    if(room == null) return false;
    return (room!.code == roomCode);
  }
  bool isHost(String? userId) => userId != null && room != null && room!.host == userId;
  int? getHostIndex() => room != null && room!.host != null && room!.playerIds != null && room!.playerIds!.contains(room!.host) ? room!.playerIds!.indexOf(room!.host!) : null;
  Player? getHost() => room != null && room!.host != null && room!.playerIds != null && room!.playerIds!.contains(room!.host) ? getPlayer(room!.host!) : null;
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
  Player? getPlayer(String? userId) => userId == null || !playerMap.containsKey(userId) ? null : playerMap[userId];
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

  Player? getMyTarget() {
    if(userId == null) return null;
    if(room == null) return null;
    if(room!.playerTargets == null) return null;
    if(!room!.playerTargets!.containsKey(userId)) return null;
    String? targetId = room!.playerTargets![userId];
    return getPlayer(targetId);
  }

  bool? getTruth(arg) {
    if(arg == null) return null;
    if(room == null) return null;
    if(room!.playerTruths == null) return null;
    String playerId;
    if(arg is String) {playerId = arg;}
    else if(arg is Player) {playerId = arg.id!;}
    else return null;
    if(!room!.playerTruths!.containsKey(playerId)) return null;
    return room!.playerTruths![playerId];
  }

  Player? getPlayerWhoseTurn() {
    if(room == null) return null;
    if(room!.playerOrder == null) return null;
    if(room!.turn == null) return null;
    if(room!.playerOrder!.length <= room!.turn!) return null;
    return getPlayer(room!.playerOrder![room!.turn!]);
  }

  String? getPlayerText(String? id) {
    if(id == null) return null;
    if(room == null) return null;
    if(room!.playerTexts == null) return null;
    if(!room!.playerTexts!.containsKey(id)) return null;
    return room!.playerTexts![id];
  }

  bool? get isItMyTurn {
    if(userId == null) return null;
    if(room == null) return null;
    if(room!.playerOrder == null) return null;
    if(room!.turn == null) return null;
    if(room!.playerOrder!.length <= room!.turn!) return false;
    return room!.playerOrder![room!.turn!] == userId;

  }

  List<Vote>? getMyVotes() {
    if(userId == null) return null;
    if(room == null) return null;
    if(room!.playerVotes == null) return null;
    if(!room!.playerVotes!.containsKey(userId)) return null;
    return room!.playerVotes![userId];
  }

  bool get isThereEnoughInfoForResults {
    try
    {
      assert(room != null);
      assert(room!.playerVotes != null);
      assert(room!.playerTargets != null);
      assert(room!.playerTruths != null);
      assert(room!.playerOrder != null);
      assert(room!.playerScores != null);
      assert(room!.playerIds != null);
      assert(room!.playerVotes!.values.every((list) => list.length == room!.playerIds!.length));
      return true;
    }
        catch(e)
    {
      print('isThereEnoughInfoForResults ERROR: ' + e.toString());
      return false;
    }
  }

  Player? getPlayerFromOrder(int i) {
    try
    {
      assert(room != null);
      assert(room!.playerOrder != null);
      assert(i < room!.playerOrder!.length);
      String playerId = room!.playerOrder![i];
      return getPlayer(playerId);
    }
    catch(e)
    {
      print('getPlayerFromOrder ERROR: ' + e.toString());
      return null;
    }
  }

  bool? getPlayerTruth(String? id) {
    try
    {
      assert(id != null);
      assert(room != null);
      assert(room!.playerTruths != null);
      assert(room!.playerTruths!.containsKey(id));
      return room!.playerTruths![id];
    }
    catch(e)
    {
      print('getPlayerTruth ERROR: ' + e.toString());
      return null;
    }
  }

  int? whichTurnWasThisPlayer(String id) {
    try{
      assert(id != null);
      assert(room != null);
      assert(room!.playerOrder != null);
      assert(room!.playerOrder!.contains(id));
      return room!.playerOrder!.indexOf(id);
    }catch(e)
    {
      print('whichTurnWasThisPlayer ERROR: ' + e.toString());
      return null;
    }
  }

  // 'votedTrue == null' indicates to get all voters
  List<Player> getPlayersWhoVoted(int turn, [bool? votedTrue]) {
    try{
      assert(room != null);
      if(room!.playerVotes != null) return [];
      List<Player> list = room!.playerVotes!.keys
          .where((id) =>

        room!.playerVotes![id]!.length > turn
          &&
        room!.playerVotes![id]![turn].type != Vote.VOTE_TYPE_READER
          &&
        (votedTrue == null || room!.playerVotes![id]![turn].votedTrue == votedTrue))

          .map((userId) => getPlayer(userId)!).toList();
      return list;
    }catch(e)
    {
      print('getPlayersWhoVoted ERROR: ' + e.toString());
      return [];
    }
  }

  int? getNumberWhoVoted(int turn, [bool? votedTrue]) { // TODO implement votedTrue
    try{
      assert(room != null);
      if(room!.playerVotes == null) return 0;
      return room!.playerVotes!.keys
          .where((id) =>

            room!.playerVotes![id]!.length > turn
          &&
            room!.playerVotes![id]![turn].type != Vote.VOTE_TYPE_READER
          &&
            (votedTrue == null || room!.playerVotes![id]![turn].votedTrue == votedTrue))

          .length;
    }catch(e)
    {
      print('getNumberWhoVoted ERROR: ' + e.toString());
      return null;
    }
  }

  getVoteTimes(List<Player> players, int turn) {
    try{
      assert(room != null);
      assert(room!.playerVotes != null);
      List<int> list = players.map((p) => room!.playerVotes![p.id]![turn].time!).toList();
      return list;
    }catch(e)
    {
      print('whichTurnWasThisPlayer ERROR: ' + e.toString());
      return [];
    }
  }

  String? getPlayerTarget(String? id) {
    try{
      assert(id != null);
      assert(room != null);
      assert(room!.playerTargets != null);
      assert(room!.playerTargets!.containsKey(id));
      return room!.playerTargets![id];
    }catch(e)
    {
      print('getPlayerTarget ERROR: ' + e.toString());
      return null;
    }
  }

  bool? haveTheyVoted(String? id) {
    try{
      assert(id != null);
      assert(room != null);
      assert(room!.turn != null);
      if(room!.playerVotes == null) return false;
      if(!room!.playerVotes!.containsKey(id)) return false;
      List<Vote> myVotes = room!.playerVotes![id]!;
      return (myVotes.length > room!.turn!);
    }catch(e)
    {
      print('haveTheyVoted ERROR: ' + e.toString());
      return null;
    }

  }

  bool? isItTheirTurn(String? id) {
    try{
      assert(id != null);
      assert(room != null);
      assert(room!.turn != null);
      assert(room!.playerOrder != null);
      assert(room!.playerOrder!.contains(id));
      return room!.playerOrder!.indexOf(id!) == room!.turn!;
    }catch(e)
    {
      print('isItTheirTurn ERROR: ' + e.toString());
      return null;
    }
  }

  List<Player> getFullVoterList(int turn) {
    try{
      assert(room != null);
      assert(room!.playerIds != null);
      Player? playerWhoseTurn = getPlayerWhoseTurn();
      assert(playerWhoseTurn != null);
      List<Player> list = room!.playerIds!
          .where((id) =>
        id != playerWhoseTurn!.id
      ).map((userId) => getPlayer(userId)!).toList();
      return list;
    }catch(e)
    {
      print('getPlayersWhoVoted ERROR: ' + e.toString());
      return [];
    }
  }

  int? getPlayerScore(String? id) {
    try{
      assert(id != null);
      assert(room != null);
      assert(room!.playerScores != null);
      assert(room!.playerScores!.containsKey(id));
      return room!.playerScores![id];
    }catch(e)
    {
      print('getPlayerScore ERROR: ' + e.toString());
      return null;
    }
  }

  // Generate the integer for a seed that is specific to this round (sort of...most likely...)
  int? getRoundSpecificSeed() {
    try{
      assert(room != null);
      assert(room!.playerTexts != null);
      int i = 0;
      room!.playerTexts!.values.forEach((value) { i+=value.length; });
      return i;
    }catch(e)
    {
      print('getRoundSpecificSeed ERROR: ' + e.toString());
      return null;
    }
  }


}

