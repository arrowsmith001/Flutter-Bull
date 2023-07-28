import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/model/game_room_state.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/room_notifier.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/in_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/in_game/1_writing_phase_view.dart';
import 'package:flutter_bull/src/views/in_game/2_selecting_player_phase_view.dart';
import 'package:flutter_bull/src/views/in_game/3_voting_phase_view.dart';
import 'package:flutter_bull/src/views/in_game/4_results_phase_view.dart';
import 'package:flutter_bull/src/views/splash_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class GameView extends ConsumerStatefulWidget {
  const GameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends ConsumerState<GameView> {
  final navigatorKey = GlobalKey<NavigatorState>();

  //get navigatorKey => widget.navigatorKey;

  String _phaseToRoute(GameRoomStatePhase? phase) =>
      '/' + phase.toString().split('.').last;

  @override
  Widget build(BuildContext context) {
    final roomId = ref.watch(getCurrentGameRoomIdProvider);

    final roomNotifier = roomNotifierProvider(roomId);

    ref.listen(roomNotifier.select((value) => value.value?.phase),
        (prev, next) {
      Logger().d('gameRoom.phase.listen: $prev $next');

      if (prev != null && next != null) _navigateToPhase(next);
    });

    final stateAsync = ref.watch(roomNotifier);

/*     return Column(
      children: [
        TextButton(onPressed: () => Navigator.of(navigatorKey.currentContext!).pushNamed('/'), child: Text('press')),
        Expanded(
          child: Navigator(
            key: navigatorKey,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(builder: (context) => Text('test'));
            },
          ),
        ),
      ],
    ); */

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        ref
            .read(signedInPlayerStatusNotifierProvider(
                    ref.read(getSignedInPlayerIdProvider))
                .notifier)
            .leaveRoom(ref.read(getCurrentGameRoomIdProvider));
      }),
      body: Center(
        child: stateAsync.whenDefault((room) {
          return Navigator(
            key: navigatorKey,
            initialRoute: _phaseToRoute(room.phase),
            onGenerateRoute: (settings) {
/* 
               final gameRoomOverride =
                  getCurrentGameRoomProvider.overrideWithValue(); */

              switch (settings.name) {
                case '/lobby':
                  return MaterialPageRoute(
                      builder: (context) => ProviderScope(
                          overrides: [], child: LobbyPhaseView()));
                case '/writing':
                  return MaterialPageRoute(
                      builder: (context) => ProviderScope(overrides: [
                            //getCurrentGameRoomProvider.overrideWithValue(state)
                          ], child: WritingPhaseView()));
                case '/selecting':
                  return MaterialPageRoute(
                      builder: (context) => ProviderScope(overrides: [
                            // getCurrentGameRoomProvider.overrideWithValue(state)
                          ], child: SelectingPlayerPhaseView()));
                case '/reading':
                  return MaterialPageRoute(
                      builder: (context) => ProviderScope(overrides: [
                            // getCurrentGameRoomProvider.overrideWithValue(state)
                          ], child: VotingPhaseView()));
                case '/results':
                  return MaterialPageRoute(
                      builder: (context) => ProviderScope(overrides: [
                            // getCurrentGameRoomProvider.overrideWithValue(state)
                          ], child: ResultsPhaseView()));
              }

              return MaterialPageRoute(builder: (context) => SplashView());
            },
          );
        }),
      ),
    );
  }

  void _navigateToPhase(GameRoomStatePhase? phase) {
    _navigateTo(_phaseToRoute(phase));
  }

  void _navigateTo(String s, {Object? args}) {
    if (navigatorKey.currentState != null) {
      Navigator.of(navigatorKey.currentState!.context)
          .pushReplacementNamed(s, arguments: args);

      Logger().d('Navigated to: $s ${DateTime.now().toIso8601String()}');
    } else {
      Logger().d('Error navigating to: $s ${DateTime.now().toIso8601String()}');
    }
  }
}
