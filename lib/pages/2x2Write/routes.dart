
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x2Write/_0_intro.dart';
import 'package:flutter_bull/pages/2x2Write/_1_main.dart';
import 'package:flutter_bull/pages/2x2Write/_2_after.dart';
import 'package:flutter_bull/pages/2x2Write/_page.dart';
import 'package:flutter_bull/pages/2x3Choose/_page.dart';
import 'package:flutter_bull/pages/2x4Play/_page.dart';
import 'package:flutter_bull/pages/2x5Reveals/_page.dart';

class WriteRoutes {

  static Route generate(RouteSettings settings) {

    return CupertinoPageRoute(builder: (context) {

      switch(settings.name)
      {
        case WritePages.INTRO: return WriteIntro();

        case WritePages.MAIN: return WriteMain();

        case WritePages.AFTER: return WriteAfter();
      }

      return Container(color: Colors.white, child: Center(
          child: Text("Error: Unknown route name " + (settings.name??'null'))));

    });
  }

  static pageListener(BuildContext context, GameRoomState state, String page) {
    if(state is PlayerPhaseChangedState)
      {
        Navigator.of(context).pushNamed(state.newPhase);
      }
  }
}

class WritePages {
  static const String INTRO = 'intro';
  static const String MAIN = 'main';
  static const String AFTER = 'after';
}
