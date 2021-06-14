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


class WriteAfter extends StatefulWidget {

  @override
  _WriteAfterState createState() => _WriteAfterState();
}

class _WriteAfterState extends State<WriteAfter> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.WRITE;
  final String thisSubPageName = WritePages.AFTER;
  TextEditingController _textController = TextEditingController();

  void onSubmittedStatement(String text, String targetId)
  {
    _bloc.add(TextEntrySubmittedEvent(text, targetId));
  }

  static const double AVATAR_DIM = 100;
  static const double AVATAR_PADDING_H = 6;
  static const double AVATAR_PADDING_V = 8;
  static const double WRAP_PADDING_H = 20;

  // TODO Create fake animated wrap?
  void _computeDxDy(BuildContext context, int count) {
    double width = MediaQuery.of(context).size.width;
    double maxH = width - AVATAR_DIM - 2*WRAP_PADDING_H;
    double dx = 0;
    double dy = 0;
    double dim = AVATAR_DIM + 2*AVATAR_PADDING_H;

    //int maxFit = (maxH / dim).floor();

    _dx = List.generate(count, (index) => 0, growable: false);
    _dy = List.generate(count, (index) => 0, growable: false);

    for(int i = 0; i < count; i++) {
      _dx[i] = dx;
      _dy[i] = dy;

      dx += dim;
      if (dx > maxH) {
        dx = 0;
        dy += dim;
      }
    }
  }

  late List<double> _dx;
  late List<double> _dy;

  @override
  void initState() {
    super.initState();
  }

  bool readiedUp = false;

  Widget _buildFakeWrap(GameRoomState state, double dim){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.model.roomPlayerCount,
        itemBuilder: (context, i){

          double dx = _dx[i];
          double dy = _dy[i];

          Player p = state.model.getPlayerFromOrder(i)!;
          return Align(alignment: Alignment.topLeft,
            child: Avatar(p.profileImage, size: Size(dim, dim)).TranslateExt(dx: dx, dy: dy),
            heightFactor: double.minPositive, widthFactor: double.minPositive,
          );
        }).PaddingExt(EdgeInsets.all(WRAP_PADDING_H));
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          Player? target = state.model.dataModel.getMyTarget();
          bool? isTargetMyself = target == null ? null : state.model.dataModel.isUser(target.id!);
          bool? writeTruth = target == null ? null : state.model.dataModel.getTruth(target);

          bool sufficientInfo = target != null && isTargetMyself != null && writeTruth != null;

          double dim = AVATAR_DIM;
          double screenWidth = MediaQuery.of(context).size.width;
          double maxH = (screenWidth - dim);

          _computeDxDy(context, state.model.roomPlayerCount);

          return SafeArea(
              child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 252, 225, 255),
                  body: !sufficientInfo ? MyLoadingIndicator()
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //_buildFakeWrap(state, dim).FlexibleExt(),

                      Text('Waiting for players to submit statements...', style: AppStyles.defaultStyle(fontSize: 42, color: Colors.black)),
                    ],
                  )
                      //.PaddingExt(EdgeInsets.all(20))

              ));
        },
        listener: (context, state) {
          //WriteRoutes.pageListener(context, state, thisPageName);
        });
  }




}