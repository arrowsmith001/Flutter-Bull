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
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/utilities/misc.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
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


class Lobby extends StatefulWidget {

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> with SingleTickerProviderStateMixin {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);
  final String thisPageName = RoomPages.LOBBY;
  late AnimationController _animController;
  OvershootInterpolator interp = new OvershootInterpolator(2);

  late List<String> playerIdsLocal;

  static const double AVATAR_DIM = 125;
  static const double AVATAR_PADDING = 8;
  static const int PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS = 250;

  @override
  void initState() {
    super.initState();

    playerIdsLocal = List.from(_bloc.model.room!.playerIds!);

    _animController = new AnimationController(vsync: this);
    _animController.addListener(() {setState(() { });});
    _animController.duration = Duration(milliseconds: 10000);
    _animController.repeat();
  }

  @override
  void dispose(){
    _animController.dispose();
    super.dispose();
  }

  void startGame() {
    _bloc.add(StartGameRequestedEvent());
  }

  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  ScrollController _scrollController = new ScrollController();

  void _onPlayerRemoved(int index, String userId, GameRoomModel model) async {

    if (_listKey.currentState != null) {

      _listKey.currentState!.removeItem(index,
              (context, animation) => _buildListItem(context, index, animation, null),
          duration: Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS));

      playerIdsLocal.remove(userId);
    }

  }

  // void _onPlayerRemovedFinished(String userId){
  //   print('_onPlayerRemovedFinished' + ' ' + userId);
  //   playerListItemStateKeys.remove(userId);
  //   playerIdsLocal.remove(userId);
  //   setState(() {});
  // }

  void _onPlayerAdded(int index, String userId, GameRoomModel model) async {
    if (_listKey.currentState != null) {

      playerIdsLocal.add(userId);
      _listKey.currentState!.insertItem(index, duration: Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS));

      await Future.delayed(Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS)); // TODO Make syncronous if possible
      double val = _scrollController.position.maxScrollExtent;// + AVATAR_DIM + 2 * AVATAR_PADDING;
      if(_scrollController.position.userScrollDirection == ScrollDirection.idle) _scrollController.animateTo(val, duration: Duration(milliseconds: 250), curve: Interval(0, 1));
    }
  }

  Widget _buildListItem(BuildContext context, int i, Animation<double>? animation, GameRoomModel? model) {
    Player? player = model != null && i < playerIdsLocal.length ? model.getPlayer(playerIdsLocal[i]) : null;
    int playerScore = player == null || model == null ? 0 : model.getPlayerScore(player.id!) ?? 0;
    Animation<double>? anim = animation == null ? null : CurvedAnimation(parent: animation, curve: OvershootCurve());
    AnimatedListItem item =  AnimatedListItem(player: player, score: playerScore, index: i, animation: anim);
    return item;
  }

  // Widget _buildAvatar(BuildContext context, Animation? animation, GameRoomModel? model, [double radialOffsetValue = 0]) {
  //   if(animation != null) animation.addListener(() {setState(() {});});
  //
  //   final Player? player = widget.player;
  //   final Image? image = player == null ? null : player.profileImage;
  //
  //   double screenHeight = MediaQuery.of(context).size.width;
  //   double dim = AVATAR_DIM;
  //
  //   var avatar = Avatar(image,
  //       size: Size(dim,dim),
  //       loading: image == null,
  //       defaultImage: null)
  //       .SizedBoxExt(height: dim, width: dim);
  //   //.PaddingExt(EdgeInsets.all(spacing));
  //
  //   String playerName = player == null || player.name == null ? '' : player.name!;
  //   var name = Container(
  //     decoration: BoxDecoration(color: AppColors.MainColor),
  //     child: Center(
  //       child: AutoSizeText(playerName,
  //           maxLines: 1,
  //           minFontSize: 10,
  //           style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: FontFamily.lapsusProBold))
  //           .PaddingExt(EdgeInsets.symmetric(horizontal: 8)),
  //     ),
  //   );
  //
  //   String scoreString = widget.score.toString();
  //   var score = Container(
  //     decoration: BoxDecoration(color: AppColors.ScoreColor),
  //     child: Center(
  //       child: AutoSizeText(scoreString,
  //           maxLines: 1,
  //           minFontSize: 10,
  //           style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: FontFamily.lapsusProBold))
  //       ,
  //     ),
  //   );
  //
  //   const double MINIMUM_NAME_TAG_WIDTH = 60;
  //   const double MAXIMUM_NAME_TAG_WIDTH = 150;
  //   double nameTagWidth = ui.lerpDouble(MINIMUM_NAME_TAG_WIDTH, MAXIMUM_NAME_TAG_WIDTH, Utils.howLongIsThisName(playerName))!;
  //
  //   // TODO Style waiting room page ////////////////////////////////////////////////////////
  //   double radiusOffset = 20;
  //   double totalDim = AVATAR_DIM + radiusOffset*2;
  //   var circularText = CircularText(
  //     radius: (AVATAR_DIM / 2) + radiusOffset,
  //     children: [
  //       TextItem(
  //           startAngle: 270 + radialOffsetValue - Utils.howLongIsThisName(playerName) * 50,
  //           space: 12,
  //           text: Text(playerName, style: AppStyles.defaultStyle(fontSize: 24),))
  //     ],);
  //
  //   var finalWidget = Stack(
  //     children: [
  //       Center(child: avatar.PaddingExt(EdgeInsets.all(radiusOffset))),
  //       Center(child: circularText,)
  //     ],
  //   ).SizedBoxExt(height: totalDim, width: totalDim);
  //
  //   return finalWidget
  //       .ScaleExt(animation.value);
  //
  // }

  Widget _buildWrapOfLocalPlayers(GameRoomModel model) {
    return Wrap(
      children: List.generate(playerIdsLocal.length, (i) => _buildListItem(context, i, null, model)),
    );
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state) async{

        GameRoomRoutes.pageListener(context, state, thisPageName);

        if(state is NewRoomState)
        {
          setState(() {
            _listKey = new GlobalKey();
          });
        }

        if(state is RoomPlayerRemovedState) {
          _onPlayerRemoved(state.index, state.userId, state.model);
        }

        if(state is RoomPlayerAddedState) {
          _onPlayerAdded(state.index, state.userId, state.model);
        }
      },

      builder: (context, state) {

        GameRoomModel? model = state.model;
        Room? room = model == null ? null : model.room;

        if(room == null || model == null) return Center(child:  MyLoadingIndicator(),);

        // Widget TopBit = Container(
        //     decoration: BoxDecoration(
        //         gradient: RadialGradient(colors: [Color.fromARGB(255, 174, 187, 243), Colors.indigo], focal: Alignment.topLeft, radius: 2, stops: [0, 0.4])),
        //
        //     child: room == null || room.code == null ? EmptyWidget()
        //         : Column(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //
        //         model.getHostIndex() != null ? _buildAvatar(context, model.getHostIndex()!, null, model).FlexibleExt() : EmptyWidget(),
        //
        //         Text(model.roomPlayerCount.toString(), style: AppStyles.MainMenuButtonTextStyle(32, Colors.white)),
        //
        //         Align(
        //           alignment: Alignment.bottomRight,
        //           child: AutoSizeText(room.code!,
        //               minFontSize: 24,
        //               style: TextStyle(
        //                   fontSize: 72,
        //                   color: Colors.white,
        //                   fontFamily: FontFamily.lapsusProBold)),
        //         ).FlexibleExt(),
        //
        //       ],
        //     )
        //         .PaddingExt(EdgeInsets.symmetric(horizontal: 15, vertical: 5))
        //
        // );
        Widget topBit = EmptyWidget();

        // TODO Position list on right
        Widget list = AnimatedList(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          reverse: false,
          shrinkWrap: true,
          key: _listKey,
          initialItemCount: playerIdsLocal.length,
          itemBuilder: (BuildContext context, int i, Animation<double> animation)
          {
            return _buildListItem(context, i, animation, model);
          },
        );

        //list = _buildWrapOfLocalPlayers(model);

        Widget WaitingRoom =
        Scaffold(
          floatingActionButton: model.amIHost ? FloatingActionButton(onPressed: () => startGame()) : null,
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 13, 23, 132),
                      Color.fromARGB(255, 143, 147, 246),
                      Color.fromARGB(255, 143, 147, 246),
                      Color.fromARGB(255, 56, 65, 220),
                    ],
                  )
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: list,
                ),
              ),
            ),
          ),
        );

        return WaitingRoom;
      },
    );
  }



}

class AnimatedListItem extends StatefulWidget {
  AnimatedListItem({required this.player, required this.animation, required this.index, this.score = 0});
  final Animation<double>? animation;
  final Player? player;
  final int score;
  final int index;

  @override
  _AnimatedListItemState createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> with TickerProviderStateMixin {
  late AnimationController _animController;

  // TODO Remove repeats
  static const double AVATAR_DIM = 125;
  static const double AVATAR_PADDING = 8;

  @override
  initState(){
    super.initState();

    _animController = new AnimationController(vsync: this);
    _animController.duration = Duration(seconds: 40);
    _animController.addListener(() {setState(() {
      radialOffsetValue = 360*_animController.value;
    });});
    //animation = new CurvedAnimation(parent: _animController, curve: OvershootCurve());
    _animController.repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  double radialOffsetValue = 0;

  @override
  Widget build(BuildContext context) {
    //if(animation != null) animation.addListener(() {setState(() {});});

    double width = MediaQuery.of(context).size.width;

    final Player? player = widget.player;
    final Image? image = player == null ? null : player.profileImage;

    double screenHeight = MediaQuery.of(context).size.width;
    double dim = AVATAR_DIM;

    var avatar = Avatar(image,
        size: Size(dim,dim),
        loading: image == null,
        defaultImage: null)
        .SizedBoxExt(height: dim, width: dim);
    //.PaddingExt(EdgeInsets.all(spacing));

    String playerName = player == null || player.name == null ? '' : player.name!;
    var name = Container(
      decoration: BoxDecoration(color: AppColors.MainColor),
      child: Center(
        child: AutoSizeText(playerName,
            maxLines: 1,
            minFontSize: 10,
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: FontFamily.lapsusProBold))
            .PaddingExt(EdgeInsets.symmetric(horizontal: 8)),
      ),
    );

    String scoreString = widget.score.toString();
    var score = Container(
      decoration: BoxDecoration(color: AppColors.ScoreColor),
      child: Center(
        child: AutoSizeText(scoreString,
            maxLines: 1,
            minFontSize: 10,
            style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: FontFamily.lapsusProBold))
        ,
      ),
    );

    const double MINIMUM_NAME_TAG_WIDTH = 60;
    const double MAXIMUM_NAME_TAG_WIDTH = 150;
    double nameTagWidth = ui.lerpDouble(MINIMUM_NAME_TAG_WIDTH, MAXIMUM_NAME_TAG_WIDTH, Utils.howLongIsThisName(playerName))!;

    // TODO Style waiting room page ////////////////////////////////////////////////////////
    double radiusOffset = 30;
    double totalDim = AVATAR_DIM + radiusOffset*2;

    double nameLengthFactor = Utils.howLongIsThisName(playerName);
    double squishFactor = 3;

    var circularText = CircularText(
      radius: (AVATAR_DIM / 2) + radiusOffset,
      children: [

        TextItem(
            startAngle: 270 + radialOffsetValue - Utils.howLongIsThisName(playerName) * 50,
            space: 12 - nameLengthFactor * squishFactor,
            text: Text(playerName, style: AppStyles.defaultStyle(fontSize: 24),)),

        TextItem(
            startAngle: 90 + radialOffsetValue - Utils.howLongIsThisName(playerName) * 50,
            space: 12 - nameLengthFactor * squishFactor,
            text: Text(playerName, style: AppStyles.defaultStyle(fontSize: 24),))
      ],);

    var finalWidget = Stack(
      children: [
        Center(child: avatar.PaddingExt(EdgeInsets.all(radiusOffset))),
        Center(child: circularText,)
      ],
    ).SizedBoxExt(height: totalDim, width: totalDim);

    // finalWidget = Row(children: [ finalWidget ])
    //     .ScaleExt(widget.animation?.value??1);

    finalWidget = finalWidget.ScaleExt(widget.animation?.value??1);

    double dx, dy;
    double a = (width - 2*totalDim) / 3;

    if(widget.index % 2 == 0) dx = -((a/2) + totalDim/2);
    else dx = (a/2) + totalDim/2;

    dy = widget.index * totalDim/2;
    dy = -dy;

    // TODO Make animated list viewport work <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return finalWidget.TranslateExt(dx: dx, dy: dy);
  }
}
