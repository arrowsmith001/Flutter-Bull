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
import 'package:flutter_bull/pages/2x5Reveals/routes.dart';
import 'package:flutter_bull/pages/widgets.dart';
import 'package:flutter_bull/firebase/provider.dart';
import 'package:flutter_bull/widgets/misc.dart';
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
import 'package:design/design.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets/misc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import '../../classes/classes.dart';
import 'package:extensions/extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';


class RevealsFinal extends StatefulWidget {
  //RevealsFinal(this.nav);
  //final GlobalKey<NavigatorState> nav;

  @override
  _RevealsFinalState createState() => _RevealsFinalState();
}

class _RevealsFinalState extends State<RevealsFinal> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.REVEALS;
  final String thisSubPageName = RevealsPages.FINAL;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          return Scaffold(
              backgroundColor: AppColors.revealsScaffoldBackgroundColor,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(thisSubPageName, style: AppStyles.DebugStyle(42))
                  ],
                ).xPadding(EdgeInsets.all(20)),
              )

          );
        },
        listener: (context, state) {

        });
  }



}