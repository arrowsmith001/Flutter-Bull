import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/firebase/_bloc_states.dart' as fbState;
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

      if(state is fbState.RoomCodeChangedState)
      {
        yield NewRoomState(model);
      }

      if(state is fbState.RoomPlayerAddedState) {
        yield RoomPlayerAddedState(model, state.index, state.userId);
      }

      if(state is fbState.RoomPlayerRemovedState) {
        yield RoomPlayerRemovedState(model, state.index, state.userId);
      }


      yield GameRoomState(model);
    }




    }

  }



class GameRoomModel {
  GameRoomModel(this.dataModel);
  DataModel dataModel;


  Room? get room => dataModel.room;
  get roomPlayerCount => dataModel.roomPlayerCount;
  Player? getRoomMember(int i) => dataModel.getRoomMember(i);


}

