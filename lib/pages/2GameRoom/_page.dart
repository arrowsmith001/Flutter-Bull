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
import 'package:flutter_bull/widgets/misc.dart';
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
import 'package:design/design.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets/misc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import 'package:arrowsmith/arrowsmith.dart';
import '../../classes/classes.dart';
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
  final ChatPanelController _chatController = new ChatPanelController();

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
          _chatController.close();
          GameRoomRoutes.pageListener(navigationKey.currentState!.context, state, state.model.room!.page!);
        }
      },
      buildWhen: (s1, s2) => s2 is NewRoomState,
      builder: (context, state) {
        return Stack(
          children: [

          HeroControllerScope(
            controller: _heroController,
            child: Navigator(
              key: navigationKey,
              initialRoute: initialRoute,
              onGenerateRoute: (settings) => GameRoomRoutes.generate(settings),
            ),
          ),


          Positioned(
            right: 0,
            child: ChatPanel(_chatController)
          )

        ],);
      },
    );

    return main;


  }
}

class ChatPanelController extends ChangeNotifier {
  bool isOpen = false;
  void open(){
    isOpen = true;
    notifyListeners();
  }
  void close(){
    isOpen = false;
    notifyListeners();
  }
  void toggle(){
    isOpen = !isOpen;
    notifyListeners();
  }
}

// TODO Make this good (hook up to notifs?)
class ChatPanel extends StatefulWidget {
  ChatPanel(this.controller);
  final ChatPanelController controller;

  @override
  _ChatPanelState createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> with TickerProviderStateMixin {

  ChatPanelController get _controller => widget.controller;
  late AnimationController animController = new AnimationController(vsync: this);
  late Animation anim = new CurvedAnimation(parent: animController, curve: Curves.easeInOutCubic);

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {setState(() {
      if(_controller.isOpen) animController.forward(from: animController.value);
      else animController.reverse(from: animController.value);
    });});

    animController.addListener(() {setState(() {

    });});
    animController.duration = new Duration(milliseconds: ANIM_LENGTH_MS);
    animController.value = _controller.isOpen ? 1 : 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const double PANEL_WIDTH_PROPORTION = 0.75;
  static const double HANDLE_WIDTH = 25;
  static const int ANIM_LENGTH_MS = 200;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double w = size.width*PANEL_WIDTH_PROPORTION;
    double dx = w * (1 - anim.value);

    return Stack(
      children: [

        Container(
            height: size.height,
            width: w + HANDLE_WIDTH)
            .xInvisibleIgnore(),

        Positioned(
          right: 0,
          child: Container(
            child: SafeArea(
                child: Center(
                    child: Text('Chat messages here?', style: TextStyle(color: Colors.white),))),
              height: size.height,
              width: w,
              color: Colors.black.withOpacity(0.75)
          ),
        ),

        Positioned(
          right: w,
          top: 40,
          child: GestureDetector(
            onTap: () => widget.controller.toggle(),
              child: Container(
                  height: 100,
                  width: HANDLE_WIDTH,
                  color: Colors.pinkAccent)
          ),
        )
      ],
    )
    .xTranslate(dx: dx);
  }
}





