
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x2Write/_page.dart';
import 'package:flutter_bull/pages/2x3Choose/_page.dart';
import 'package:flutter_bull/pages/2x4Play/_page.dart';
import 'package:flutter_bull/pages/2x5Reveals/_page.dart';
import 'package:flutter_bull/extensions.dart';

class GameRoomRoutes {

  static Route generate(RouteSettings settings) {

    return PageRouteBuilder(
      transitionsBuilder: (context, anim1, anim2, child){
        switch(settings.name)
        {
          case '/': return Container(color: Colors.purpleAccent);

          case RoomPages.LOBBY: return child;

          case RoomPages.WRITE:
            Animation anim = CurvedAnimation(parent: anim1, curve: Curves.elasticInOut);
            return child.ScaleExt(anim.value);

          case RoomPages.CHOOSE: return child;

          case RoomPages.PLAY: return child;

          case RoomPages.REVEALS: return child;

          default: return child;
        }
      },

        pageBuilder: (context, anim1, anim2) {

      switch(settings.name)
      {
        case '/': return Container(color: Colors.purpleAccent);

        case RoomPages.LOBBY: return Lobby();

        case RoomPages.WRITE: return Write();

        case RoomPages.CHOOSE: return Choose();

        case RoomPages.PLAY: return Play();

        case RoomPages.REVEALS: return Reveals();
      }

      return Container(color: Colors.white, child: Center(
          child: Text("Error: Unknown route name " + (settings.name??'null'))));

    });
  }

  static pageListener(BuildContext context, GameRoomState state, String page) {
    if(state is RoomPageChangedState)
      {
        Navigator.of(context).pushNamedAndRemoveUntil(state.newPage, (route) => false);
      }

  }
}
