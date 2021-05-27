import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/classes.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/firebase/_bloc_states.dart' as fbState;
import 'package:flutter_bull/firebase/_bloc_events.dart' as fbEvent;
import 'package:flutter_bull/utilities/prefs.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/utilities/res.dart';

import '_bloc_events.dart';
import '_bloc_states.dart';

class GameRoomBloc extends Bloc<GameRoomEvent, GameRoomState>{
  GameRoomBloc(this.model, {required this.firebaseBloc}) : super(InitialState(model)){

    firebaseBloc.bs.listen((state) {
      add(FirebaseStateEvent(state));
    });
  }

  FirebaseBloc firebaseBloc;
  GameRoomModel model;

  @override
  Stream<GameRoomState> mapEventToState(GameRoomEvent event) async* {


    if(event is FirebaseStateEvent) {

      fbState.FirebaseState state = event.state;
      model.dataModel = state.model;

      if(state is fbState.RoomChangeState) {
        yield RoomChangeState(model);
      }

      if(state is fbState.NewRoomState)
      {
        yield NewRoomState(model);
      }

      if(state is fbState.RoomPlayerAddedState) {
        yield RoomPlayerAddedState(model, state.index, state.userId);
      }

      if(state is fbState.RoomPlayerRemovedState) {
        yield RoomPlayerRemovedState(model, state.index, state.userId);
      }

      if(state is fbState.RoomPageChangedState)
        {
          yield RoomPageChangedState(model, state.newPage);
        }

      if(state is fbState.TextEntryOutcomeState)
      {
        if(state.success)
        {
          yield TextEntrySuccessfullySubmittedState(model);
        }
        else
        {
          // TODO Display some error
        }
      }

      if(state is fbState.PlayerPhasesChangeState)
        {
          Map<String, String> changes = state.changes;
          if(changes.length > 0 && changes.length == model.roomPlayerCount) // If all players show phase
              {
                if(changes.values.toSet().length == 1){
                //yield AllPlayersAtSamePhaseState(phases.values.first, model); // TODO
            }
          }
        }


      yield GameRoomState(model);
    }


    if(event is StartGameRequestedEvent)
      {
          if(model.room != null && model.room!.playerIds != null)
          {
            if(model.roomPlayerCount < GameParams.MINIMUM_PLAYERS_FOR_GAME)
            {
              yield StartGameRequestOutcome('Need at least ${GameParams.MINIMUM_PLAYERS_FOR_GAME} players to start a game', model);
            }
            else
              {
                yield StartGameRequestOutcome(null, model);




                firebaseBloc.add(fbEvent.StartGameEvent());
              }
          }
          else
          {
            yield StartGameRequestOutcome('An unknown error has occured while trying to start the game', model);
          }

      }

    if(event is TextEntrySubmittedEvent)
      {
        firebaseBloc.add(fbEvent.TextEntrySubmittedEvent(event.text, event.targetId));
      }

    if(event is VoteEvent)
      {
         try
         {
           bool? votedTrue = event.votedTrue;
           int t = event.t;

           int turn = model.room!.turn!;

           // Assert that vote list so far is expected given the turn
           List<Vote>? votes = model.getMyVotes();
           int votesLength = votes == null ? 0 : votes.length;
           assert(votesLength == turn);

           // Determine voter type
           String type;
           if(model.isItMyTurn!) votedTrue = null;
           if(votedTrue == null) type = Vote.VOTE_TYPE_READER;
           else
           {
             String whoseTurnId = model.getPlayerWhoseTurn()!.id!;
             String myTargetId = model.getMyTarget()!.id!;

             if(whoseTurnId == myTargetId) type = Vote.VOTE_TYPE_SABOTEUR;
             else type = Vote.VOTE_TYPE_VOTER;
           }

           Vote vote = Vote()
            ..votedTrue = votedTrue
            ..time = t
            ..type = type;

           firebaseBloc.add(fbEvent.PushNewVoteEvent(vote));

         }
           catch(e)
        {
          print(e.toString());
          // TODO Something went wrong while voting
        }




      }

    if(event is NextTurnRequestedEvent)
      {
        int turn = model.room!.turn!;
        int playerCount = model.roomPlayerCount;
        print(turn.toString() + ' ' + playerCount.toString());
        if(turn + 1 < playerCount)
        {
          add(SetPageOrTurnEvent(page: RoomPages.CHOOSE, turn: turn + 1));
        }
        else
        {
          add(SetPageOrTurnEvent(page: RoomPages.REVEALS, turn: 0));
        }
      }

    if(event is SetPageOrTurnEvent)
      {
        firebaseBloc.add(fbEvent.SetPageOrTurnEvent(event.page, event.turn));
      }




    }

  }





class GameRoomModel {
  GameRoomModel(this.dataModel);
  DataModel dataModel;

  Room? get room => dataModel.room;
  get roomPlayerCount => dataModel.roomPlayerCount;
  bool get amIHost => dataModel.amIHost;
  bool? get isItMyTurn => dataModel.isItMyTurn;
  Player? getRoomMember(int i) => dataModel.getRoomMember(i);
  bool isHost(String? id) => dataModel.isHost(id);
  Player? getHost() => dataModel.getHost();
  int? getHostIndex() => dataModel.getHostIndex();
  Player? getPlayerWhoseTurn() => dataModel.getPlayerWhoseTurn();
  String? getPlayerText(String? id) => dataModel.getPlayerText(id);
  Player? getMyTarget() => dataModel.getMyTarget();
  List<Vote>? getMyVotes() => dataModel.getMyVotes();

  // Reveals/Results

  bool get isThereEnoughInfoForResults => dataModel.isThereEnoughInfoForResults;

  Player? getPlayerFromOrder(int i) => dataModel.getPlayerFromOrder(i);

  bool? getPlayerTruth(String? id) => dataModel.getPlayerTruth(id);

  int? whichTurnWasThisPlayer(String id) => dataModel.whichTurnWasThisPlayer(id);

  List<Player> getPlayersWhoVoted(bool votedTrue, int turn) => dataModel.getPlayersWhoVoted(votedTrue, turn);

  List<int> getVoteTimes(List<Player> players, int turn) => dataModel.getVoteTimes(players, turn);

}

