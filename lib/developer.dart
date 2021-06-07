import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bull/firebase/_bloc_events.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc.dart';
import 'package:flutter_bull/pages/2GameRoom/_bloc_events.dart' as grEvent;
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/repository.dart';
import 'package:flutter_bull/widgets.dart';
import 'package:flutter_bull/extensions.dart';
import 'package:uuid/uuid.dart';

import 'classes/firebase.dart';
import 'firebase/_bloc.dart';

class DeveloperPanel extends StatefulWidget {
  DeveloperPanel(BuildContext context);


  @override
  _DeveloperPanelState createState() => _DeveloperPanelState();
}

class _DeveloperPanelState extends State<DeveloperPanel> {

  GameRoomBloc get _gameBloc => BlocProvider.of<GameRoomBloc>(context);
  FirebaseBloc get _fbBloc => BlocProvider.of<FirebaseBloc>(context);
  Repository get _repo => RepositoryProvider.of<Repository>(context);

  static const String CREATE_PLAYER_AND_ADD_TO_ROOM = 'Create player and add to room';
  static const String SUBMIT_ALL_BOT_STATEMENTS = 'Submit all bot statements';
  static const String SUBMIT_ALL_STATEMENTS = 'Submit all statements';
  static const String BOTS_VOTE_STAGGERED = 'Bots vote staggered';
  static const String RANDOM_VOTE = 'Random vote';
  static const String BEGIN_PLAY_FROM_CHOOSE = 'Begin play from choose';
  static const String BEGIN_CHOOSE_FROM_END_OF_PLAY = 'Begin choose from end of play';
  static const String REVEAL_NEXT = 'Reveal next';
  static const String NEXT_REVEAL_TURN = 'Next reveal turn';
  late List<String> actions;

  bool executing = false;
  int? selectedAction;
  Future<void> executeSelectedAction() async {

    setState(() { executing = true; });

    String action = actions[selectedAction!];

    DataModel model = _fbBloc.model;
    String roomCode = model.room!.code!;

    switch(action){
      case CREATE_PLAYER_AND_ADD_TO_ROOM:

        String uid = _getTestPlayerUid();
        await _repo.setPlayerField(uid, '', {
          Player.ID : uid,
          Player.OCCUPIED_ROOM_CODE : model.room!.code,
          Player.NAME : 'Bot' + Random().nextInt(1000).toString(),
          Player.PROFILE_ID : await _getRandomProfileId()
        });
        await _repo.joinGame(uid, roomCode);

        break;
      case SUBMIT_ALL_BOT_STATEMENTS:
        for(String userId in model.playerMap.keys)
        {
          if(!_isTestId(userId)) continue;
          await _setTextSubmission(userId, roomCode, model);
        }
        break;
      case SUBMIT_ALL_STATEMENTS:
        for(String userId in model.playerMap.keys)
        {
          await _setTextSubmission(userId, roomCode, model);
        }
        break;
      case BOTS_VOTE_STAGGERED:
        for(String userId in model.playerMap.keys)
        {
          if(model.haveTheyVoted(userId)! && !model.isItTheirTurn(userId)!) continue;
          _randomVote(userId, model, Duration(seconds: 1));
        }
        break;
      case RANDOM_VOTE:

          var ite = model.playerMap.keys
              .where((userId) => !model.haveTheyVoted(userId)! && !model.isItTheirTurn(userId)!);
              ite.forEach((element) {print('Eligible: ' + element);});
              String? userId = ite.getRandom();
          if(userId != null) {
            print('Trying to vote: ' + userId);
            _randomVote(userId, model);
          }

        break;
      case BEGIN_PLAY_FROM_CHOOSE:
        _fbBloc.add(StartRoundEvent());
        break;
      case BEGIN_CHOOSE_FROM_END_OF_PLAY:
        _gameBloc.add(grEvent.NextTurnRequestedFromPlayEvent());
        break;
      case REVEAL_NEXT:
        _gameBloc.add(grEvent.AdvanceRevealNumberEvent());
        break;
      case NEXT_REVEAL_TURN:
        _gameBloc.add(grEvent.NextTurnRequestedFromRevealsEvent());
        break;
    }

    setState(() { executing = false; });
  }

  Future<void> _randomVote(String userId, DataModel model, [Duration delay = Duration.zero]) async {
    bool votedTrue = Random().nextBool();
    String userWhoseTurnId = model.getPlayerWhoseTurn()!.id!;
    String targetId = model.getPlayerTarget(userId)!;
    int t = Random().nextInt(model.room!.settings[Room.SETTINGS_ROUND_TIMER]*60);

    Vote vote = Vote.fromData(userId, votedTrue, userWhoseTurnId, targetId, t);

    await Future.delayed(delay);
    await _repo.pushVote(userId, model.room!.code!, vote, model.room!.turn!);
  }

  String _getTestPlayerUid(){
    return 'TEST_' + Uuid().v4();
  }
  bool _isTestId(String s){
    return s.substring(0, 5) == 'TEST_';
  }
  Future<void> _setTextSubmission(String userId, String roomCode, DataModel model) async
  {
    try
        {
          bool isTruth = model.getPlayerTruth(userId)!;
          String target = model.getPlayerTarget(userId)!;
          String statement = 'This is a '
              + (isTruth ? 'TRUTH' : 'LIE')
              + ' written ' + (isTruth ? 'about myself': 'for ${model.getPlayer(target)!.name}');

          await _repo.setRoomField(roomCode, [Room.PLAYER_TEXTS, target], statement);

        }
        catch(e)
    {
      print(e.toString());
    }
  }

  bool devOptionsOpen = false;

  double l = 0;
  double t = 0;

  @override
  Widget build(BuildContext context) {

    actions = [
      CREATE_PLAYER_AND_ADD_TO_ROOM,
      SUBMIT_ALL_BOT_STATEMENTS,
      SUBMIT_ALL_STATEMENTS,
      BOTS_VOTE_STAGGERED,
      RANDOM_VOTE,
      BEGIN_PLAY_FROM_CHOOSE,
      BEGIN_CHOOSE_FROM_END_OF_PLAY,
      REVEAL_NEXT,
      NEXT_REVEAL_TURN
    ];
    
    double dim = 75;
    Size size = MediaQuery.of(context).size;

    Widget widget = GestureDetector(
      onTap: () {
        setState(() {
          devOptionsOpen = true;
        });
      },
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 0, 0, 255)),
              height: dim,
              width: dim,
              child: Icon(Icons.settings, size: dim)),

          selectedAction == null ? EmptyWidget()
            : GestureDetector(
              onTap: () => executing ? null : executeSelectedAction(),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                height: dim,
                width: dim,
                child: Icon(Icons.play_arrow, size: dim, color: executing ? Colors.grey : Colors.lightGreen)),
            ),

        ],
      ),
    );

    Widget devIcon = Positioned(
      width: 75 * 2,
      height: 75,
      top: t, left: l,
      child: Draggable(
        childWhenDragging: EmptyWidget(),
        onDragEnd: (details) {
          setState(() {
            l = details.offset.dx;
            t = details.offset.dy;
          });
        },
        feedback: widget,
        child: widget,),
    );



    Widget devOptions =
      Positioned(
        left: 0, top: 0, width: size.width, height: size.height,
          child: Container(
            color: Colors.grey.withOpacity(0.3),
              child: ListView.builder(
                itemCount: this.actions.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {setState(() {
                        selectedAction = i;
                        devOptionsOpen = false;
                      });},
                        child: Text(actions[i], style: AppStyles.DebugStyle(24, weight: FontWeight.bold)).PaddingExt(EdgeInsets.symmetric(vertical: 12)));
                  }
              ).PaddingExt(EdgeInsets.symmetric(vertical: 50, horizontal: 25))
              // TODO DEV OPTIONS TO SIMULATE EVERYTHING
          ),
        );

    Widget exitButton =
        Positioned(
          left: size.width - 75 - 10, top: 10, width: 75, height: 75,
          child: GestureDetector(
            onTap: () => setState(() { devOptionsOpen = false; }),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red)
            ),
          ),
        );

    return Stack(
      children: [

        devIcon,

        devOptionsOpen ? devOptions : EmptyWidget(),

        devOptionsOpen ? exitButton : EmptyWidget(),

      ],
    );
  }

  Future<String> _getRandomProfileId() async {
    return 'stock_' + (Random().nextInt(11) + 1).toString() + '.jpg';
  }
}
