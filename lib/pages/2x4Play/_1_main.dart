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
import 'package:flutter_bull/utilities/game.dart';
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
import 'package:extensions/extensions.dart';
import 'dart:ui' as ui;

import '../../routes.dart';

class PlayMain extends StatefulWidget {

  @override
  _PlayMainState createState() => _PlayMainState();
}

class _PlayMainState extends State<PlayMain> with TickerProviderStateMixin {

  // TODO Make "PLAY" minimally viable <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  final String thisPageName = RoomPages.PLAY;

  GameRoomBloc get _bloc => BlocProvider.of<GameRoomBloc>(context, listen: false);

  late AnimationController _animController;
  String? animatedVoterId;

  bool get isRoundOver => t == 0;
  bool get hasEveryoneVoted => _bloc.model.getNumberWhoVoted(_bloc.model.room!.turn!) == _bloc.model.roomPlayerCount - 1;

  @override
  void initState() {
    super.initState();

    _animController = new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animController.addListener(() {setState(() {});});

    unixRoundStart = GameParams.getTrueUnixFromDownloaded(_bloc.model.room!.roundStartUnix!);
    int unixNow = _unix;
    int elapsed = unixNow - unixRoundStart;
    t = max(0, getMsFromMins(totalMinutes) - elapsed);

    if(t == 0)
      {
        // Take some action as round is over
        _disableVoting();
      }

    if(_bloc.model.haveIVoted == true || _bloc.model.isItMyTurn == true) _disableVoting();

    initialItemCount = _bloc.model.getNumberWhoVoted(_bloc.model.room!.turn!)!;

    if(hasEveryoneVoted) _onRoundEnd();
    else _createTimer();
  }

  void _disableVoting(){
    setState(() {
      votingEnabled = false;
    });
  }

  int initialItemCount = 0;
  int unixRoundStart = 0;
  int get _unix => DateTime.now().millisecondsSinceEpoch;

  void _onPlayerVoted(NewPlayerVotedState state) {
    print('_onPlayerVoted() ${state.player!.name}');
    setState(() {
      this.animatedVoterId = state.voterId;
      if(state.model.myId == state.player!.id!) _onMyVote();
    });
    _animController.forward(from: 0);
  }

  void _onAllPlayersVoted(GameRoomModel model) {
    print('_onAllPlayersVoted()');
    if(_roundTimer != null) _roundTimer!.cancel();
    setState(() {
      t = 0;
    });
  }

  // When round ends from the timer
  void _onRoundEnd() {
    print('_onRoundEnd()');
    setState(() {
      votingEnabled = false;
    });
  }

  void _createTimer(){
    _roundTimer = new Timer.periodic(
        new Duration(milliseconds: 10),
            (timer) {
              setState(()
              {
                  if(t <= 0)
                  {
                    t = 0;
                    if(_roundTimer != null) _roundTimer!.cancel();
                    _onRoundEnd();
                  }
                  else t = getMsFromMins(totalMinutes) - (_unix - unixRoundStart);
          });
          //print(_start.toString());
        }
    );
  }

  @override
  void dispose(){
    if(_roundTimer != null) _roundTimer!.cancel();
    _animController.dispose();
    super.dispose();
  }

  late int totalMinutes = _bloc.model.room!.settings[Room.SETTINGS_ROUND_TIMER]; // Total minutes

  int t = 0; // Current time in milliseconds
  int get getRoundTimerTotalInMs => getMsFromMins(totalMinutes); // Total round time in ms
  double get timerFraction => (t / getRoundTimerTotalInMs).clamp(0.0, 1.0); // Fraction of timer [0, 1]

  int getMsFromMins(int mins) => mins*60*1000;
  int getMinsFromMs(int ms) => max(0, (ms/(60*1000)).floor());
  int getSecsOnMinFromMs(int ms) => max(0, (ms/(1000)).floor() - getMinsFromMs(ms)*60);
  int getMsOnMinFromMs(int ms) => max(0, (ms - getMinsFromMs(ms)*60*1000) % 1000);

  Timer? _roundTimer;

  Widget _buildTimerDisplay(){

    int m = getMinsFromMs(t);
    int s = getSecsOnMinFromMs(t);
    int ms = (getMsOnMinFromMs(t) / 100).floor();

    return Column(
      children: [
        Text('${m} : ${s} : ${ms}', style: AppStyles.defaultStyle(fontSize: 48)),
        Container(color: Colors.white, height: 10, width: (MediaQuery.of(context).size.width - 100)*timerFraction,)
      ],
    );
  }

  int getSecondsElapsed(int ms) => totalMinutes*60 - max(0, (ms/1000).floor());
  bool voting = false;
  bool votingEnabled = true;
  void vote(bool? votedTrue) {
    setState(() {
      voting = true;
    });
    _bloc.add(VoteEvent(votedTrue, getSecondsElapsed(t)));
  }

  void _onMyVote() {
    _disableVoting();
  }

  Widget _buildVoteButton(bool voteTrue) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10)
          ]
      ),
      child: Column(
          children: [
            CupertinoButton(
                padding: EdgeInsets.all(24),
                color: voteTrue ? AppColors.trueColor : AppColors.bullColor,
                child: AutoSizeText(voteTrue ? 'TRUE' : 'BULL', maxLines: 1, style: AppStyles.defaultStyle(fontSize: 100)),
                onPressed: !votingEnabled ? null : () => vote(voteTrue)).xExpanded()
          ]),
    );
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

          Widget playerWhoseTurnPanel = Row(
            children: [
              Avatar(player!.profileImage, size: Size(100, 100))
                  .xHero(player.id??''),

              MyBubble(text!, size: Size(100, 100)).xExpanded()
            ],
          ).xEmptyUnless(sufficientInfo);

          List<Player> playersWhoVoted = state.model.getPlayersWhoVoted(turn, includeEmptyVotes: true);
          List<Player> playersWhoCanVote = state.model.getPlayersWhoCanVote(turn);

          //print('voted: ' + playersWhoVoted.toString() + ', canVote: ' + playersWhoCanVote.toString());

          Widget votedList = Wrap(
            //onReorder: (int oldIndex, int newIndex) {  },
            children: List.generate(playersWhoCanVote.length, (i) {

                Player p = playersWhoCanVote[i];

                Widget avatar = Avatar(p.profileImage!,
                    borderColor: playersWhoVoted.contains(p) ? Colors.lightGreen : null, size: Size(65, 65))
                  .xPadding(EdgeInsets.all(8));

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

                _buildVoteButton(true).xPadSym(h: 16).xExpanded(),
                _buildVoteButton(false).xPadSym(h: 16).xExpanded(),

              ]
          );


          return Scaffold(
              backgroundColor: Colors.transparent,
              body: !sufficientInfo ? MyLoadingIndicator()
                  : SafeArea(
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                    playerWhoseTurnPanel.xFlexible(),

                    votedList.xFlexible(),

                    Column(
                      children: [

                        _buildTimerDisplay()

                      ],
                    )
                        //.ExpandedExt()
                  ,


                    buttonPanel.xExpanded(),

                  CupertinoButton(
                      child: Container(
                        color: Colors.white,
                          child: Text('BEGIN NEXT ROUND').xPadSym(v: 12, h : 36)),
                      onPressed: () => goToNextTurn()
                  ).xEmptyUnless((state.model.isItMyTurn??false) && isRoundOver)

                ],
              ).xPadding(EdgeInsets.all(20)),
                  )

          )
              .xBoxDecorContainer(
              BoxDecoration(
                  gradient: RadialGradient(
                      colors: [ Color.lerp(AppColors.MainColor, Colors.white, 0.5)!,AppColors.MainColor,],
                      radius: 2,
                      focal: Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.6))));
        },
        listener: (context, state) {

          //GameRoomRoutes.pageListener(context, state, thisPageName, this.widget);

          if(state is NewUnixTimeState){
            setState(() {
              unixRoundStart = GameParams.getTrueUnixFromDownloaded(state.newTime);
            });
          }

          if(state is NewPlayerVotedState)
          {
            _onPlayerVoted(state);
            //print('Inserting voter (${state.numberVotedSoFar.toString()})');
            //if(_animListKey.currentState != null) _animListKey.currentState!.insertItem(state.numberVotedSoFar - 1);
          }

          if(state is AllPlayersVotedState)
          {
            _onAllPlayersVoted(state.model);
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