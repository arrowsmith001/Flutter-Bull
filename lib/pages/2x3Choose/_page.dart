
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
import 'package:flutter_bull/pages/2x3Choose/routes.dart';
import 'package:flutter_bull/pages/2x5Reveals/routes.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/misc.dart';
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
import '../../extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';


class Choose extends StatefulWidget {
  Choose([this.transitioning = false]);
  final bool transitioning;

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  final HeroController _heroController = new HeroController();

  final String thisPageName = RoomPages.CHOOSE;

  @override
  void initState() {
    // if(_bloc.model.room != null) initialRoute = _bloc.model.room!.page ?? '/';
    // print('Initial route: ' + initialRoute);
    try{
      String phase = _bloc.model.room!.phase!;
      if(phase == RoomPhases.CHOSEN || phase == RoomPhases.READING_OUT || phase == RoomPhases.PLAY)
      {
        initialRoute = ChoosePages.MAIN;
      }
    }
    catch(e)
    {
      Utils.printInitializationError(e, thisPageName);
    }
  }

  String initialRoute = ChoosePages.INTRO;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state) {
        GameRoomRoutes.pageListener(context, state, thisPageName, this.widget);
      },
      builder: (context, state) {
        return Navigator(
          observers: [
            _heroController
          ],
          key: navigationKey,
          initialRoute: initialRoute,
          onGenerateRoute: (settings) {
            return ChooseRoutes.generate(settings, widget.transitioning);
          },
        );
      },
    );


  }
}

