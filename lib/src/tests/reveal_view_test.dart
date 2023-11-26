
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/5_reveals_phase/reveal_view_model.dart';
import 'package:flutter_bull/src/views/5_reveals_phase/reveal_view.dart';
import 'package:flutter_bull/src/widgets/unique/mobile_app_layout_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevealViewTest extends StatefulWidget {
  const RevealViewTest({super.key});

  static const userId = '1';
  static const roomId = '';
  static const whoseTurnId = '0';

  static int numberOfPlayers = 6;

  @override
  State<RevealViewTest> createState() =>
      _RevealViewTestState();
}

class _RevealViewTestState extends State<RevealViewTest> {

  void onFab() {
    
  }

  GameRoom get createGame {
    final playerOrder =
        List.generate(RevealViewTest.numberOfPlayers, (i) => '$i')
            .reversed
            .toList();

    final votes = Map.fromEntries(playerOrder.map((p) => MapEntry(
        p,
        List.generate(RevealViewTest.numberOfPlayers, (id) {
          final i = int.parse(p);
          return p == RevealViewTest.whoseTurnId
              ? 'p'
              : (i % 2) == 1
                  ? 't'
                  : 'l';
        }))));

    final texts = Map.fromEntries(playerOrder
        .map((p) => MapEntry(p, 'Player statement statement statement')));

    return GameRoom(
        roomCode: "",
        playerOrder: playerOrder,
        subPhase: 0,
        votes: votes,
        texts: texts,
        progress: 0);
  }

  late GameRoom game = createGame;

  Future<Uint8List?> setup() async {
    return await FirebaseStorage.instance
        .ref('pp/default/avatar.jpg')
        .getData();
  }

  RevealViewModel? _revealViewModel;

  // TODO: Test reveal with 1 voter: squash or align?
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: UtterBullGlobal.theme,
      builder: (context, child) => FutureBuilder(
          future: setup(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            final List<PublicPlayer> players = List.generate(
                    RevealViewTest.numberOfPlayers,
                    (i) => PublicPlayer(
                        Player(id: '$i', name: 'Player $i'), snapshot.data));

            _revealViewModel = RevealViewModel(
              game: game,
              players: Map.fromEntries(players.map((e) => MapEntry(e.player.id!, e)))
              ,
              userId: RevealViewTest.userId,
              whoseTurnId: RevealViewTest.whoseTurnId,
              myAchievements: [],
            );

            return MobileAppLayoutContainer(
              child: ProviderScope(
                  overrides: [
                    getCurrentGameRoomIdProvider.overrideWithValue(''),
                    getSignedInPlayerIdProvider
                        .overrideWithValue(RevealViewTest.userId),
                    getPlayerWhoseTurnIdProvider.overrideWithValue(
                        RevealViewTest.whoseTurnId),
                  ],
                  child: Scaffold(
                    floatingActionButton:
                        FloatingActionButton(onPressed: () => onFab()),
                    backgroundColor: Colors.blue,
                    body: Navigator(
                      onGenerateRoute: (settings) {
                        return PageRouteBuilder(pageBuilder:
                            (_, __, ___) {
                          return const RevealView();
                        });
                      },
                    ),
                  )),
            );
          })),
    );
  }
}
