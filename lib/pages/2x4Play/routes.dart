
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x2Write/_0_intro.dart';
import 'package:flutter_bull/pages/2x2Write/_1_main.dart';
import 'package:flutter_bull/pages/2x2Write/_2_after.dart';
import 'package:flutter_bull/pages/2x2Write/_page.dart';
import 'package:flutter_bull/pages/2x3Choose/_1_main.dart';
import 'package:flutter_bull/pages/2x4Play/_1_main.dart';
import 'package:flutter_bull/pages/2x4Play/_page.dart';
import 'package:flutter_bull/pages/2x5Reveals/_1_main.dart';
import 'package:flutter_bull/pages/2x5Reveals/_page.dart';


class PlayRoutes {

  static Route generate(RouteSettings settings) {


    return PageRouteBuilder(pageBuilder: (context, anim, anim1) {

      switch(settings.name)
      {
        case PlayPages.MAIN: return PlayMain();
      }

      return Container(color: Colors.white, child: Center(
          child: Text("Error: Unknown route name " + (settings.name??'null'))));

    });
  }

  static pageListener(BuildContext context, GameRoomState state, String page, Widget widget) {
    if(state is PlayerPhaseChangedState)
    {
      //Navigator.of(context).pushNamed(state.newPhase);
    }
  }
}

class PlayPages {
  static const String MAIN = 'main';
}
