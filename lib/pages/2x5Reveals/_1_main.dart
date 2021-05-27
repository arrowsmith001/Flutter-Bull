import 'package:bubble/bubble.dart';
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


class RevealsMain extends StatefulWidget {

  @override
  _RevealsMainState createState() => _RevealsMainState();
}

class _RevealsMainState extends State<RevealsMain> with TickerProviderStateMixin {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.REVEALS;
  final String thisSubPageName = RevealsPages.MAIN;

  late AnimationController _entranceController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _entranceController = AnimationController(vsync: this);
    _entranceController.duration = Duration(seconds: 2);
    _entranceController.addListener(() {setState(() {

    });});
    _entranceController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          if(!state.model.isThereEnoughInfoForResults) return MyLoadingIndicator();

          int turn = state.model.room!.turn!;
          int revealed = state.model.room!.revealed!;

          int count = state.model.roomPlayerCount;// (state.model.roomPlayerCount * 3) + 2;

          //Widget page = SizedBox(height: MediaQuery.of(context).size.height);

          Widget focus = EmptyWidget();

          try{
            Player playerWhoseTurn = state.model.getPlayerWhoseTurn()!;
            String text = state.model.getPlayerText(playerWhoseTurn.id)!;
            bool truth = state.model.getPlayerTruth(playerWhoseTurn.id)!;

            double bigDim = 250;

            Widget avatar = Avatar(playerWhoseTurn.profileImage, size: Size(bigDim, bigDim), borderWidth: 3);
            Widget bubble = MyBubble(text, size: Size(bigDim, bigDim)).PaddingExt(EdgeInsets.all(24));

            bool hasBeenRevealed = turn < revealed;
            if(!hasBeenRevealed)
              {
                avatar = avatar.HeroExt(playerWhoseTurn.id! + 'image');
                bubble = bubble.HeroExt(playerWhoseTurn.id! + 'bubble');
              }

            focus = GestureDetector(
              onTap: () => Navigator.pushNamed(context, RevealsPages.SUB, arguments: playerWhoseTurn.id!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  avatar.FlexibleExt(),
                  bubble.FlexibleExt()
                ],
              ),
            );

          }catch(e){

          }

          Widget list = ListView.builder(
              //controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (context, i)
              {
                //if(i == 0 || i == count - 1) return page;

                const double dim = 100;

                Player player = state.model.getPlayerFromOrder(i)!;
                String text = state.model.getPlayerText(player.id)!;
                bool truth = state.model.getPlayerTruth(player.id)!;

                bool isTurn = i == turn;
                bool hasBeenTurn =  i < turn;
                bool hasBeenRevealed = i < revealed;

                if(!hasBeenRevealed) return EmptyWidget();

                //avatar = avatar.ScaleExt(_entranceController.value);

                Widget avatar = Avatar(player.profileImage, size: Size(dim, dim), borderWidth: 3,);
                Widget bubble = MyBubble(text, size: Size(dim, dim));

                if(hasBeenRevealed)
                {
                  avatar = avatar.HeroExt(player.id! + 'image');
                  bubble = bubble.HeroExt(player.id! + 'bubble');
                }
                //if(!hasBeenRevealed && !isTurn) bubble = bubble.InvisibleIgnoreExt();

                Widget truthTag = Transform.rotate(angle: -0.3,
                    child: Text(
                        truth ? 'TRUE' : 'BULL',
                        style: truth ? AppStyles.TruthStyle(fontSize: 32) : AppStyles.BullStyle(fontSize: 32)));

                Widget item = GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RevealsPages.SUB, arguments: player.id!),
                  child: Row(
                    children: [

                      Stack(
                        children: [

                          avatar,

                          !hasBeenRevealed ? EmptyWidget() : truthTag,

                        ],
                      ),

                      Row(
                        children: [

                          bubble.ExpandedExt()

                        ],
                      )
                          .PaddingExt(EdgeInsets.all(4))
                          .FlexibleExt()


                    ],
                  ).PaddingExt(EdgeInsets.all(8)),
                );

                //item = item.ScaleExt(_entranceController.value);
                if(turn < count) item = item.OpacityExt(0.5);

                return item;


              });

          return SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.revealsScaffoldBackgroundColor,
                  appBar: CupertinoNavigationBar(
                    leading: Text(thisPageName, style: AppStyles.DebugStyle(32),),
                  ),
                  body: Stack(
                    alignment: Alignment.center,
                    children: [

                      Column(
                        children: [

                          list.ExpandedExt()
                        ],
                      ).PaddingExt(EdgeInsets.all(20)),

                      focus
                    ],
                  )

              )
          );
        },
        listener: (context, state) {

        });
  }



}