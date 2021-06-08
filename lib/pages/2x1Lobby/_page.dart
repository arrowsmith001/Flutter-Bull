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

  final String thisPageName = RoomPages.LOBBY;
  late AnimationController _animController;


  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

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
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state) async{

        GameRoomRoutes.pageListener(context, state, thisPageName);

        if(state is NewRoomState)
        {
          print('NEW ROOM');
          // TODO: Get this to work
          setState(() {
            _listKey = new GlobalKey();
          });
        }

        if(state is RoomPlayerRemovedState) {
          if (_listKey.currentState != null) {

            _listKey.currentState!.removeItem(state.index,
                    (context, animation) => _buildAvatar(state.model.dataModel, state.index, animation, height),
                duration: Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS));

            playerIdsLocal.remove(state.userId);
          }
        }

        if(state is RoomPlayerAddedState) {
          if (_listKey.currentState != null) {

            playerIdsLocal.add(state.userId);
            _listKey.currentState!.insertItem(state.index, duration: Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS));

            await Future.delayed(Duration(milliseconds: PLAYER_LIST_ANIMATION_DURATION_MILLISECONDS)); // TODO Ma
            double val = _scrollController.position.maxScrollExtent;// + AVATAR_DIM + 2 * AVATAR_PADDING;
            if(_scrollController.position.userScrollDirection == ScrollDirection.idle) _scrollController.animateTo(val, duration: Duration(milliseconds: 250), curve: Interval(0, 1));
          }
        }
      },
      builder: (context, state) {

        GameRoomModel? model = state.model;
        Room? room = model == null ? null : model.room;

        if(room == null || model == null) return Center(child:  MyLoadingIndicator(),);

        Widget TopBit =
        Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: [Color.fromARGB(255, 174, 187, 243), Colors.indigo], focal: Alignment.topLeft, radius: 2, stops: [0, 0.4])),

            child: room == null || room.code == null ? EmptyWidget()
                : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                model.getHostIndex() != null ? _buildAvatar(model.dataModel, model.getHostIndex()!, null, 0).FlexibleExt() : EmptyWidget(),

                Text(model.roomPlayerCount.toString(), style: AppStyles.MainMenuButtonTextStyle(32, Colors.white)),

                Align(
                  alignment: Alignment.bottomRight,
                  child: AutoSizeText(room.code!,
                      minFontSize: 24,
                      style: TextStyle(
                          fontSize: 72,
                          color: Colors.white,
                          fontFamily: FontFamily.lapsusProBold)),
                ).FlexibleExt(),

              ],
            )
                .PaddingExt(EdgeInsets.symmetric(horizontal: 15, vertical: 5))

        );
        TopBit = EmptyWidget();

        Widget list = AnimatedList(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          reverse: false,
          shrinkWrap: true,
          key: _listKey,
          initialItemCount: playerIdsLocal.length,
          itemBuilder: (BuildContext context, int i, Animation<double> animation)
          {
            if(model.dataModel.getPlayer(playerIdsLocal[i]) == null) return Avatar(null);
            return _buildAvatar(model.dataModel, i, animation, height);
          },

        );

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
                  child: Column(
                    mainAxisSize:  MainAxisSize.max,
                    children: [

                      //TopBit.FlexibleExt(1),

                      list.ExpandedExt(),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );

        return WaitingRoom;
      },
    );
  }

  OvershootInterpolator interp = new OvershootInterpolator(2);

  Widget _buildAvatar(DataModel model, int i, Animation? animation, double height) {
    if(animation != null) animation.addListener(() {setState(() {});});

    final Player? player = i >= playerIdsLocal.length ? null : model.getPlayer(playerIdsLocal[i]);
    final Image? image = player == null ? null : player.profileImage;

    double dim = MediaQuery.of(context).size.width/3;
    double spacing = 5;
    dim = dim - 2*spacing;
    //dim = min(dim, (height*(2/3) - spacing*2*(model.roomPlayerCount+1) - spacing)/model.roomPlayerCount);
    dim = AVATAR_DIM;

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

    int? scoreVal = player == null ? null : model.getPlayerScore(player.id!);
    String scoreString = scoreVal == null ? '' : scoreVal.toString();
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

    return Align(
      alignment: Alignment.centerRight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          Positioned(
            left: 0,
            top: 25,
            child: Container(height: 40, width: 50, color: AppColors.MainColor,),
          ),

          Positioned(
            right: 135,
            top: 25,
            child: name
            //.RotateExt(0.3)
                .SizedBoxExt(width: nameTagWidth, height: 40),
          ),


          Positioned(
            left: -45,
              top: 65,
              child: score
                  .SizedBoxExt(width: 60, height: 40),),

          avatar.PaddingExt(EdgeInsets.symmetric(horizontal: AVATAR_PADDING)),

        ],
      )
          .PaddingExt(EdgeInsets.symmetric(vertical: AVATAR_PADDING))
          .ScaleExt(animation == null ? 1 : interp.getValue(animation.value)),
    );
  }


}
