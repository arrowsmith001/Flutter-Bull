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
import '../../extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';

class Choose extends StatefulWidget {

  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.CHOOSE;

  @override
  void initState() {
    super.initState();
  }


  void goToPlay() {
    _bloc.add(SetPageOrTurnEvent(page: RoomPages.PLAY));
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          if(state.model.room == null) return MyLoadingIndicator();
          Player? player = state.model.getPlayerWhoseTurn();
          String? text = player == null ? null : state.model.getPlayerText(player.id);
          bool? isMyTurn = state.model.isItMyTurn;

          bool sufficientInfo = player != null && text != null && isMyTurn != null;

          return SafeArea(
              child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 231, 255, 225),
                  appBar: CupertinoNavigationBar(
                    leading: Text(thisPageName, style: AppStyles.DebugStyle(32),),
                  ),
                  body: !sufficientInfo ? MyLoadingIndicator()
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Hero(
                      tag: state.model.room!.turn!,
                      child: Avatar(player.profileImage, size: Size(300, 300))
                        ).FlexibleExt(),

                      Text(text, style: AppStyles.DebugStyle(20)),
                      !isMyTurn ? EmptyWidget() : CupertinoButton(child: Text('Go to play'), onPressed: () => goToPlay())

                    ],
                  ).PaddingExt(EdgeInsets.all(20))

              ));
        },
        listener: (context, state) =>
            GameRoomRoutes.pageListener(context, state, thisPageName));
  }


}