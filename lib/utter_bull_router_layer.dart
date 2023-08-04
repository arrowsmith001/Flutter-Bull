import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/1_auth/login_view.dart';
import 'package:flutter_bull/src/views/1_auth/main_view.dart';
import 'package:flutter_bull/src/views/2_main/game_view.dart';
import 'package:flutter_bull/src/views/2_main/home_view.dart';
import 'package:flutter_bull/src/views/2_main/pending_view.dart';
import 'package:flutter_bull/src/views/2_main/profile_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_tabs/go_router_tabs.dart';
import 'package:logger/logger.dart';


class UtterBullRoutedApp extends ConsumerWidget {
  UtterBullRoutedApp({super.key});

  final navKey = GlobalKey<NavigatorState>();

  late final router = GoRouter(
    navigatorKey: navKey,
    initialLocation: '/login',
    routes: [
      TabShellRoute(
        builder: (context, state, index, child) => child,
        subPageBuilder: (context, state, direction, child) {
          return TabTransitionPage(
            key: state.pageKey,
            child: child,
            direction: direction,
            transitionsBuilder: TabTransitionPage.horizontalSlideFadeTransition,
          );
        },
        routes: (subPageBuilder, direction) => [
          GoRoute(
            path: '/login',
            pageBuilder: (context, state) => subPageBuilder!(
              context,
              state,
              child: LoginView(),
            ),
          ),
          GoRoute(
              path: '/main',
              pageBuilder: (context, state) => subPageBuilder!(
                    context,
                    state,
                    child: ProviderScope(overrides: [
                      getSignedInPlayerIdProvider
                          .overrideWithValue(state.extra as String)
                    ], child: Container()),
                  ),
              routes: [
                TabShellRoute(
        builder: (context, state, index, child) => child,
        subPageBuilder: (context, state, direction, child) {
          return TabTransitionPage(
            key: state.pageKey,
            child: child,
            direction: direction,
            transitionsBuilder: TabTransitionPage.horizontalSlideFadeTransition,
          );
        },
        routes: (subPageBuilder, direction) => [
          GoRoute(
            path: 'pending',
            pageBuilder: (context, state) => subPageBuilder!(
              context,
              state,
              child: Text('hi'),
            ),
          ),
          GoRoute(
            path: 'profile',
            pageBuilder: (context, state) => subPageBuilder!(
              context,
              state,
              child: ProfileView(),
            ),
          ),
          GoRoute(
            path: 'home',
            pageBuilder: (context, state) => subPageBuilder!(
              context,
              state,
              child: HomeView(),
            ),
          ),
          GoRoute(
            path: 'game',
            pageBuilder: (context, state) => subPageBuilder!(
              context,
              state,
              child: GameView(),
            ),
          ),
        ],
      ).toShellRoute
              ]),
        ],
      ).toShellRoute,
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(authNotifierProvider.select((value) => value.value?.userId),
        (prev, next) {
      Logger().d('authNotifierProvider: $prev $next');
      if (next != null) {
        GoRouter.of(navKey.currentContext!).go('/main', extra: next);
      } else {
        GoRouter.of(navKey.currentContext!).go('/login');
      }
    });



/*     final userId = ref.watch(getSignedInPlayerIdProvider);

    final signedInPlayer = signedInPlayerStatusNotifierProvider(userId);
    final signedInPlayerAsync = ref.watch(signedInPlayer);

    ref.listen<PlayerStatus?>(
        signedInPlayer.select((state) => state.value?.status),
        _onPlayerStatusChanged);

    ref.listen<bool?>(signedInPlayer.select((state) => state.value?.exists),
        _onPlayerProfileExistenceChanged);

    ref.listen<String?>(
        signedInPlayer.select((state) => state.value?.player?.occupiedRoomId),
        _onOccupiedRoomChanged);

    ref.listen<String?>(
        signedInPlayer.select((state) => state.value?.player?.name),
        _onPlayerNameChanged);
 */



    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: UtterBullTheme.theme,
      //home: false ? TestWidget() : AuthContainer()
    );
  }
}
