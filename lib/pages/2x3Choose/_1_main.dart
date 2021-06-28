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
import 'package:flutter_bull/pages/2x3Choose/routes.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/design.dart';
import 'package:flutter_bull/utilities/game.dart';
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
import 'package:flutter_bull/utilities/curves.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import '../../classes/classes.dart';
import 'package:extensions/extensions.dart';
import 'package:design/design.dart';
import 'dart:ui' as ui;

import '../../routes.dart';

class ChooseMain extends StatefulWidget {
  ChooseMain(this.transitioning);
  final bool transitioning;

  @override
  _ChooseMainState createState() => _ChooseMainState();
}

class _ChooseMainState extends State<ChooseMain> with TickerProviderStateMixin {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = ChoosePages.MAIN;

  late AnimationController _readOutTimerController = new AnimationController(vsync: this);
  late AnimationController _gradientAnimController = new AnimationController(vsync: this);
  late AnimationController _exitAnimController = new AnimationController(vsync: this);


  @override
  void initState() {
    super.initState();

    _readOutTimerController.value = 1;
    _readOutTimerController.duration = new Duration(milliseconds: 1000* GameParams.READ_OUT_TIME_SECONDS);
    _readOutTimerController.addListener(() {
      double t = _readOutTimerController.value;
      if(t == 0.0){
        _readOutTimerController.stop();
        _onReadOutTimerComplete();
      }
      int newSecond = (t * GameParams.READ_OUT_TIME_SECONDS).ceil();
      if(newSecond != readOutTimeSeconds)
        {
          // Report change
          setState(() {
            readOutTimeSeconds = newSecond;
          });
        }
    });

    _gradientAnimController.duration = new Duration(milliseconds: 3000);
    _gradientAnimController.addListener(() {setState(() {});});
    _gradientAnimController.repeat();

    _exitAnimController.duration = new Duration(milliseconds: 750);
    _exitAnimController.addListener(() {setState(() {});});

    if(widget.transitioning) {
      setState(() {
        // TODO Curate whether the transition is a lobby transition, for example, before automatically setting revealed state
        statementRevealed = _bloc.model.isItMyTurn??false;
      });
      _exitAnimController.forward(from: 0);
    }
  }

  @override
  dispose(){
    _readOutTimerController.dispose();
    _gradientAnimController.dispose();
    _exitAnimController.dispose();
    super.dispose();
  }

  bool statementRevealed = false;
  void _revealStatement() {
    _bloc.add(SetPagePhaseOrTurnEvent(phase: RoomPhases.READING_OUT));
  }

  int? readOutTimeSeconds;
  void _onStatementRevealed(GameRoomModel model){
    if((model.isItMyTurn??false)) {
      setState(() {
        statementRevealed = true;
        _readOutTimerController.reverse(from: 1);
      });
    };

  }

  Future<void> _onReadOutTimerComplete() async {
    if(statementRevealed) goToPlay();
  }

  void goToPlay() {
    _bloc.add(StartRoundEvent());
  }

  static const double DIM_MAX = 300;
  static const double DIM_PADDING = 25;
  static const double INNER_RRECT_RADIUS = 32;
  static const double OUTER_RRECT_RADIUS = 38;

  double m = 0;
  Curve anticipate = AnticipateCurve(1);

  @override
  Widget build(BuildContext context) {

    // TODO Make choose/play minimally viable <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          if(state.model.room == null) return MyLoadingIndicator();
          Player? player = state.model.getPlayerWhoseTurn();
          String? text = player == null ? null : state.model.getPlayerText(player.id);
          bool isMyTurn = state.model.isItMyTurn!;
          //isMyTurn = true; // TODO Edit <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
          //isMyTurn = !isMyTurn;

          bool sufficientInfo = player != null && text != null && isMyTurn != null;

          double h = MediaQuery.of(context).size.height;
          double v =_exitAnimController.value;
          double breakDownTranslateValue = h*anticipate.transform(v);
          double breakDownRotateValue = v/2;

          // TODO Move out of build
          // MovingGradient gradient = new MovingGradient(
          //     begin: Alignment.topLeft, end: Alignment.bottomRight,
          //     colors: [Colors.blue, Colors.indigo, Colors.lightBlueAccent]);
          double t = (m*5) % 1.0;

          double dim = MediaQuery.of(context).size.width - 2*DIM_PADDING;
          dim = min(dim, DIM_MAX);

          String primaryMessage = '';
          if(isMyTurn) primaryMessage = player!.name! + ', click below to reveal your statement';
          else primaryMessage = 'Waiting for ' + player!.name! + ' to read out their statement';

          bool showSecondaryMessage = true;
          String secondaryMessage = '';
          if(!isMyTurn) secondaryMessage = 'Get ready to vote!'.toUpperCase();
          else secondaryMessage = 'Get ready to read it out to the group!'.toUpperCase();

          Widget revealedWidget = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(text!, textAlign: TextAlign.center, style: AppStyles.defaultStyle(fontSize: 100))
                  .xPadAll(28)
                  .xRotateTranslate(-breakDownRotateValue, dy: breakDownTranslateValue)
                  .xFlexible()
            ],
          );

          Widget preRevealWidget = Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text(primaryMessage,
                  textAlign: TextAlign.center,
                  style: AppStyles.defaultStyle(fontSize: 36))
                  .xRotateTranslate(breakDownRotateValue, dy: breakDownTranslateValue),

               Text(secondaryMessage,
                  textAlign: TextAlign.center,
                  style: AppStyles.defaultStyle(fontSize: 25))
                   .xPadSym(h: 35)
                   .xRotateTranslate(-breakDownRotateValue, dy: breakDownTranslateValue)
                   .xEmptyUnless(showSecondaryMessage),

              // !isMyTurn ? EmptyWidget() : Text(text, style: AppStyles.DebugStyle(20)),
              CupertinoButton(
                  color: Colors.blue,
                  child: AppStyles.MyText('BEGIN'), onPressed: () => _revealStatement()).xEmptyUnless(isMyTurn),

            ],
          );

          Widget avatar = Avatar(
            player.profileImage,
            size: Size(dim, dim),
            clippedRectRadius: INNER_RRECT_RADIUS,
            borderColor: Colors.transparent,
          );

          Widget mainColumn = Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ClipRRect(
                borderRadius: MyBorderRadii.all(OUTER_RRECT_RADIUS),
                child: Container(
                    alignment: Alignment.center,
                    height: dim + DIM_PADDING,
                    width: dim + DIM_PADDING,
                    decoration: BoxDecoration(
                        //gradient: gradient.getGradient(_gradientAnimController.value)
                    ),
                    child: ClipRRect(
                      borderRadius: MyBorderRadii.all(INNER_RRECT_RADIUS),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [

                          avatar.xHero(player.id??''),

                          Container(
                              height: dim, width: dim,
                              color: Colors.white.withOpacity(0.8),).xEmptyUnless(statementRevealed),

                          ClipPath(
                              clipper: PieClipper(1 - _readOutTimerController.value),
                              child: avatar).xEmptyUnless(statementRevealed),

                          // ClipPath(
                          //     clipper: PieClipper(1 - m),//_readOutTimerController.value),
                          //     child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purpleAccent),)),//.EmptyUnless(statementRevealed),

                          AutoSizeText(
                              readOutTimeSeconds.toString(),
                            style: AppStyles.defaultStyle(
                              fontSize: 96,
                                color: Colors.white,
                                shadows: [BoxShadow(color: Colors.black, spreadRadius: 50, blurRadius: 10)]),
                          ).xEmptyUnless(statementRevealed && readOutTimeSeconds != null),

                        ],
                      ),
                    ))
                ,
              ).xEmptyUnless(!widget.transitioning)
                  .xRotateTranslate(breakDownRotateValue, dy: breakDownTranslateValue)
                  .xFlexible(),

              (statementRevealed ? revealedWidget : preRevealWidget).xExpanded()

              ,Slider(value: m, onChanged: (v) {
                setState(() {
                  m = v;
                });
              },)

            ],
          );


          return Scaffold(
              backgroundColor: Color.fromARGB(255, 36, 49, 153),
              body: !sufficientInfo ? MyLoadingIndicator()
                  : SafeArea(
                    child: mainColumn.xPadSym(h: 25, v: 15),
                  )

          );
        },
        listener: (context, state) {
          //GameRoomRoutes.pageListener(context, state, thisPageName, this.widget);

          if(state is NewPhaseState){
            if(state.phase == RoomPhases.READING_OUT)
              {
                _onStatementRevealed(state.model);
              }
          }
        }
    );
  }



}