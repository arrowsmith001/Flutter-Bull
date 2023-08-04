import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/0_app/auth_container.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_bull/src/views/1_auth/login_view.dart';
import 'package:flutter_bull/src/views/1_auth/main_view.dart';
import 'package:flutter_bull/src/views/2_main/game_view.dart';
import 'package:flutter_bull/src/views/2_main/home_view.dart';
import 'package:flutter_bull/src/views/2_main/pending_view.dart';
import 'package:flutter_bull/src/views/2_main/profile_view.dart';
import 'package:flutter_bull/src/views/3_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/2_game_round_view.dart';
import 'package:flutter_bull/src/views/3_game/3_reveals_phase_view.dart';
import 'package:flutter_bull/src/views/3_game/4_results_phase_view.dart';
import 'package:flutter_bull/src/views/4_game_round/2_selecting_player_phase_view.dart';
import 'package:flutter_bull/src/views/4_game_round/3_voting_phase_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_tabs/go_router_tabs.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'utter_bull_router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => AuthContainer(), routes: [
        TabShellRoute(
            builder: (context, state, index, child) => child,
            subPageBuilder: (context, state, direction, child) {
              return TabTransitionPage(
                key: state.pageKey,
                child: child,
                direction: direction,
                transitionsBuilder:
                    TabTransitionPage.horizontalSlideFadeTransition,
              );
            },
            routes: (subPageBuilder, direction) {
              return [
                GoRoute(
                  path: 'login',
                  name: 'login',
                  pageBuilder: (context, state) =>
                      subPageBuilder!(context, state, child: LoginView()),
                ),
                GoRoute(
                    path: 'main/:userId',
                    name: 'main',
                    pageBuilder: (context, state) => subPageBuilder!(
                        context, state,
                        child: UserProvided(state.pathParameters['userId'],
                            child: MainView())),
                    routes: UtterBullRouter._mainRoutes)
              ];
            }).toShellRoute
      ]),
    ],
  );
}

class UserProvided extends StatelessWidget {
  UserProvided(this.userId, {required this.child});
  final Widget child;
  final Object? userId;
  @override
  Widget build(BuildContext context) {
    return ProviderScope(overrides: [
      getSignedInPlayerIdProvider.overrideWithValue(userId as String)
    ], child: child);
  }
}

class UtterBullRouter {
  // TODO: Figure out go router
  // GoRouter.of(context).pushReplacementNamed(name)

  static void navigate(BuildContext context, String name,
      [Map<String, String>? args]) {
/*     Logger().d('Navigating: $name with $arg');
    context.goNamed(name, pathParameters: arg); */
    if (args == null)
      context.goNamed(name);
    else
      context.goNamed(name, pathParameters: args);
  }

  static List<RouteBase> get _mainRoutes => [
        TabShellRoute(
            builder: (context, state, index, child) => child,
            subPageBuilder: (context, state, direction, child) {
              return TabTransitionPage(
                key: state.pageKey,
                child: child,
                direction: direction,
                transitionsBuilder:
                    TabTransitionPage.horizontalSlideFadeTransition,
              );
            },
            routes: (subPageBuilder, direction) => [
                  GoRoute(
                      path: 'pending',
                      name: 'pending',
                      pageBuilder: (context, state) => subPageBuilder!(
                            child: UserProvided(state.pathParameters['userId'],
                                child: PendingView()),
                            context,
                            state,
                          )),
                  GoRoute(
                      path: 'home',
                      name: 'home',
                      pageBuilder: (context, state) {
                        Logger().d('state: ${state.fullPath}');
                        return subPageBuilder!(
                          child: UserProvided(state.pathParameters['userId'],
                              child: HomeView()),
                          context,
                          state,
                        );
                      }),
                  GoRoute(
                      path: 'profile',
                      name: 'profile',
                      pageBuilder: (context, state) => subPageBuilder!(
                            child: UserProvided(state.pathParameters['userId'],
                                child: ProfileView()),
                            context,
                            state,
                          )),
                  GoRoute(
                      path: 'game',
                      name: 'game',
                      builder: (context, state) {
                        final roomId = state.pathParameters['roomId'];

                        return ProviderScope(overrides: [
                          getSignedInPlayerIdProvider
                              .overrideWithValue(roomId as String)
                        ], child: GameView());
                      })
                ]).toShellRoute,
      ];

  static get _gameRoutes => [
        GoRoute(path: 'lobby', builder: (context, state) => LobbyPhaseView()),
        GoRoute(path: 'writing', builder: (context, state) => HomeView()),
        GoRoute(
            path: 'round',
            builder: (context, state) => GameRoundView(),
            routes: _roundRoutes),
        GoRoute(
            path: 'reveals', builder: (context, state) => RevealsPhaseView()),
        GoRoute(
            path: 'results', builder: (context, state) => ResultsPhaseView()),
      ];

  static get _roundRoutes => [
        GoRoute(
            path: 'selecting',
            builder: (context, state) => SelectingPlayerPhaseView()),
        GoRoute(path: 'voting', builder: (context, state) => VotingPhaseView()),
      ];
}
