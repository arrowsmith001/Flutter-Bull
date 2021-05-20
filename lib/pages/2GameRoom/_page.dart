import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/utilities/firebase.dart';
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
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state){

      },
      builder: (context, state) {

        GameRoomModel? model = state.model;
        Room? room = model == null ? null : model.room;

        if(room == null || model == null) return Center(child:  CircularProgressIndicator(),);

        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.MainColor,
            body: Center(
              child: Column(
                mainAxisSize:  MainAxisSize.max,
                children: [

                  Container(
                      child: room == null || room.code == null ? EmptyWidget()
                          : Text('Lets play: ' + room.code!, style: TextStyle(fontSize: 50))
                  ),

                  Column(
                    children: [
                      Center(
                        child: SingleChildScrollView(
                          child: Wrap(
                            children:
                            List.generate(model.playerCount, (i) {
                              Player? player = model.getPlayer(i);
                              Image? image = player == null ? null : player.profileImage;

                              double dim = MediaQuery.of(context).size.width/2;
                              double spacing = 10;
                              dim = dim - 2*spacing;

                              return Avatar(image).SizedBoxExt(height: dim, width: dim).PaddingExt(EdgeInsets.all(spacing));

                              return ListTile(
                                  leading: player == null ? null
                                      : Container(width: dim, height: dim,
                                    decoration: BoxDecoration(
                                        image: image == null ? null : DecorationImage(image: image.image)),),
                                  title: Text(player == null ? '' : player.name??'<unknown>')
                              );
                            })
                            ,
                          ),
                        ),
                      ).ExpandedExt(),
                    ],
                  ).ExpandedExt(),

                  Container(

                      child: room == null || room.code == null ? EmptyWidget()
                          : Text('Lets play: ' + room.code!, style: TextStyle(fontSize: 50))
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
