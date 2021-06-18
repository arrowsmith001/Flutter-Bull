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

// TODO Priority: Make game minimally viable ///////////////////////////////////////////////////////////
class WriteIntro extends StatefulWidget {

  @override
  _WriteIntroState createState() => _WriteIntroState();
}

class _WriteIntroState extends State<WriteIntro> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.WRITE;
  final String thisSubPageName = WritePages.INTRO;

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

          double dim = (MediaQuery.of(context).size.width / 3) - 20;

          return SafeArea(
              child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 252, 225, 255),
                  body: !sufficientInfo ? MyLoadingIndicator()
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Avatar(me.profileImage, size: Size(dim,dim), loading: me.profileImage == null, defaultImage: null).xSizedBox(height: dim, width: dim)
                        ],
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                          text: TextSpan(
                        children: [
                          TextSpan(text: 'Everyone will now write 1 statement each', style: style),
                          TextSpan(text: '\n\nThis statement will either be a ', style: style), TextSpan(text: 'truth about themselves,', style: truthStyle),
                          TextSpan(text: ' or a ', style: style), TextSpan(text: 'lie about another player', style: bullStyle),
                          TextSpan(text: '\n\nYou must keep your role a secret from all other players', style: boldStyle),
                        ]
                      )),
                      CupertinoButton(
                        color: Colors.indigoAccent,
                          child: AppStyles.MyText('Reveal your role and start writing',color: Colors.white,), onPressed: () => Navigator.of(context).pushNamed(WritePages.MAIN))
                    ],
                  ).xPadding(EdgeInsets.all(20))

              ));
        },
        listener: (context, state) {
          //WriteRoutes.pageListener(context, state, thisPageName);
        });
  }



}