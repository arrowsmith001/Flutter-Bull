
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
import 'package:flutter_bull/pages/2x5Reveals/_1_main.dart';
import 'package:flutter_bull/pages/2x5Reveals/_page.dart';

import '_0_intro.dart';
import '_2_sub.dart';
import '_3_final.dart';

class RevealsRoutes {

  static Route generate(RouteSettings settings) {

    return PageRouteBuilder(pageBuilder: (context, anim, anim1) {

      switch(settings.name)
      {
        case RevealsPages.INTRO: return RevealsIntro();

        case RevealsPages.MAIN: return RevealsMain(turn: settings.arguments as int);

        case RevealsPages.SUB: return RevealsSub(playerId: settings.arguments as String);

        case RevealsPages.FINAL: return RevealsFinal();
      }

      return Container(color: Colors.white, child: Center(
          child: Text("Error: Unknown route name " + (settings.name??'null'))));

    });
  }

  static pageListener(BuildContext context, GameRoomState state, String page) {
    if(state is PlayerPhaseChangedState)
      {
        //Navigator.of(context).pushNamed(state.newPhase);
      }
  }
}

class RevealsPages {
  static const String INTRO = 'intro';
  static const String MAIN = 'main';
  static const String SUB = 'sub';
  static const String FINAL = 'final';
}
