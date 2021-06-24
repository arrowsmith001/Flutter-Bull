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
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/design.dart';
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

  late AnimationController _animController = new AnimationController(vsync: this);
  late Animation _avatarAnim;

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

    _animController.duration = Duration(seconds: 10);
    _avatarAnim = new CurvedAnimation(parent: _animController, curve: Interval(0.0, 0.1, curve: Curves.easeOutCubic));
    _animController.forward(from: 0);
  }

  @override
  void dispose(){
    _bgAnimController.dispose();
    _animController.dispose();
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
          double fontSize = 32;
          TextStyle style = AppStyles.defaultStyle(fontSize: fontSize, color: Colors.black);
          TextStyle boldStyle = AppStyles.defaultStyle(fontSize: 48, color: Colors.black, fontWeight: FontWeight.w900);
          TextStyle truthStyle =  AppStyles.TruthStyle(fontSize: fontSize);
          TextStyle bullStyle =  AppStyles.BullStyle(fontSize: fontSize);

          Size size = MediaQuery.of(context).size;
          double dim = (size.width / 3) - 20;

          var eat =
          Stack(
            children:
          [
            EntryAnimatedText(
                'It\'s time to get your secret role',
                style: AppStyles.defaultStyle(
                    fontSize: 54,
                    shadows: [AppShadows.cartoony])).xPadSym(h: 25)
          ],);

          var mg = MovingGradient(begin: Alignment.centerRight, end: Alignment.centerLeft,
            //colors: [Colors.grey.withOpacity(0.6), Colors.white, Colors.grey],
            colors: [Color.fromARGB(75, 179, 179, 179), Color.fromARGB(75, 232, 232, 232), Color.fromARGB(75, 154, 154, 154), Color.fromARGB(75, 210, 210, 210), Color.fromARGB(75, 255, 255, 255),],
          );

          var mg2 = MovingGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
            //colors: [Colors.grey.withOpacity(0.6), Colors.white, Colors.grey],
            colors: [Color.fromARGB(255, 232, 232, 232), Color.fromARGB(255, 210, 210, 210), Color.fromARGB(255, 255, 255, 255),],
          );

          var boxDeco1 = BoxDecoration(gradient: mg.getGradient((_bgAnimController.value*2)%1.0));
          var boxDeco2 = BoxDecoration(gradient: mg2.getGradient(_bgAnimController.value));

          List<Player?> playersExceptMe = state.model.getPlayersExcept([state.model.myId!]);

          return Scaffold(
              backgroundColor: Colors.transparent,
              body: !sufficientInfo ? MyLoadingIndicator()
                  : SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [

                    Column(
                      children: [
                        Avatar(me.profileImage, borderWidth: 0)
                            .xPadAll(35)
                            .xTranslate(dy: -size.height/2 * (1 - _avatarAnim.value))
                            .xExpanded(),

                        eat.xPadOnly(right: 50).xExpanded(),
                      ],
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: CupertinoButton(
                          child: Text('SKIP',
                            style: AppStyles.defaultStyle(fontSize: 36, color:  Colors.black),),
                          onPressed: () => _goToMain(context)),
                    )
                  ]
                    ..addAll(List.generate(playersExceptMe.length,
                            (i) {
                    Player? player = playersExceptMe[i];

                    return Positioned(
                      bottom: 75,
                      left: i * size.width / (state.model.roomPlayerCount -1),
                      child: Avatar(player!.profileImage,
                          shape: BoxShape.rectangle,
                          borderWidth: 0,
                          size: Size(75,75)),
                    );

                  })),
                )
              ).xPadding(EdgeInsets.all(20))
                .xBoxDecorContainer(boxDeco1)
              .xBoxDecorContainer(boxDeco2)

          );
        },
        listener: (context, state) {
          WriteRoutes.pageListener(context, state, thisPageName);
        });
  }

  void _goToMain(BuildContext context) => Navigator.of(context).pushNamed(WritePages.MAIN);
}

class EntryAnimatedText extends StatefulWidget {

  EntryAnimatedText(this.text, {this.style, this.textAlign});
  String text;
  TextStyle? style;
  TextAlign? textAlign;

  @override
  _EntryAnimatedTextState createState() => _EntryAnimatedTextState();
}

class _EntryAnimatedTextState extends State<EntryAnimatedText> with SingleTickerProviderStateMixin {

  late AnimationController animController1 = new AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    animController1.duration = new Duration(milliseconds: 3000);
    animController1.forward(from: 0);
    animController1.addListener(() {setState(() {});});
    animController1.addStatusListener((status) {
      // if(status == AnimationStatus.completed)
      //   {
      //     setState(() {
      //       controllerNumber = 2;
      //       animController2.repeat();
      //     });
      //   }
    });

    animController1.repeat();
  }

  @override
  void dispose() {
    animController1.dispose();
    super.dispose();
  }

  int controllerNumber = 1;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return CustomPaint(
      size: size,
      painter: EntryAnimatedTextPainter(
          widget.text,
          controllerNumber: controllerNumber,
          controller1: animController1,
          stagger: 0.6,
          style: widget.style),);
  }
}

class EntryAnimatedTextPainter extends CustomPainter {

  // TODO Precalculate as much as possible
  EntryAnimatedTextPainter(this.text,
      {this.style, this.controller1, this.controllerNumber = 1, double? stagger,})
  {
    if(stagger == null) this.stagger = 0;

    if(controller1 != null){
      _initAnimations();
    }

    _precalculateValues();
  }

  int controllerNumber;
  AnimationController? controller1;
  String text;
  TextStyle? style;
  List<Animation> anims1 = [];
  late List<int> spaceIndices;
  int spaceIndex = 1;
  late double stagger;

  late TextPainter tp = new TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    dx = 0.0;
    dy = 0.0;
    x = 0.0;
    lastBreak = 0;
    nextBreak = spaceIndices[0];
    spaceIndex = 0;
    wrapAtNextSpace = false;
    notWrappedYet = true;
    lastWrap = 0;

    tp.text = TextSpan(text: ' ', style: style);
    tp.layout(minWidth: 0, maxWidth: double.maxFinite);
    double spaceLength = tp.maxIntrinsicWidth;

    for(int i = 0; i < text.length; i++){

      if(text[i] == ' ') {
        if(wrapAtNextSpace){
          canvas.translate(-x - (notWrappedYet ? spaceLength : 0), tp.height);
          x = 0.0;
          wrapAtNextSpace = false;
          if(notWrappedYet) notWrappedYet = false;
          //lastWrap =
        }

        spaceIndex++;
        lastBreak = nextBreak + 1;
        nextBreak = spaceIndices[spaceIndex];
      }

      // TODO Cache measurements for next round
      // Measure current 'word'
      String word = text.substring(lastBreak, nextBreak);
      tp.text = TextSpan(text: word, style: style);
      tp.layout(minWidth: 0, maxWidth: double.maxFinite);

      double w = tp.maxIntrinsicWidth;

      if(x + w + spaceLength >= size.width) {
        wrapAtNextSpace = true;
      }

      _drawLetter(canvas, size, i);
    }
  }
  bool wrapAtNextSpace = false;
  bool notWrappedYet = true;
  double dx = 0.0;
  double dy = 0.0;
  double x = 0.0;
  int lastBreak = 0;
  int nextBreak = 0;
  int lastWrap = 0;

  void _drawLetter(Canvas canvas, Size size, int i) {

    double v = 0.5*(1 + math.sin(anims1[i].value * math.pi * 2)) * anims1[i].value*2;

    String s = text[i];

    tp.text = TextSpan(text: s, style: style);
    tp.layout(minWidth: 0, maxWidth: double.maxFinite);

    double w = tp.maxIntrinsicWidth;
    double h = tp.height;
    Offset c = new Offset(w/2, h/2);

    canvas.translate((1-v)*c.dx, (1-v)*c.dy);
    canvas.scale(v);
    tp.paint(canvas, new Offset(0,0));
    canvas.scale(1/v);
    canvas.translate(-(1-v)*c.dx, -(1-v)*c.dy);

    dx = tp.maxIntrinsicWidth;
    x += dx;

    // if(x + dx >= size.width){
    //   canvas.translate(-x + dx, tp.height);
    //   x = 0.0;
    // }
    // else{
    canvas.translate(dx, 0);
    // }

  }

  bool get _shouldRepaint => !controller1!.isCompleted;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return _shouldRepaint;
  }

  void _initAnimations() {
    int n = text.length;
    double frac = 1/n;
    double dur = ui.lerpDouble(frac, 1.0, stagger)!;
    double incr = (1-dur)/n;

    double begin = 0.0;
    double end = dur;

    for(int i = 0; i < text.length; i++){
      var curve = Interval(begin, end, curve: OvershootCurve(5));
      var entryAnim = CurvedAnimation(parent: controller1!, curve: curve);
      anims1.add(entryAnim);

      begin += incr;
      end += incr;
    }
  }

  void _precalculateValues() {
    // TODO Precalculate as much as possible
    List<String> spaces = text.split(' ');
    int i = 0;
    spaceIndices = List.generate(spaces.length, (index) {
      i += (spaces[index].length + (index == 0 ? 0 : 1));
      return i;
    });
  }


}

