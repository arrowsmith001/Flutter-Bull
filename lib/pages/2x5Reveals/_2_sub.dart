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
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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


class RevealsSub extends StatefulWidget {
  RevealsSub({this.playerId});

  String? playerId;

  @override
  _RevealsSubState createState() => _RevealsSubState();
}

class _RevealsSubState extends State<RevealsSub> {

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  final String thisPageName = RoomPages.REVEALS;
  final String thisSubPageName = RevealsPages.SUB;

  @override
  void initState() {
    super.initState();
  }

  static const int staggeredListAnimationLengthMilliseconds = 500;

  Widget _buildVoteGrid(List<Player> list, bool votedTrue, List<int> voteTimes) {
    int columnCount = 2;
    return AnimationLimiter(
        child: GridView.count(
            children:
              List.generate(
                  list.length,
                      (i) => AnimationConfiguration.staggeredGrid(
                          position: i,
                          columnCount: columnCount,
                          child: _buildAnimatedListChild(list[i], votedTrue, voteTimes[i])))
            , crossAxisCount: columnCount,)
    );
  } // Overflows
  Widget _buildVoteList(List<Player> list, bool votedTrue, List<int> voteTimes) {
    return AnimationLimiter(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i){

              return AnimationConfiguration.staggeredList(
                  position: i,
                  duration: const Duration(milliseconds: staggeredListAnimationLengthMilliseconds),
                  child: _buildAnimatedListChild(list[i], votedTrue, voteTimes[i])
              );

            })
    );
  }

  _buildAnimatedListChild(Player player, bool votedTrue, int voteTime) {
    return SlideAnimation(
      horizontalOffset: (votedTrue ? 1 : -1) * -200,
      child: FadeInAnimation(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Avatar(player.profileImage,
                shape: BoxShape.rectangle, size: Size(75, 75),
                borderWidth: 0,
                borderRadius: 8),

            Column(
              children: [
                AutoSizeText(player.name!, minFontSize: 8), // TODO Ensure can handle long text
                AutoSizeText(voteTime.toString() + ' secs')
              ],
            ).ExpandedExt(),


          ],
        ).PaddingExt(EdgeInsets.all(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          double dim = 125;

          Player player;
          if(widget.playerId != null) player = state.model.dataModel.getPlayer(widget.playerId)!;
          else player = state.model.getPlayerFromOrder(state.model.room!.turn!)!;

          int turn = state.model.whichTurnWasThisPlayer(player.id!)!;

          List<Player> votedTrue = state.model.getPlayersWhoVoted(true, turn);
          List<Player> votedBull = state.model.getPlayersWhoVoted(false, turn);
          List<int> votedTrueTimes = state.model.getVoteTimes(votedTrue, turn);
          List<int> votedBullTimes = state.model.getVoteTimes(votedBull, turn);


          Widget avatar = Avatar(player.profileImage, size: Size(dim, dim));
          String text = state.model.getPlayerText(player.id)!;
          bool truth = state.model.getPlayerTruth(player.id)!;

          Widget bubble = MyBubble(text, size: Size(dim, dim));

          Widget item = Row(
            children: [

              avatar.HeroExt(player.id! + 'image'),

              Row(
                children: [

                  bubble.HeroExt(player.id! + 'bubble').ExpandedExt(),

                ],
              )
                  .PaddingExt(EdgeInsets.all(4))
                  .FlexibleExt()

            ],
          ).PaddingExt(EdgeInsets.all(8));

          Widget trueList = _buildVoteList(votedTrue, true, votedTrueTimes);
          Widget bullList = _buildVoteList(votedBull, false, votedBullTimes);

          // Widget trueList = _buildVoteGrid(votedTrue, true);
          // Widget bullList = _buildVoteGrid(votedBull, false);


          return SafeArea(
              child: Scaffold(
                  backgroundColor: AppColors.revealsScaffoldBackgroundColor,
                  appBar: CupertinoNavigationBar(
                    leading: Text(thisPageName, style: AppStyles.DebugStyle(32),),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      item,

                      Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              [
                                Text(votedTrue.length.toString(), style: AppStyles.TruthStyle(fontSize: 42),),
                                Text('VOTED TRUE', style: AppStyles.TruthStyle(),),
                                  trueList.ExpandedExt(),
                              ]
                                  .ColumnExt(expand: true),


                              [
                                Text(votedBull.length.toString(), style: AppStyles.BullStyle(fontSize: 42),),
                                  Text('VOTED BULL', style: AppStyles.BullStyle(),),
                                  bullList.ExpandedExt(),
                              ].ColumnExt(expand: true)

                            ],
                          )
                              .ExpandedExt()

                        ],
                      ).PaddingExt(EdgeInsets.all(12)).ExpandedExt(),

                      CupertinoButton(child: Text('Return'), onPressed: () => Navigator.of(context).pop(),)
                    ],
                  ).PaddingExt(EdgeInsets.all(20))

              ));
        },
        listener: (context, state) {

        });
  }






}