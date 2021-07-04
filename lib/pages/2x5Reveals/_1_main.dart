import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_events.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_states.dart';
import 'package:flutter_bull/pages/2GameRoom/routes.dart';
import 'package:flutter_bull/pages/2x1Lobby/_page.dart';
import 'package:flutter_bull/pages/2x2Write/routes.dart';
import 'package:flutter_bull/pages/2x5Reveals/routes.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
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
import '../../classes/classes.dart';
import 'package:extensions/extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';


class RevealsMain extends StatefulWidget {
  static const String ROUTE_ARGS_TURN = 'turn';

  RevealsMain({required this.turn});
  //final GlobalKey<NavigatorState> nav;
  final int turn;

  @override
  _RevealsMainState createState() => _RevealsMainState();
}

class _RevealsMainState extends State<RevealsMain> with TickerProviderStateMixin {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.REVEALS;
  final String thisSubPageName = RevealsPages.MAIN;

  late AnimationController _entranceController;
  late AnimationController _focusEngagedController;
  late AnimationController _rotateAnimController;
  late AnimationController _scrollFocusChangedAnimController;
  late ScrollController _scrollController;

  static const int LINGER_DURATION_MILLISECONDS = 2000;
  static const int SCROLL_ANIMATION_DURATION_MILLISECONDS = 500;
  static const Curve SCROLL_ANIMATION_CURVE = Curves.easeInOutCirc;

  @override
  void initState() {

    super.initState();
    _entranceController = AnimationController(vsync: this);
    _entranceController.duration = Duration(seconds: 2);
    _entranceController.addListener(() {setState(() {    });});
    _entranceController.forward();

    _focusEngagedController = AnimationController(vsync: this);
    _focusEngagedController.duration = Duration(milliseconds: 500);
    _focusEngagedController.addListener(() {setState(() {});});
    _focusEngagedController.forward();

    _rotateAnimController = AnimationController(vsync: this, lowerBound: 0, upperBound: 2*math.pi);
    _rotateAnimController.duration = Duration(seconds: 20);
    _rotateAnimController.addListener(() {setState(() {});});
    _rotateAnimController.repeat();

    _scrollFocusChangedAnimController = AnimationController(vsync: this, lowerBound: 0, upperBound: 1);
    _scrollFocusChangedAnimController.duration = Duration(milliseconds: 300);
    _scrollFocusChangedAnimController.addListener(() {setState(() {});});
    _scrollFocusChangedAnimController.forward(from: 0);

    // int playerCount = _bloc.model.roomPlayerCount;
    // _listVerticalityController = AnimationController(vsync: this, lowerBound: 0,
    //     upperBound: playerCount * (AVATAR_V_PADDING * 2 + AVATAR_DIM));
    // _listVerticalityController.duration = Duration(seconds: 20);
    // _listVerticalityController.addListener(() {setState(() {});});
    // _listVerticalityController.repeat();

    _scrollController = new ScrollController(initialScrollOffset: math.max(0, widget.turn - 1) * AVATAR_WIDTH);
    _scrollController.addListener(() {

      // if(_scrollController.hasClients && !b)
      //   {
      //     print('Running routine...');
      //     _runRoutineOnce();
      //     b = true;
      //   }

      _debugTextController.text = _scrollController.offset.toString();
      setState(() {
        _recalculateScrollFocus();
      });
    });

    _runRoutineOnce();
    //_scrollController.jumpTo(_bloc.model.room!.turn! * AVATAR_WIDTH);
  }

  // bool b = false;


  Future<void> _runRoutineOnce() async {

    print('Running routine: turn = ' + widget.turn.toString());

    await Future.delayed(Duration(milliseconds: 500));

    if(widget.turn == 0)
    {
      await Future.delayed(Duration(milliseconds: LINGER_DURATION_MILLISECONDS));
      _goToSubPage();
    }
    else
    {
      _scrollToFocusOn(widget.turn);
    }

  }

  bool lock = false;
  _goToSubPage() async {
    if(!lock){
      lock = true;
      Navigator.of(context).pushNamedAndRemoveUntil(RevealsPages.SUB, (route) => false,
          arguments: _bloc.model.getPlayerFromOrder(mostFocusedIndex)!.id);
    }
  }


  late int mostFocusedIndex = math.max(0, widget.turn - 1);
  double _getFocusRating(int index){

    double _scrollOffset = _scrollController.offset;

    double center = (index * AVATAR_WIDTH);
    double left = center - AVATAR_WIDTH;
    double right = center + AVATAR_WIDTH;

    if(left <= _scrollOffset && _scrollOffset < right)
      {
        double d = center - _scrollOffset;
        //d = d.sign < 0 ? -d : d;
        return -((d / (AVATAR_WIDTH)));
      }
    else if(_scrollOffset < left) return -1.0;
    else return 1.0;
  }
  
  void _recalculateScrollFocus(){
    int provisionalMostFocusedIndex = (_scrollController.offset / AVATAR_WIDTH).round();
    if(provisionalMostFocusedIndex != mostFocusedIndex)
    {
      setState(()
      {
          mostFocusedIndex = provisionalMostFocusedIndex;
          _onScrollFocusChanged();
      });
    }
  }

  Future<void> _onScrollFocusChanged() async {
    _scrollFocusChangedAnimController.forward(from: 0);
    await Future.delayed(Duration(milliseconds: LINGER_DURATION_MILLISECONDS));
    _goToSubPage();
  }

  Future<void> _scrollToFocusOn(int index) async{
    print('Scrolling to focus on ${index.toString()}');
    double offset = (index*AVATAR_WIDTH).clamp(0, _scrollController.position.maxScrollExtent);
    await _scrollController.animateTo(offset, duration: Duration(milliseconds: SCROLL_ANIMATION_DURATION_MILLISECONDS), curve: SCROLL_ANIMATION_CURVE);
  }

  // Important layout values
  static const double AVATAR_DIM = 100;
  static const double AVATAR_V_PADDING = 8;
  static const double AVATAR_WIDTH = AVATAR_DIM + AVATAR_V_PADDING*2;

  TextEditingController _debugTextController = new TextEditingController();
  _debugAction(){
    _debugAction2();
  }
  void _debugAction1(){
    String val = _debugTextController.text;
    double d = double.parse(val);
    _scrollController.animateTo(d, duration: Duration(seconds: 1), curve: Interval(0, 1));
  }
  void _debugAction2(){
    String val = _debugTextController.text;
    int i = int.parse(val);
    _scrollToFocusOn(i);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _rotateAnimController.dispose();
    _focusEngagedController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          if(!state.model.isThereEnoughInfoForResults) return MyLoadingIndicator();

          int turn = state.model.room!.turn!;
          int revealed = state.model.room!.revealed!;

          int count = state.model.roomPlayerCount;// (state.model.roomPlayerCount * 3) + 2;

          //Widget page = SizedBox(height: MediaQuery.of(context).size.height);

          //try{
            Player playerWhoseTurn = state.model.getPlayerWhoseTurn()!;
            String text = state.model.getPlayerText(playerWhoseTurn.id)!;
            bool truth = state.model.getPlayerTruth(playerWhoseTurn.id)!;

            double bigDim = 400;

            Widget avatar = Avatar(playerWhoseTurn.profileImage, size: Size(bigDim, bigDim), borderWidth: 3);
            //Widget bubble = MyBubble(text, size: Size(bigDim, bigDim)).PaddingExt(EdgeInsets.all(24));

            bool hasBeenRevealed = turn < revealed;
            if(!hasBeenRevealed)
              {
                avatar = avatar.xHero(playerWhoseTurn.id! + 'image');
                //bubble = bubble.HeroExt(playerWhoseTurn.id! + 'bubble');
              }

            // Widget focus = GestureDetector(
            //   onTap: () async {
            //     await Navigator.pushNamed(context, RevealsPages.SUB, arguments: playerWhoseTurn.id!);
            //     _onNavigatorPopped();
            //   },
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       avatar.FlexibleExt(),
            //       bubble.FlexibleExt()
            //     ],
            //   ),
            // );

          //}catch(e){
           // print('ERROR: ' + e.toString());
          //}


          double screenHeight = MediaQuery.of(context).size.height;
            //print(screenHeight);
          Widget emptyPage = Container(height: screenHeight,);

          Widget list = ListView.builder(
              //controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: count + 2,
              clipBehavior: Clip.none,
              itemBuilder: (context, i)
              {

                if(i < 1 || i == count + 1) return SizedBox(height: AVATAR_DIM, width: AVATAR_DIM);
                i -= 1;

                double focus = _getFocusRating(i);
                //focus *= _focusEngagedController.value;
                double focusAbs = 1 - focus.abs();

                Player player = state.model.getPlayerFromOrder(i)!;
                String text = state.model.getPlayerText(player.id)!;
                bool truth = state.model.getPlayerTruth(player.id)!;

                bool isTurn = i == turn;
                bool hasBeenTurn =  i < turn;
                bool hasBeenRevealed = i < revealed;

                Widget avatar = Avatar(player.profileImage, size: Size(AVATAR_DIM, AVATAR_DIM), borderWidth: 3);

                const double translateExtent = 40;

                avatar = avatar.xHero(player.id! + 'image').xOpacity(0.5 + 0.5*focusAbs);
                avatar = avatar.xScale(focusAbs + 1);
                avatar = avatar.xTranslate(dx: translateExtent * -focus);
                //avatar = _entranceAnimatedAvatar(avatar);
                //if(!hasBeenRevealed && !isTurn) bubble = bubble.InvisibleIgnoreExt();

                // Widget truthTag = Transform.rotate(angle: -0.3,
                //     child: Text(
                //         truth ? 'TRUE' : 'BULL',
                //         style: truth ? AppStyles.TruthStyle(fontSize: 32) : AppStyles.BullStyle(fontSize: 32)));

                Widget item = GestureDetector(
                  onTap: () {
                    _goToSubPage();
                  },
                  child: Align(child: avatar, alignment: Alignment.bottomLeft).xPadding(EdgeInsets.all(AVATAR_V_PADDING)),
                );

                //item = item.ScaleExt(_entranceController.value);
                //if(turn < count) item = item.OpacityExt(0.5);

                return item;


              });
          //String focusText = mostFocusedIndex.toString();

          Player focusedPlayer = state.model.getPlayerFromOrder(mostFocusedIndex.clamp(0, count-1))!;
          String focusText = state.model.getPlayerText(focusedPlayer.id!)!;
          Widget focusTextWidget = Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: MyBorderRadii.ALL

            ),
            child: Center(
              child: AutoSizeText(
                focusText,
                textAlign: TextAlign.center,
                style: AppStyles.defaultStyle(fontSize: 100, color: Colors.black),
                minFontSize: 10,
              ).xPadding(EdgeInsets.all(24)),
            ),
          ).xOpacity(_scrollFocusChangedAnimController.value)
              .xTranslate(dy: -10*(1-_scrollFocusChangedAnimController.value))
              .xPadding(EdgeInsets.all(16));

          focusTextWidget = focusTextWidget.xHero(focusedPlayer.id! + 'bubble');

          return Scaffold(
              backgroundColor: AppColors.revealsScaffoldBackgroundColor,
              body: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Center(
                      child: Image(
                        image: Assets.images.spiny1,
                        color: Colors.white,
                      ).xRotate(_rotateAnimController.value),
                    ),

                    Column(
                      children: [
                        list.xPadding(EdgeInsets.all(50)).xExpanded(),
                        Container(
                            child:

                                Column(
                                  children: [

                                    focusTextWidget
                                        .xExpanded(),

                                    EmptyWidget().xExpanded()

                                  ],
                                )


                          ).xExpanded()
                      ],
                    ),

                    // Column(
                    //   children: [
                    //     CupertinoTextField(controller: _debugTextController,),
                    //     CupertinoButton(child: Text('Enter'), onPressed: () => _debugAction()),
                    //     CupertinoButton(child: Text('Clear'), onPressed: () => _debugTextController.clear())
                    //   ],
                    // )

                  ],
                ),
              )

          );
        },
        listener: (context, state) {

          // if(state is NewTurnState)
          //   {
          //     print('new turn: ' + state.model.room!.turn!.toString());
          //     _scrollToFocusOn(state.newTurn);
          //   }

        });
  }



}