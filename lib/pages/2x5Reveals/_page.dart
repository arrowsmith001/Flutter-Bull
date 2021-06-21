
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_events.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2GameRoom/routes.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x2Write/routes.dart';
import 'package:flutter_bull/pages/2x5Reveals/routes.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/gen/fonts.gen.dart';
import 'package:flutter_bull/pages/2GameRoom/_page.dart';
import 'package:flutter_bull/utilities/interpolators.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import '../../classes/classes.dart';
import 'package:extensions/extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';


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

