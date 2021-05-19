import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/classes/firebase.dart';
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
import 'package:flutter_bull/pages/1MainMenu/_bloc_events.dart';
import 'package:flutter_bull/pages/1MainMenu/_bloc_states.dart';
import 'package:flutter_bull/pages/1MainMenu/widgets.dart';
import 'package:flutter_bull/pages/1MainMenu/background.dart';
import 'package:flutter_bull/pages/1MainMenu/title.dart';
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
import '_bloc_states.dart';

class GameRoom extends StatefulWidget {

  @override
  _GameRoomState createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
      listener: (context, state){

      },
      builder: (context, state) {

        GameRoomModel model = state.model;
        Room? room = model.room;

        if(room == null) return Center(child:  CircularProgressIndicator(),);

        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [

                Container(
                    child: room == null || room.code == null ? EmptyWidget()
                        : Text('Lets play: ' + room.code!, style: TextStyle(fontSize: 50))
                ).ExpandedExt(),

                ListView.builder(
                  itemCount: model.playerCount,
                    itemBuilder: (context, i){
                    double dim = 50;
                    Player? player = model.getPlayer(i);
                      return ListTile(
                        leading: player == null ? null
                            : Container(width: dim, height: dim,decoration: BoxDecoration(image: DecorationImage(image: (player.profileImage == null ? null : player.profileImage!.image)!)),),
                        title: Text(player == null ? '' : player.name??'<unknown>')
                      );
                    }).ExpandedExt()


              ],
            ),
          ),
        );
      },
    );
  }
}
