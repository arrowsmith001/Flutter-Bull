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
import 'package:extensions/extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';


class WriteMain extends StatefulWidget {

  @override
  _WriteMainState createState() => _WriteMainState();
}

class _WriteMainState extends State<WriteMain> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.WRITE;
  TextEditingController _textController = TextEditingController();

  void onSubmittedStatement(String text, String targetId)
  {
    _bloc.add(TextEntrySubmittedEvent(text, targetId));
  }

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
          setState(() {
            submitButtonEnabled = _textController.value.text.trim() != '';
          });
    });
  }

  bool submitButtonEnabled = false;

  bool hidden = false;
  void _toggleHide() {
    setState(() {
      hidden = !hidden;
    });
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          Player? target = state.model.dataModel.getMyTarget();
          bool? isTargetMyself = target == null ? null : state.model.dataModel.isUser(target.id!);
          bool? writeTruth = target == null ? null : state.model.dataModel.getTruth(target);

          bool sufficientInfo = target != null && isTargetMyself != null && writeTruth != null;

          Player me = state.model.me!;

          double fontSize = 46;
          TextStyle style = AppStyles.defaultStyle(fontSize: fontSize, color: Colors.black);
          TextStyle smallStyle = AppStyles.defaultStyle(fontSize: fontSize - 5, color: Colors.black);
          TextStyle boldStyle = AppStyles.defaultStyle(fontSize: 48, color: Colors.black, fontWeight: FontWeight.w900);
          TextStyle truthStyle =  AppStyles.TruthStyle(fontSize: fontSize);
          TextStyle bullStyle =  AppStyles.BullStyle(fontSize: fontSize);

          Widget hideButton = GestureDetector(
            onTap: () {
              _toggleHide();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              height: 75,
              width: 75,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: Assets.images.hide),
                    )
                ),
              ),
            ),);

          return Scaffold(
              backgroundColor: Color.fromARGB(255, 252, 225, 255),
              body: !sufficientInfo ? MyLoadingIndicator()
                  : Stack(
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // TODO Use better hide image
                      AnimatedSwitcher(
                        transitionBuilder: (child, anim) {
                          return child;
                          return child.xScale((1-anim.value));
                        },
                        child:  Container(
                          key: Key(hidden ? '1' : '2'),
                            child: Avatar(hidden ? Assets.images.whiteSquare.image() : target.profileImage, size: Size(500, 500))),
                        duration: Duration(milliseconds: 200),
                        reverseDuration: Duration(milliseconds: 200),
                        switchInCurve: Curves.bounceInOut,
                        switchOutCurve: Curves.easeOutCirc,
                      ).xFlexible(),

                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              children: [
                                TextSpan(text: '${me.name!},', style: style),
                                TextSpan(text: '\n write a ', style: style),
                                hidden ? TextSpan(text: '****', style: style) : TextSpan(text: (writeTruth ? 'TRUTH' : 'LIE'), style: (writeTruth ? truthStyle : bullStyle)),
                                TextSpan(text: ' about ', style: style),
                                hidden ? TextSpan(text: '****', style: style) : TextSpan(text: (isTargetMyself ? 'yourself' : target.name!), style: style),
                              ]
                          )).xFlexible(),

                      CupertinoTextField(
                        style: AppStyles.defaultStyle(fontSize: 32, fontWeight: FontWeight.w200, color: Colors.black),
                        maxLines: 3,
                        minLines: 3,
                        placeholder: 'Enter text here',
                        padding: EdgeInsets.all(16),
                        controller: _textController, onSubmitted: (text) => onSubmittedStatement(text, target.id!),)
                          .xFlexible(),

                      CupertinoButton(
                          color: Color.fromARGB(255, 0, 0, 255),
                          child: Text('SUBMIT', style: AppStyles.defaultStyle(fontSize: 32),),
                          onPressed: !submitButtonEnabled ? null : () => onSubmittedStatement(_textController.text, target.id!))

                    ],
                  ),

                  Positioned(
                      right: 0, top: 0,
                      child: SafeArea(
                        child: hideButton,
                      ))


                ],
              ).xPadding(EdgeInsets.all(20))

          );
        },
        listener: (context, state) {
          //GameRoomRoutes.pageListener(context, state, thisPageName);

          if(state is TextEntrySuccessfullySubmittedState)
          {
            // setState(() {
            //   readiedUp = true;
            // });
            Navigator.of(context).pushNamed(WritePages.AFTER);
          }
        });
  }



}