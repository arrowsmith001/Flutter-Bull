
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x2Write/_page.dart';
import 'package:flutter_bull/pages/2x3Choose/_1_main.dart';
import 'package:flutter_bull/pages/2x3Choose/_page.dart';
import 'package:flutter_bull/pages/2x4Play/_1_main.dart';
import 'package:flutter_bull/pages/2x4Play/_page.dart';
import 'package:flutter_bull/pages/2x5Reveals/_page.dart';
import 'package:flutter_bull/extensions.dart';

class GameRoomRoutes {

  static Route generate(RouteSettings settings) {

    Widget prevPage = settings.arguments as Widget;

    // TODO Do cool transitions
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: (context, anim1, anim2, child){
        Size size = MediaQuery.of(context).size;

        switch(settings.name)
        {
          case '/': return Container(color: Colors.purpleAccent);

          case RoomPages.LOBBY: return child;

          case RoomPages.WRITE:
            Animation anim = CurvedAnimation(parent: anim1, curve: Curves.elasticInOut);
            return child.xScale(anim.value);

          case RoomPages.CHOOSE:
            // final Tween<Offset> offsetTween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0));
            // final Animation<Offset> slideOutLeftAnimation = offsetTween.animate(anim1);
            // return SlideTransition(position: slideOutLeftAnimation, child: child);
            return child;

          case RoomPages.PLAY:
          final Tween<Offset> offsetTween = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, 1.0));
          final Animation<Offset> slideInFromTheRightAnimation = offsetTween.animate(CurvedAnimation(parent: anim1, curve: Curves.easeInOut));
          var prev = SlideTransition(position: slideInFromTheRightAnimation, child: prevPage is Choose ? Choose(true) : prevPage);

          return Stack(
            alignment: Alignment.center,
            children: [
              child, prev
            ],
          );

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

  static pageListener(BuildContext context, GameRoomState state, String page, Widget pageWidget) {
    if(state is RoomPageChangedState)
      {
        Navigator.of(context).pushNamedAndRemoveUntil(state.newPage, (route) => false, arguments: pageWidget);
      }

  }
}
