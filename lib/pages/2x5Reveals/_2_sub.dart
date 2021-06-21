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
import 'package:extensions/extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';


class RevealsSub extends StatefulWidget {
  RevealsSub({this.playerId});
  //final GlobalKey<NavigatorState> nav;

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

  void _advanceRevealNumber(){
    _bloc.add(AdvanceRevealNumberEvent());
  }

  void _reveal(bool truth){

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
            ).xExpanded(),


          ],
        ).xPadding(EdgeInsets.all(8)),
      ),
    );
  }

  void _goToMainPage(int newTurn) {
    print('GOING TO MAIN PAGE: newTurn: ' + newTurn.toString());
    Navigator.of(context).pushNamedAndRemoveUntil(RevealsPages.MAIN, (route) => false,
        arguments: newTurn);
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

          List<Player> votedTrue = state.model.getPlayersWhoVoted(turn, votedTrue: true);
          List<Player> votedBull = state.model.getPlayersWhoVoted(turn, votedTrue: false);
          List<int> votedTrueTimes = state.model.getVoteTimes(votedTrue, turn);
          List<int> votedBullTimes = state.model.getVoteTimes(votedBull, turn);


          Widget avatar = Avatar(player.profileImage, size: Size(dim, dim));
          String text = state.model.getPlayerText(player.id)!;
          bool truth = state.model.getPlayerTruth(player.id)!;
          bool isMyTurn = state.model.isItMyTurn!;
          bool hasBeenRevealed = turn < state.model.room!.revealed!;

          Widget bubble = MyBubble(text, size: Size(dim, dim));

          Widget mainAvatar = Row(
            children: [

              avatar.xHero(player.id! + 'image'),

              Row(
                children: [

                  bubble.xHero(player.id! + 'bubble').xExpanded(),

                ],
              )
                  .xPadding(EdgeInsets.all(4))
                  .xFlexible()

            ],
          ).xPadding(EdgeInsets.all(8));

          Widget trueList = _buildVoteList(votedTrue, true, votedTrueTimes);
          Widget bullList = _buildVoteList(votedBull, false, votedBullTimes);

          // Widget trueList = _buildVoteGrid(votedTrue, true);
          // Widget bullList = _buildVoteGrid(votedBull, false);


          return Scaffold(
              backgroundColor: AppColors.revealsScaffoldBackgroundColor,
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    mainAvatar,


                    Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            [
                              Text(votedTrue.length.toString(), style: AppStyles.TruthStyle(fontSize: 42),),
                              Text('VOTED TRUE', style: AppStyles.TruthStyle(),),
                                trueList.xExpanded(),
                            ]
                                .xColumn().xExpanded(),


                            [
                              Text(votedBull.length.toString(), style: AppStyles.BullStyle(fontSize: 42),),
                                Text('VOTED BULL', style: AppStyles.BullStyle(),),
                                bullList.xExpanded(),
                            ].xColumn().xExpanded()

                          ],
                        )
                            .xExpanded()

                      ],
                    ).xPadding(EdgeInsets.all(12))
                        .xExpanded(),

                    !hasBeenRevealed ? EmptyWidget()
                        : GestureDetector(
                      onTap: () {

                      },
                          child: Text(truth ? 'TRUE' : 'BULL',
                          style: truth ? AppStyles.TruthStyle(fontSize: 64) : AppStyles.BullStyle(fontSize: 64)),
                        ),

                    !isMyTurn ? EmptyWidget()
                        : CupertinoButton(child: Text('Reveal'), onPressed: () => _advanceRevealNumber(),)


                  ],
                ).xPadding(EdgeInsets.all(20)),
              )

          );
        },
        listener: (context, state) {

          if(state is RevealState)
            {
              int newRevealNumber = state.newRevealedNumber;
              if(newRevealNumber == state.model.room!.turn)
                {
                  _reveal(state.model.getPlayerTruth(state.model.getPlayerWhoseTurn()!.id)!);
                }
            }

          if(state is GoToResultsState)
          {
            Navigator.of(context).pushNamed(RevealsPages.FINAL);
          }

          if(state is NewTurnState)
          {
                //bool iShouldAdvanceTurn = true; // TODO Change to vary upon whose turn it is

                _goToMainPage(state.newTurn);

          }
        });
  }






}