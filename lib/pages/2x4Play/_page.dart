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
import 'package:flutter_bull/pages/2x4Play/widgets.dart';
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
import 'package:reorderables/reorderables.dart';
import '../../classes/classes.dart';
import '../../extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';

class Play extends StatefulWidget {

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> with TickerProviderStateMixin {

  final String thisPageName = RoomPages.PLAY;

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  late AnimationController _animController;
  String? animatedVoterId;

  @override
  void initState() {
    super.initState();

    _animController = new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animController.addListener(() {setState(() {

    });});

    // TODO Do not do this shit in initState

    int totalMinutes = _bloc.model.room!.settings[Room.SETTINGS_ROUND_TIMER];

    unixRoundStart = GameParams.getTrueUnixFromDownloaded(_bloc.model.room!.roundStartUnix!);
    int unixNow = _unix;
    int elapsed = unixNow - unixRoundStart;

    initialItemCount = _bloc.model.getNumberWhoVoted(_bloc.model.room!.turn!)!;

    _createTimer(totalMinutes, elapsed);
  }

  int initialItemCount = 0;
  int unixRoundStart = 0;
  int get _unix => DateTime.now().millisecondsSinceEpoch;

  void _createTimer(int totalMinutes, int msElapsed){
    // TODO: Sync timer with actual unix timestamp
    setState(() {
      this.totalMinutes = totalMinutes;
      t = max(0, getMsFromMins(totalMinutes) - msElapsed);
    });
    _roundTimer = new Timer.periodic(
        new Duration(milliseconds: 10),
            (timer) {
          if(t <= 0) _roundTimer.cancel();
          setState(() {
            t = getMsFromMins(totalMinutes) - (_unix - unixRoundStart);
          });
          //print(_start.toString());
        }
    );
  }

  @override
  void dispose(){
    _roundTimer.cancel();
    _animController.dispose();
    super.dispose();
  }

  int getMsFromMins(int mins) => mins*60*1000;

  int getMinsFromMs(int ms) => max(0, (ms/(60*1000)).floor());
  int getSecsOnMinFromMs(int ms) => max(0, (ms/(1000)).floor() - getMinsFromMs(ms)*60);
  int getMsOnMinFromMs(int ms) => max(0, (ms - getMinsFromMs(ms)*60*1000) % 1000);

  int t = 0;
  int totalMinutes = 0;

  late Timer _roundTimer;

  Widget _buildTimerDisplay(){
    int msFromMins = getMsFromMins(totalMinutes);
    double frac = msFromMins > 0 ? (t / msFromMins) : 1;

    int m = getMinsFromMs(t);
    int s = getSecsOnMinFromMs(t);
    int ms = max(0, (getMsOnMinFromMs(t) / 100)).floor();

    return Text('${m} : ${s} : ${ms} (${(frac*1000).round()/1000})', style: AppStyles.DebugStyle(24),);
  }

  int getSecondsElapsed(int ms) => totalMinutes*60 - max(0, (ms/1000).floor());
  bool voting = false;
  void vote(bool? votedTrue) {
    setState(() {
      voting = true;
    });
    _bloc.add(VoteEvent(votedTrue, getSecondsElapsed(t)));
  }

  void goToNextTurn(){
    _bloc.add(NextTurnRequestedFromPlayEvent());
  }


  //GlobalKey<AnimatedListState> _animListKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<GameRoomBloc, GameRoomState>(
        builder: (context, state) {

          if(state.model.room == null) return MyLoadingIndicator();

          Player? player = state.model.getPlayerWhoseTurn();
          String? text = player == null ? null : state.model.getPlayerText(player.id);
          bool? isMyTurn = state.model.isItMyTurn;
          int turn = state.model.room!.turn!;

          bool sufficientInfo = player != null && text != null && isMyTurn != null;

          Widget playerWhoseTurnPanel = !sufficientInfo ? EmptyWidget() : Row(
            children: [
              Avatar(player.profileImage, size: Size(100, 100))
                  .HeroExt(state.model.room!.turn!),

              MyBubble(text, size: Size(100, 100)).ExpandedExt()
            ],
          );

          List<Player> playersWhoVoted = state.model.getPlayersWhoVoted(turn);

          List<Player> playersWhoCanVote = state.model.getPlayersWhoCanVote(turn);

          Widget votedList = Wrap(
            //onReorder: (int oldIndex, int newIndex) {  },
            children: List.generate(playersWhoCanVote.length, (i) {

                Player p = playersWhoCanVote[i];

                Widget avatar = Avatar(p.profileImage!,
                    borderColor: playersWhoVoted.contains(p) ? Colors.lightGreen : null, size: Size(65, 65))
                  .PaddingExt(EdgeInsets.all(8));

                return AnimatedVoterAvatar(avatar,
                    p.id == this.animatedVoterId ? _animController.value : 1
                );

              })
            ,

          );

          // Widget votedList =
          // //numberWhoVoted == 0 ? EmptyWidget() :
          // AnimatedList(
          //   scrollDirection: Axis.horizontal,
          //   key: _animListKey,
          //     initialItemCount: initialItemCount,
          //     itemBuilder: (context, i, animation) {
          //     animation.addListener(() {setState(() {
          //
          //     });});
          //
          //       //if(playersWhoVoted.length <= i) return EmptyWidget();
          //       return Avatar(playersWhoVoted[i].profileImage!, size: Size(50, 50)).ScaleExt(animation.value);
          //
          //     });

          // votedList = numberWhoVoted <= 0 ? EmptyWidget()
          //  : ListView.builder(
          //   itemCount: numberWhoVoted,
          //   scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, i) {
          //
          //   return Avatar(playersWhoVoted[i].profileImage!, size: Size(50, 50));
          //
          // });


          Widget buttonPanel = Row(
              children:
              [

                Column(
                    children: [
                      CupertinoButton(
                          color: AppColors.trueColor,
                          child: Text('TRUE'),
                          onPressed: () => vote(true)).ExpandedExt()
                    ]).ExpandedExt(),

                Column(
                    children: [
                      CupertinoButton(
                          color: AppColors.bullColor,
                          child: Text('BULL'),
                          onPressed: () => vote(false)).ExpandedExt()
                    ]).ExpandedExt()

              ]
          );


          return SafeArea(
              child: Scaffold(
                  backgroundColor: Color.fromARGB(255, 225, 226, 255),
                  appBar: CupertinoNavigationBar(
                    leading: Text(thisPageName, style: AppStyles.DebugStyle(32),),
                  ),
                  body: !sufficientInfo ? MyLoadingIndicator()
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      playerWhoseTurnPanel.FlexibleExt(),

                      votedList.FlexibleExt(),

                      Column(
                        children: [

                          _buildTimerDisplay()

                        ],
                      ).ExpandedExt(),


                      buttonPanel.ExpandedExt(),

                    ],
                  ).PaddingExt(EdgeInsets.all(20))

              ));
        },
        listener: (context, state) {

          GameRoomRoutes.pageListener(context, state, thisPageName);

          if(state is NewPlayerVotedState)
            {
              setState(() {
                this.animatedVoterId = state.voterId;
              });
              _animController.forward(from: 0);
              //print('Inserting voter (${state.numberVotedSoFar.toString()})');
              //if(_animListKey.currentState != null) _animListKey.currentState!.insertItem(state.numberVotedSoFar - 1);
            }
          // if(state is NewTimeElapsedState)
          // {
          //   setState(() {
          //     t = getMsFromMins(state.model.room!.settings!.roundTimer!) - state.time * 1000;
          //   });
          // }

        }


        );
  }



}