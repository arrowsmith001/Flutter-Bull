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

//       List<Map<Player, Vote>> statesToYield = [];
//       if(state is fbState.PlayerVotesChangeState)
//       {
//         // Compare models for differences
//         bool oldModelNull = model.room!.playerVotes == null;
//
//         for(String id in state.changes.keys)
//           {
//             List<Vote> newVotesList = state.changes[id]!;
//             int newVotesListLength = newVotesList.length;
// print(id);
//             List<Vote>? oldVotesList;
//             int oldVotesListLength = 0;
//             if(oldModelNull == false && model.room!.playerVotes!.containsKey(id))
//               {
//                 oldVotesList = model.room!.playerVotes![id]!;
//                 oldVotesListLength = oldVotesList.length;
//               }
//
//             print(newVotesListLength.toString() + ' ' + oldVotesListLength.toString());
//             if(newVotesListLength == oldVotesListLength + 1)
//               {
//                 Vote vote = newVotesList.last;
//                 if(!vote.isReader()) statesToYield.add({state.model.getPlayer(id)! : newVotesList.last});
//               }
//           }
//
//       }


      // MODEL SET FROM HERE
      model.dataModel = state.model;
      // MODEL SET FROM HERE

      // for(var item in statesToYield)
      //   {
      //     yield NewPlayerVotedState(item.keys.first, item.values.first, model);
      //   }

      if (state is fbState.RoomChangeState) {
        yield RoomChangeState(model);
      }

      if (state is fbState.NewRoomState) {
        yield NewRoomState(model);
      }

      if (state is fbState.RoomPlayerAddedState) {
        yield RoomPlayerAddedState(model, state.index, state.userId);
      }

      if (state is fbState.RoomPlayerRemovedState) {
        yield RoomPlayerRemovedState(model, state.index, state.userId);
      }

      if (state is fbState.RoomPageChangedState) {
        yield RoomPageChangedState(model, state.newPage);
      }

      if (state is fbState.TextEntryOutcomeState) {
        if (state.success) {
          yield TextEntrySuccessfullySubmittedState(model);
        }
        else {
          // TODO Display some error
        }
      }

      if (state is fbState.PlayerTextsChangeState) {
        Map<String, String> changes = state.changes;
        if (changes.length > 0 && changes.length ==
            model.roomPlayerCount) // If all players show phase
            {
          {
              firebaseBloc.add(fbEvent.SetPageOrTurnEvent(page: RoomPages.CHOOSE));// TODO ABSOLUTELY URGENT lock in texts somehow
          }
        }
      }

      if (state is fbState.NewVoteState)
        {
          Player? player = model.dataModel.getPlayer(state.voterId);
          Vote vote = state.vote;
          if(vote.type != Vote.VOTE_TYPE_READER)
            {
              print('GameRoomBloc: yielding NewPlayerVotedState (${state.voterId})');
              int numberVotedSoFar = model.getNumberWhoVoted(model.room!.turn!)!; // TODO Unjustified !;
              yield NewPlayerVotedState(state.voterId, vote, player, numberVotedSoFar, model); // TODO: Unjustified !
            }
        }

      if(state is fbState.NewRevealedNumberState)
      {
        yield RevealState(state.newRevealedNumber, model);
      }

      if(state is fbState.NewTurnNumberState)
        {
          if(model.room!.page == RoomPages.REVEALS) yield NewTurnState(state.newTurn, model);

        }

      if(state is fbState.NewPhaseState)
        {
          // TODO Add currentpage info as condition?
          String phase = state.phase;

          if(phase == RoomPhases.GO_TO_NEXT_REVEAL)
          {
            // yield GoToNextRevealState(model);
          }

          if(phase == RoomPhases.GO_TO_RESULTS)
          {
            yield GoToResultsState(model);
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

    if(event is StartRoundEvent)
      {
        firebaseBloc.add(fbEvent.StartRoundEvent());
      }

    if(event is VoteEvent)
      {
         try
         {
           bool? votedTrue = event.votedTrue;
           int t = event.t;

           // Assert that vote list so far is expected given the turn
           int turn = model.room!.turn!;
           List<Vote>? votes = model.getMyVotes();
           int votesLength = votes == null ? 0 : votes.length;
           assert(votesLength == turn);

           // Determine voter type
           String whoseTurnId = model.getPlayerWhoseTurn()!.id!;
           String myTargetId = model.getMyTarget()!.id!;

           Vote vote = Vote.fromData(model.myId!, votedTrue, whoseTurnId, myTargetId, t);

           firebaseBloc.add(fbEvent.PushNewVoteEvent(model.myId!, vote));

         }
           catch(e)
        {
          print(e.toString());
          // TODO Something went wrong while voting
        }




      }

    if(event is NextTurnRequestedFromPlayEvent)
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

    if(event is NextTurnRequestedFromRevealsEvent)
    {
      int turn = model.room!.turn!;
      int playerCount = model.roomPlayerCount;
      print('turn: ' + turn.toString() + ', players: ' + playerCount.toString());
      if(turn + 1 < playerCount)
      {
        firebaseBloc.add(fbEvent.GoToNextRevealTurnEvent(turn));
      }
      else
      {
        firebaseBloc.add(fbEvent.GoToResultsEvent());
      }
    }

    if(event is SetPageOrTurnEvent)
      {
        firebaseBloc.add(fbEvent.SetPageOrTurnEvent(page: event.page, turn: event.turn));
      }

    if(event is AdvanceRevealNumberEvent)
      {
        firebaseBloc.add(fbEvent.AdvanceRevealNumberEvent());
      }






    }

  }





class GameRoomModel {
  GameRoomModel(this.dataModel);
  DataModel dataModel;

  String? get myId => dataModel.userId;
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

  int? getNumberWhoVoted(int turn) => dataModel.getNumberWhoVoted(turn);

  List<Player> getPlayersWhoVoted(int turn, [bool? votedTrue]) => dataModel.getPlayersWhoVoted(turn, votedTrue);

  List<int> getVoteTimes(List<Player> players, int turn) => dataModel.getVoteTimes(players, turn);

  List<Player> getPlayersWhoCanVote(int turn) => dataModel.getFullVoterList(turn);

}

