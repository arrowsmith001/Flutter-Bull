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
  TextEditingController _textController = TextEditingController();

  void onSubmittedStatement(String text, String targetId)
  {
    _bloc.add(TextEntrySubmittedEvent(text, targetId));
  }

  @override
  void initState() {
    super.initState();
  }

  bool readiedUp = false;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          Player? target = state.model.dataModel.getMyTarget();
          bool? isTargetMyself = target == null ? null : state.model.dataModel.isUser(target.id!);
          bool? writeTruth = target == null ? null : state.model.dataModel.getTruth(target);

          bool sufficientInfo = target != null && isTargetMyself != null && writeTruth != null;

          return SafeArea(
              child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 252, 225, 255),
                  appBar: CupertinoNavigationBar(
                    leading: Text(thisPageName, style: AppStyles.DebugStyle(32),),
                  ),
                  body: !sufficientInfo ? MyLoadingIndicator()
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(thisSubPageName, style: AppStyles.DebugStyle(42)),
                      CupertinoButton(child: Text('Go to Main'), onPressed: () => Navigator.of(context).pushNamed(WritePages.MAIN))
                    ],
                  ).PaddingExt(EdgeInsets.all(20))

              ));
        },
        listener: (context, state) {
          //WriteRoutes.pageListener(context, state, thisPageName);
        });
  }



}