import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2x5Reveals/routes.dart';
import 'package:flutter/widgets.dart';


class Reveals extends StatefulWidget {

  @override
  _RevealsState createState() => _RevealsState();
}

class _RevealsState extends State<Reveals> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  final String thisPageName = RoomPages.REVEALS;

  String initialRoute = RevealsPages.INTRO;
  @override
  void initState() {
    // if(_bloc.model.room != null) initialRoute = _bloc.model.room!.page ?? '/';
    // print('Initial route: ' + initialRoute);
    try{
      int turn = _bloc.model.room!.turn!;
      int revealed = _bloc.model.room!.revealed!;
      int playerCount = _bloc.model.roomPlayerCount;

      if(turn > 0 || revealed > 0)
        {
          if(revealed >= playerCount)
            {
              initialRoute = RevealsPages.FINAL;
            }
          else if(revealed > turn)
            {
              initialRoute = RevealsPages.SUB;
            }
          else
            {
              initialRoute = RevealsPages.MAIN;
            }
        }
    }
    catch(e)
    {

    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state) {
        //GameRoomRoutes.pageListener(context, state, thisPageName, this.widget);
      },
      builder: (context, state) {
        return Navigator(
          observers: [
            HeroController()
          ],
          key: navigationKey,
          initialRoute: initialRoute,
          onGenerateRoute: (settings) {
            return RevealsRoutes.generate(settings);
          },
        );
      },
    );


  }
}

