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


class Lobby extends StatefulWidget {

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> with SingleTickerProviderStateMixin {

  final String thisPageName = RoomPages.LOBBY;
  late AnimationController _animController;

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);
  int initialRoomCount = 0;

  @override
  void initState() {
    super.initState();
    initialRoomCount = _bloc.model.roomPlayerCount;

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
      listener: (context, state){

        GameRoomRoutes.pageListener(context, state, thisPageName);

        if(state is NewRoomState)
        {
          print('NEW ROOM');
          // TODO: Get this to work
          setState(() {
            _listKey = new GlobalKey();
          });
        }

        if(state is RoomPlayerRemovedState)
          if(_listKey.currentState != null)  _listKey.currentState!.removeItem(state.index, (context, animation) =>
              _buildAvatar(state.model.dataModel, state.index, animation, height));

        if(state is RoomPlayerAddedState)
          if(_listKey.currentState != null)
            {
              _listKey.currentState!.insertItem(state.index);
              // TODO: Investigate and set correct scroll value for when a new item enters list
              double val = _scrollController.position.viewportDimension;
              _scrollController.animateTo(val, duration: Duration(milliseconds: 250), curve: Interval(0, 1));
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

        Widget list = AnimatedList(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          reverse: true,
          shrinkWrap: true,
          key: _listKey,
          initialItemCount: initialRoomCount,
          itemBuilder: (BuildContext context, int i, Animation<double> animation)
          {
            if(model.getRoomMember(i) == null || model.isHost(model.getRoomMember(i)!.id)) return EmptyWidget();
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

                      TopBit.FlexibleExt(1),

                      list.FlexibleExt(2),

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

    Player? player = model.getRoomMember(i);
    Image? image = player == null ? null : player.profileImage;

    double dim = MediaQuery.of(context).size.width/3;
    double spacing = 5;
    dim = dim - 2*spacing;
    //dim = min(dim, (height*(2/3) - spacing*2*(model.roomPlayerCount+1) - spacing)/model.roomPlayerCount);

    var avatar = Avatar(image,
        size: Size(dim,dim),
        loading: image == null,
        defaultImage: null)
        .SizedBoxExt(height: dim, width: dim);
        //.PaddingExt(EdgeInsets.all(spacing));

    var name = AutoSizeText(player == null || player.name == null ? '' : player.name!,
      maxLines: 1,
      minFontSize: 10,
      style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: FontFamily.lapsusProBold),);

    return SizedBox(
      height: dim,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              name.FlexibleExt(),
              Text('0', style: TextStyle(color: Colors.amberAccent, fontSize: 20), textAlign: TextAlign.end,)
            ],
          ).FlexibleExt(),

          avatar.PaddingExt(EdgeInsets.symmetric(horizontal: spacing)),
        ],
      ),
    )
        .PaddingExt(EdgeInsets.all(spacing))
        .ScaleExt(animation == null ? 1 : interp.getValue(animation.value));
  }


}
