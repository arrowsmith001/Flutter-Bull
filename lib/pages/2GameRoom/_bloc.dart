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
  GameRoomBloc({required this.repo}) : super(InitialState(new GameRoomModel())){

    var sub = repo.streamCurrentPlayerRoom().listen((room)
    {
      _model.room = room;
      add(RoomChangeEvent());
    });



    subscriptions.add(sub);


  }

  Repository repo;
  List<StreamSubscription> subscriptions = [];
  GameRoomModel _model = GameRoomModel();

  @override
  Stream<GameRoomState> mapEventToState(GameRoomEvent event) async* {
    if(event is RoomChangeEvent)
      {
        yield RoomChangeState(_model);
      }
  }


}


class GameRoomModel  extends ChangeNotifier{

  Room? room;

  Player? getPlayer(int i) => room == null || i > playerCount ? null : room!.players[i];
  int get playerCount => room == null ? 0 : room!.players.length;

  Map<String, Player> _playerMap = {};
}

