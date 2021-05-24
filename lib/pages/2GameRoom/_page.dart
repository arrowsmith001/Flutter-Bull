import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
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
import '_bloc.dart';

import '_bloc.dart';
import '_bloc_events.dart';
import '_bloc_states.dart';

class GameRoom extends StatefulWidget {

  @override
  _GameRoomState createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _bloc.add(SetupEvent());

  }
  ScrollController _scrollController = new ScrollController();
  GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state){

        if(state is NewRoomState)
        {
          print('NEW ROOM');
          setState(() {
            _listKey = new GlobalKey();
          });
        }

        if(state is RoomPlayerRemovedState)
          if(_listKey.currentState != null)  _listKey.currentState!.removeItem(state.index, (context, animation) =>
               _buildAvatar(state.model, state.index, animation));

        if(state is RoomPlayerAddedState)
          if(_listKey.currentState != null) _listKey.currentState!.insertItem(state.index);

      },
      builder: (context, state) {

        GameRoomModel? model = state.model;
        Room? room = model == null ? null : model.room;

        if(room == null || model == null) return Center(child:  CircularProgressIndicator(),);
        print(model.room!.toJson().toString());

        Widget WaitingRoom = SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 4, 26, 88),
            body: Center(
              child: Column(
                mainAxisSize:  MainAxisSize.max,
                children: [

                  //
                  // Column(
                  //   children: [
                  //     Center(
                  //       child: ListView.builder(
                  //         itemCount: model.playerCount,
                  //         itemBuilder: (BuildContext context, int i) {
                  //
                  //           return _buildAvatar(model, i, null);
                  //
                  //           ;
                  //         },
                  //
                  //       ),
                  //     ).ExpandedExt(),
                  //   ],
                  // ).ExpandedExt(),


                  Column(
                    children: [
                      AnimatedList(
                        key: _listKey,
                        initialItemCount: model.roomPlayerCount,
                        itemBuilder: (BuildContext context, int i, Animation<double> animation)
                        {
                          //if(model.getRoomMember(i) == null) return Text(i.toString());
                          return _buildAvatar(model, i, animation);
                        },

                      ).ExpandedExt(),
                    ],
                  ).PaddingExt(EdgeInsets.all(20)).ExpandedExt(),

                  Container(
                      child: room == null || room.code == null ? EmptyWidget()
                          : Text('Lets play: ' + room.code!, style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: FontFamily.lapsusProBold))
                  ),


                ],
              ),
            ),
          ),
        );

        return WaitingRoom;
      },
    );
  }

  Widget _buildAvatar(GameRoomModel model, int i, Animation? animation) {
    if(animation != null) animation.addListener(() {setState(() {

    });});

    Player? player = model.getRoomMember(i);
    Image? image = player == null ? null : player.profileImage;

    double dim = MediaQuery.of(context).size.width/3;
    double spacing = 10;
    dim = dim - 2*spacing;
    dim = min(dim, MediaQuery.of(context).size.height/model.roomPlayerCount);

    var avatar = Avatar(image,
        loading: image == null,
        defaultImage: null)
        .SizedBoxExt(height: dim, width: dim)
        .PaddingExt(EdgeInsets.all(spacing)).ScaleExt(animation == null ? 1 : animation.value);

    var name = AutoSizeText(player == null || player.name == null ? '' : player.name!,
      maxLines: 1,
      style: TextStyle(fontSize: 64, color: Colors.white, fontFamily: FontFamily.lapsusProBold),);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        avatar,

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            name,
            Text('0', style: TextStyle(color: Colors.amberAccent, fontSize: 20), textAlign: TextAlign.start,)
          ],
        ).FlexibleExt()
      ],
    );
  }
}
