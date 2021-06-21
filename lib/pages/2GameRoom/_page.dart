import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/pages/2GameRoom/routes.dart';
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
import '_bloc.dart';

import '_bloc.dart';
import '_bloc_events.dart';
import '_bloc_states.dart';

class GameRoom extends StatefulWidget {
  GameRoom();

  @override
  _GameRoomState createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  final HeroController _heroController = CupertinoApp.createCupertinoHeroController();

  @override
  void initState() {
    if(_bloc.model.room != null) initialRoute = _bloc.model.room!.page ?? '/';
    print('Initial route: ' + initialRoute);
  }

  String initialRoute = '/';

  @override
  Widget build(BuildContext context) {

    Widget main = BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state){
        if(state is RoomPageChangedState){
          GameRoomRoutes.pageListener(navigationKey.currentState!.context, state, state.model.room!.page!);
        }
      },
      buildWhen: (s1, s2) => s2 is NewRoomState,
      builder: (context, state) {
        return HeroControllerScope(
          controller: _heroController,
          child: Navigator(
            key: navigationKey,
            initialRoute: initialRoute,
            onGenerateRoute: (settings) => GameRoomRoutes.generate(settings),
          ),
        );
      },
    );

    return main;


  }
}







