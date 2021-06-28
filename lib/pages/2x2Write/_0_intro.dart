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
import 'package:flutter_bull/utilities/design.dart';
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
import 'package:flutter_bull/utilities/curves.dart';
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

          var mg = MovingGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
            //colors: [Colors.grey.withOpacity(0.6), Colors.white, Colors.grey],
            //colors: [Color.fromARGB(75, 179, 179, 179), Color.fromARGB(75, 232, 232, 232), Color.fromARGB(75, 154, 154, 154), Color.fromARGB(75, 210, 210, 210), Color.fromARGB(75, 255, 255, 255),],
            colors: [Colors.white, Colors.blue,]
          );

          // var mg2 = MovingGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
          //   //colors: [Colors.grey.withOpacity(0.6), Colors.white, Colors.grey],
          //   colors: [Color.fromARGB(255, 232, 232, 232), Color.fromARGB(255, 210, 210, 210), Color.fromARGB(255, 255, 255, 255),],
          // );

          var boxDeco1 = BoxDecoration(gradient: mg.getGradient(_val));//_bgAnimController.value%1.0));
         // var boxDeco2 = BoxDecoration(gradient: mg2.getGradient(_bgAnimController.value));

          var lg = LinearGradient(
              colors: [Colors.white, Colors.grey,Colors.white, Colors.grey,]);

          return Scaffold(
              backgroundColor: Colors.red,
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
                        print(_val.toString());
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

class EntryAnimatedText extends StatefulWidget {

  EntryAnimatedText(this.text, {this.style, this.textAlign,
    this.scaleDuration, this.scaleStagger = 0, this.scaleAnimation});
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Duration? scaleDuration;
  final Animation<double>? scaleAnimation;
  final double scaleStagger;

  @override
  _EntryAnimatedTextState createState() => _EntryAnimatedTextState();
}

class _EntryAnimatedTextState extends State<EntryAnimatedText> with TickerProviderStateMixin {

  String get text => widget.text;
  TextStyle? get style => widget.style;
  TextAlign? get textAlign => widget.textAlign;
  Duration? get scaleDuration => widget.scaleDuration;
  // Animatable<double>? get scaleTween => widget.scaleTween;
  Animation<double>? get scaleAnimation => widget.scaleAnimation;
  double get scaleStagger => widget.scaleStagger;

  //late AnimationController scaleAnimController;

  late TextPainter tp = new TextPainter(textDirection: TextDirection.ltr);

  @override
  void initState() {
    super.initState();
    if(scaleDuration != null)
      {
        // scaleAnimController = new AnimationController(vsync: this, duration: scaleDuration);
        //
        // scaleAnimController.addListener(() {setState(() {});});
        // scaleAnimController.forward(from: 0);
      }


    _precalculateValues();
  }


  Map<String, double> textDistances = {}; // Map of characters and their laid out horizontal distance
  List<double> cumulativeTextDistances = []; // List of cumulative distance of entire text assuming text is laid out horizontally
  List<int> spaceIndices = []; // Indices where spaces occur in the text TODO Extend to any line-break worthy character
  double? lineHeight;

  void _precalculateValues() {
    cumulativeTextDistances = List.generate(text.length, (index) => 0.0);
    for(int i = 0; i < text.length; i++){
      String char = text[i];
      if(char == ' ') spaceIndices.add(i);
      double d = 0.0;
      if(textDistances.containsKey(char)) d = textDistances[char]!;
      else {
        tp.text = TextSpan(text: char, style: style);
        tp.layout();
        d = tp.maxIntrinsicWidth;
        textDistances.addAll({char : d});
        if(lineHeight == null) lineHeight = tp.height;
      }
      if(i == 0) cumulativeTextDistances[i] = d;
      else cumulativeTextDistances[i] = cumulativeTextDistances[i-1] + d;
    }

    print('textDistances: ' + textDistances.toString());
    print('cumulativeTextDistances: ' + cumulativeTextDistances.toString());
    print('spaceIndices: ' + spaceIndices.toString());
  }

  @override
  void dispose() {
    //scaleAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return CustomPaint(
      size: size,
      painter: EntryAnimatedTextPainter(
          text,
          textDistances, cumulativeTextDistances, spaceIndices, lineHeight ?? 0.0,
          scaleAnimation: scaleAnimation, scaleStagger: scaleStagger, //scaleTween: scaleTween,
          style: style));
  }
}

class EntryAnimatedTextPainter extends CustomPainter {

  EntryAnimatedTextPainter(this.text,
      this.textDistances, this.cumulativeTextDistances, this.spaceIndices, this.lineHeight,
      {this.style, this.scaleAnimation, this.scaleStagger = 0, this.scaleTween})
  {
    if(scaleAnimation != null) _initAnimations();
  }

  late TextPainter tp = new TextPainter(textDirection: TextDirection.ltr);
  final String text;
  final TextStyle? style;

  final Animation<double>? scaleAnimation;
  final Animatable<double>? scaleTween;
  final double scaleStagger;


  List<Animation> anims = [];

  void _initAnimations() {
    assert(scaleAnimation != null);

    int n = text.length;
    double frac = 1/n;
    double dur = ui.lerpDouble(frac, 1.0, (1 - scaleStagger))!;
    double incr = (1-dur)/n;

    double begin = 0.0;
    double end = dur;

    for(int i = 0; i < text.length; i++){
      //var curve = Interval(begin, end, curve: scaleTween);
      var entryAnim = CurveTween(curve: Interval(begin, end)).animate(scaleAnimation!);
      anims.add(entryAnim);

      begin += incr;
      end += incr;
    }
  }

  final Map<String, double> textDistances; // Map of characters and their laid out horizontal distance
  final List<double> cumulativeTextDistances; // List of cumulative distance of entire text assuming text is laid out horizontally
  final List<int> spaceIndices; // Indices where spaces occur in the text TODO Extend to any line-break worthy character
  final double lineHeight;

  int get n => text.length;

  // TODO Fix text overflow issue
  @override
  void paint(Canvas canvas, Size size) {

    double w = size.width;
    double h = size.height;

    int start = 0;
    double lineDistance = 0.0;
    double distanceBeforeLastSpace = 0.0;
    int indexBeforeLastSpace = 0;
    int indexAfterLastSpace = 0;
    double lastLinesDistance = 0.0;

    int i = 0;
    while(i < n){
      while(i < n && text[i] != ' ') i++;

      indexBeforeLastSpace = i-1;
      distanceBeforeLastSpace = cumulativeTextDistances[indexBeforeLastSpace] - lastLinesDistance;

      while(i < n && text[i] == ' ') i++; // Advances i to start of next word
      indexAfterLastSpace = i;

      lineDistance = cumulativeTextDistances[indexBeforeLastSpace] - lastLinesDistance;
      if(lineDistance >= w || i == n){
        //print(i.toString() + ' ' + lineDistance.toString());

        int j = indexBeforeLastSpace;
        double d = distanceBeforeLastSpace;

        double marginDistance = w - d;
        marginDistance /= 2;

        canvas.translate(marginDistance, 0);
        double x = 0.0;
        for(int k = start; k <= j; k++){
          double d = _drawLetter(canvas, size, k);
          canvas.translate(d, 0);
          x += d;
        }
        canvas.translate(-x - marginDistance, lineHeight);

        lastLinesDistance = cumulativeTextDistances[indexAfterLastSpace-1];
        start = indexAfterLastSpace;
        i = indexAfterLastSpace;
      };

    }

    //print('end');
    // dx = 0.0;
    // dy = 0.0;
    // x = 0.0;
    // lastBreak = 0;
    // nextBreak = spaceIndices[0];
    // spaceIndex = 0;
    // wrapAtNextSpace = false;
    // notWrappedYet = true;
    // lastWrap = 0;
    //
    // tp.text = TextSpan(text: ' ', style: style);
    // tp.layout(minWidth: 0, maxWidth: double.maxFinite);
    // double spaceLength = tp.maxIntrinsicWidth;
    //
    // for(int i = 0; i < text.length; i++){
    //
    //   if(text[i] == ' ') {
    //     if(wrapAtNextSpace){
    //       canvas.translate(-x - (notWrappedYet ? spaceLength : 0), tp.height);
    //       x = 0.0;
    //       wrapAtNextSpace = false;
    //       if(notWrappedYet) notWrappedYet = false;
    //       //lastWrap =
    //     }
    //
    //     spaceIndex++;
    //     lastBreak = nextBreak + 1;
    //     nextBreak = spaceIndices[spaceIndex];
    //   }
    //
    //   // TODO Cache measurements for next round
    //   // Measure current 'word'
    //   String word = text.substring(lastBreak, nextBreak);
    //   tp.text = TextSpan(text: word, style: style);
    //   tp.layout(minWidth: 0, maxWidth: double.maxFinite);
    //
    //   double w = tp.maxIntrinsicWidth;
    //
    //   if(x + w + spaceLength >= size.width) {
    //     wrapAtNextSpace = true;
    //   }
    //
    //   _drawLetter(canvas, size, i);
    // }
  }

  /// Returns the maxInstrinsicWidth of the given laid-out letter
  double _drawLetter(Canvas canvas, Size size, int i) {

    double v;

    try{
      v = anims[i].value;
    }catch(e)
    {
      v = 1;
    }

    String s = text[i];

    tp.text = TextSpan(text: s, style: style);
    tp.layout();

    double w = tp.maxIntrinsicWidth;
    double h = tp.height;
    Offset c = new Offset(w/2, h/2);

    canvas.translate((1-v)*c.dx, (1-v)*c.dy);
    canvas.scale(v);
    tp.paint(canvas, Offset(0,0));
    canvas.scale(1/v);
    canvas.translate(-(1-v)*c.dx, -(1-v)*c.dy);

    return w;
    // if(x + dx >= size.width){
    //   canvas.translate(-x + dx, tp.height);
    //   x = 0.0;
    // }
    // else{
    // }
  }

  bool get _shouldRepaint => true;//!controller!.isCompleted; // TODO Optimize

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return _shouldRepaint;
  }




}

