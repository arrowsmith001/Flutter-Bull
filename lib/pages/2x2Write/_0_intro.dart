import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/firebase/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_events.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2GameRoom/routes.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x2Write/routes.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';
import '../../classes/classes.dart';
import 'package:extensions/extensions.dart';
import 'package:design/design.dart';
import 'dart:ui' as ui;

import '../../routes.dart';

// TODO Priority: Make game minimally viable ///////////////////////////////////////////////////////////
class WriteIntro extends StatefulWidget {

  @override
  _WriteIntroState createState() => _WriteIntroState();
}

class _WriteIntroState extends State<WriteIntro> with TickerProviderStateMixin {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.WRITE;
  final String thisSubPageName = WritePages.INTRO;

  late AnimationController _bgAnimController = new AnimationController(vsync: this);

  late AnimationController _routineController = new AnimationController(vsync: this);
  late Animation<double> _eat1Anim;
  late Animation<double> _eat2Anim;

  @override
  void initState() {
    super.initState();

    try{
      me = _bloc.model.me!;
      target = _bloc.model.dataModel.getMyTarget()!;
      isTargetMyself = _bloc.model.dataModel.isUser(target.id!);
      writeTruth = _bloc.model.dataModel.getTruth(target)!;

      _beginRoutine();
    }
    catch(e)
    {
      // TODO HANDLE INITIALIZATION ERROR
      print('Error initializing ' + thisPageName + ': ' + e.toString());
    }

    _bgAnimController.addListener(() {setState(() {

    });});
    _bgAnimController.duration = Duration(milliseconds: 8000);
    _bgAnimController.repeat();

    _routineController.duration = Duration(seconds: 10);
    _routineController.forward(from: 0);


    Animatable<double> scaleTween1 = Tween<double>(begin: 0, end: 1)
    //.chain(CurveTween(curve: SinCurve(factor: 1/4, amp: 1, abs: true)))
    //.chain(CurveTween(curve: Curves.easeIn))
        .chain(CurveTween(curve: OvershootCurve(3)))
        .chain(CurveTween(curve: OvershootCurve(3)))
        .chain(CurveTween(curve: OvershootCurve(3)))
        .chain(CurveTween(curve: OvershootCurve(3)))
        .chain(CurveTween(curve: OvershootCurve(3)))
    //.chain(CurveTween(curve: SinCurve(factor: 2.5, amp: 2)))
        ;
    Animatable<double> scaleTween2 = Tween<double>(begin: 0.3, end: 1)
        .chain(CurveTween(curve: OvershootCurve(3)));

    _eat1Anim = CurveTween(curve: Interval(0, 0.1))
        .animate(_routineController);
    _eat2Anim = CurveTween(curve: Interval(0.1, 0.2))
        .animate(_routineController);
  }


  Offset lastAvatarOffset = Offset(0, 0);

  Offset getAvatarOffset(BuildContext context){
    lastAvatarOffset = _avatarOffsetInternal(context);
    return lastAvatarOffset;
  }

  double standardOffset = -150;
  Offset _avatarOffsetInternal(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double v = _routineController.value;
    double l, u;

    l = 0; u = 0.25;
    if(v.isBetween(l, u, includeLower: true)){
      v = v.proportionInRange(l, u);

      v = DecelerateCurve(3).transform(v);
      v = OvershootCurve().transform(v);

      return Offset(0, standardOffset -(1-v)*size.height);
    }

    l = 0.25; u = 0.5;
    if(v.isBetween(l, u, includeLower: true)){
      v = v.proportionInRange(l, u);

      v = DecelerateCurve().transform(v);
      v = SinCurve(offset: (math.pi/2) + math.pi).transform(v);

      return Offset(0, standardOffset -(v + 1) * 10);
    }

    // l = 0.3; u = 0.5;
    // if(v.isBetween(l, u, includeLower: true)){
    //   v = v.proportionInRange(l, u);
    //
    //   v = DecelerateCurve().transform(v);
    //
    //   double dx = 50 * math.sin(v*2*pi*8);
    //   double dy = 50 * math.cos(v*2*pi*8);
    //
    //   return Offset(dx*(1-v), dy*(1-v));
    // }

    return lastAvatarOffset;
  }

  @override
  void dispose(){
    _bgAnimController.dispose();
    _routineController.dispose();
    super.dispose();
  }

  _beginRoutine(){
    String playerName = me.name!;
  }

  late Player me;
  late Player target;
  late bool isTargetMyself;
  late bool writeTruth;

  bool readiedUp = false;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          Player? target = state.model.dataModel.getMyTarget();
          bool? isTargetMyself = target == null ? null : state.model.dataModel.isUser(target.id!);
          bool? writeTruth = target == null ? null : state.model.dataModel.getTruth(target);

          bool sufficientInfo = target != null && isTargetMyself != null && writeTruth != null;

          Size size = MediaQuery.of(context).size;

          const double playersDim = 75;
          const double SAFE_AREA_PADDING = 25;
          const double AVATAR_PADDING = 50;
          double TRUE_AVATAR_WIDTH = size.width - 2*SAFE_AREA_PADDING - 2*AVATAR_PADDING;

          Offset avatarOffset = getAvatarOffset(context);
          var avatar = Avatar(me.profileImage, borderWidth: 0, size: Size(size.width, size.width))
              .xPadSym(h: AVATAR_PADDING)
              .xTranslate(dx: avatarOffset.dx, dy: avatarOffset.dy);

          List<Player?> playersExceptMe = state.model.getPlayersExcept([state.model.myId!]);
          var playerSquares = List.generate(playersExceptMe.length,
                  (i)
              {
                Player? player = playersExceptMe[i];
                const angleFactor = 0.5;
                double angle = ui.lerpDouble(-angleFactor*math.pi, angleFactor*math.pi,
                    (i + 0.5).toDouble()/playersExceptMe.length)!;

                double dx = 0*playersDim/2 + math.sin(angle)*TRUE_AVATAR_WIDTH/2;
                double dy = 0*playersDim/2 + math.cos(angle)*TRUE_AVATAR_WIDTH/2;
                dx = 0;
                dy = 0;

                return Positioned(
                  // top: lastAvatarOffset.dy,
                  // left: 0*i *
                  //     ((size.width - 2*SAFE_AREA_PADDING - playersDim/2)
                  //         / (state.model.roomPlayerCount - 1)),
                  child: Avatar(player!.profileImage,
                      shape: BoxShape.rectangle,
                      borderWidth: 0,
                      size: Size(playersDim,playersDim))
                      .xRotate(-angle)
                      .xTranslate(dx: -dx + lastAvatarOffset.dx, dy: -dy + lastAvatarOffset.dy)
                  ,//-math.cos(angle)*50),
                );

              });

          var eat1 = EntryAnimatedText(
              'It\'s time to get your secret role',
              scaleAnimation: _eat1Anim, scaleStagger: 0.25,
              style: AppStyles.defaultStyle(
                  fontSize: 54,
                  shadows: [AppShadows.cartoony]));

          var eat2 = EntryAnimatedText(
              'Do NOT reveal your role to anybody',
              scaleAnimation: _eat2Anim, scaleStagger: 0.25,
              style: AppStyles.defaultStyle(
                  fontSize: 54,
                  shadows: [AppShadows.cartoony]));

          var skipButton = Align(
            alignment: Alignment.bottomRight,
            child: CupertinoButton(
                child: Text('SKIP',
                  style: AppStyles.defaultStyle(fontSize: 36, color:  Colors.black),),
                onPressed: () => _goToMain(context)),
          );

          MovingGradient mg = MovingGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
            colors: [Colors.grey.withOpacity(0.6), Colors.white, Colors.grey],
            //colors: [Color.fromARGB(75, 179, 179, 179), Color.fromARGB(75, 232, 232, 232), Color.fromARGB(75, 154, 154, 154), Color.fromARGB(75, 210, 210, 210), Color.fromARGB(75, 255, 255, 255),],
            //colors: [Colors.black,Colors.white,]
            //colors: [Colors.black, Colors.white]
          );

          double v = _bgAnimController.value%1.0;
          var boxDeco1 = BoxDecoration(gradient: mg.getGradient(v));
         // var boxDeco2 = BoxDecoration(gradient: mg2.getGradient(_bgAnimController.value));

          var lg = LinearGradient(
            transform: GradientRotation(_val*math.pi*2),
              colors: [Colors.white, Colors.grey,Colors.white, Colors.grey,]);

          return Scaffold(
              backgroundColor: Colors.transparent,
              body: !sufficientInfo ? MyLoadingIndicator()
                  : SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [

                    avatar,

                    Container(child: eat1, width: 200, height: 200)
                        .xTranslate(dy: 100)
                        .xPadSym(h: 50, v: 0 ),

                    Container(child: eat2, width: 200, height: 200)
                        .xTranslate(dy: 200)
                        .xPadSym(h: 50, v: 0 ),

                    skipButton,

                    Positioned(bottom: 0,
                      child: Slider(
                        onChanged: (val) {setState(() {
                        _val = val;
                        //print(_val.toString());
                      });}, value: _val,),
                    )


                  ]
                    ..addAll(playerSquares),
                )
              ).xPadding(EdgeInsets.all(SAFE_AREA_PADDING))
                .xBoxDecorContainer(boxDeco1)
              //.xBoxDecorContainer(boxDeco2)

          );
        },
        listener: (context, state) {
          WriteRoutes.pageListener(context, state, thisPageName);
        });
  }

  void _goToMain(BuildContext context) => Navigator.of(context).pushNamed(WritePages.MAIN);

  double _val = 0.0;
}
