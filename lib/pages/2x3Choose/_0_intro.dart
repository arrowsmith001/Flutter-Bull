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
import 'package:flutter_bull/pages/2x3Choose/routes.dart';
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

class ChooseIntro extends StatefulWidget {

  @override
  _ChooseIntroState createState() => _ChooseIntroState();
}

class _ChooseIntroState extends State<ChooseIntro> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = ChoosePages.INTRO;

  @override
  void initState() {
    super.initState();
    _beginFakeChoose(_bloc.model); // TODO Handle errors
  }

  Future<void> _beginFakeChoose(GameRoomModel model) async {
    await Future.delayed(Duration(seconds: 2));
    //Navigator.of(context).pushNamedAndRemoveUntil(ChoosePages.MAIN, (route) => false);
  }

  void goToPlay() {
    _bloc.add(StartRoundEvent());
  }

  @override
  Widget build(BuildContext context) {

    // TODO Make choose/play minimally viable <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          if(state.model.room == null) return MyLoadingIndicator();

          bool sufficientInfo = true; // TODO Be stricter here

          List<Player?> playersInOrder = List.from(state.model.room!.playerOrder!.map((id) => state.model.getPlayer(id)));
          //for(int i = 0; i < 2; i++) playersInOrder += playersInOrder;
          //playersInOrder.removeWhere((element) => playersInOrder.indexOf(element) % 2 == 0);
          int n = playersInOrder.length;
          const double twoPi = math.pi*2;
          const double H_PADDING = 20;

          Size size = MediaQuery.of(context).size;
          double width = size.width - H_PADDING * 2;
          double halfWidth = width/2;

          double dim = ((twoPi * halfWidth) / (n + math.pi));
          double halfDim = dim/2;

          // TODO Congregate in position animation, grey out non-participants, finger to point <<<<<<<<<<<<<<<<<<<<<<<<<<<

          return SafeArea(
              child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 231, 255, 225),
                  body: !sufficientInfo ? MyLoadingIndicator()
                      : Column(
                    children: [

                      AppStyles.MyText('Choosing next player:', color: Colors.black),

                      // ListView.builder(
                      //     itemCount: playersInOrder.length,
                      //     itemBuilder: (context, i)
                      //     {
                      //       Player? player = playersInOrder[i];
                      //       return Avatar(player == null ? null : player.profileImage, size: Size(dim, dim),);
                      //     })

                  Stack(
                    children: [

                      // for(int i = 0; i < playersInOrder.length; i++)
                      //   Positioned(child: Avatar(playersInOrder[i]!.profileImage, size: Size(dim, dim)),
                      //     top: _m*i*dim * (_m*i).toDouble()/n,
                      //     left: _m*i* dim * math.sin(((_m*i).toDouble()/n)*math.pi),
                      //   )

                      for(int i = 0; i < playersInOrder.length; i++)
                        Positioned(child: Avatar(playersInOrder[i]!.profileImage, size: Size(dim, dim)),
                          top: halfWidth + (halfWidth - halfDim) * math.sin(((i).toDouble()/n)*twoPi),
                          left: H_PADDING + halfWidth-(dim/2) + (halfWidth - halfDim) * math.cos(((i).toDouble()/n)*twoPi),
                        )

                              ],
                  )

                          .FlexibleExt(),

                      Slider(
                        label: _m.toString(),
                        min: 0.0,
                        max: 5.0,
                        value: _m,
                        onChanged: (double value) { setState(() {
                          _m = value;
                        }); },

                      )

                    ],
                  )

              ));
        },
        listener: (context, state) =>
            GameRoomRoutes.pageListener(context, state, thisPageName));
  }

  double _m = 0;


}