import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/room_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/views/in_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/in_game/1_writing_phase_view.dart';
import 'package:flutter_bull/src/views/in_game/2_selecting_player_phase_view.dart';
import 'package:flutter_bull/src/views/in_game/3_voting_phase_view.dart';
import 'package:flutter_bull/src/views/in_game/4_results_phase_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameView extends ConsumerStatefulWidget {
  const GameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends ConsumerState<GameView> {
  @override
  Widget build(BuildContext context) {
    final userIdMaybe = ref.watch(authServiceProvider).getUserId;
    final signedInPlayerAsync = ref.watch(playerNotifierProvider(userIdMaybe));

    return Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          
          return signedInPlayerAsync.whenDefault((player) {
            final roomAsync =
                ref.watch(roomNotifierProvider(player.occupiedRoomId));

            return roomAsync.whenDefault((room) {
              return Navigator(
                initialRoute: '/lobby',
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case '/lobby':
                      return MaterialPageRoute(
                          builder: (context) => LobbyPhaseView());
                    case '/writing':
                      return MaterialPageRoute(
                          builder: (context) => WritingPhaseView());
                    case '/selecting':
                      return MaterialPageRoute(
                          builder: (context) => SelectingPlayerPhaseView());
                    case '/reading':
                      return MaterialPageRoute(
                          builder: (context) => VotingPhaseView());
                    case '/results':
                      return MaterialPageRoute(
                          builder: (context) => ResultsPhaseView());
                  }
                },
              );
            });
          });
        }),
      ),
    );
  }
}
