import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/new/main/utter_bull.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'home/home_navigator.dart';

class MainNavigator extends ConsumerStatefulWidget {
  const MainNavigator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends ConsumerState<MainNavigator> {
  @override
  void initState() {
    super.initState();
    _navKey = GlobalKey<NavigatorState>();
  }

  late final GlobalKey<NavigatorState> _navKey;

  @override
  Widget build(BuildContext context) {
    ref.listen(
        authNotifierProvider.select((data) => data.valueOrNull?.occupiedRoomId),
        (prev, next) {
      Logger().d('MainNavigator: occupiedRoomId changed from $prev to $next');
      if (next != null) {
        _navKey.currentState?.pushReplacementNamed('game/$next');
      } else if (prev != null && next == null) {
        _navKey.currentState?.pushReplacementNamed('/');
      }
    });

    return Navigator(
      key: _navKey,
      observers: [CoordinatedRouteObserver()],
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return BackwardFadePushRoute((_) => HomeNavigator());
        } else if (settings.name!.contains('game')) {
          final roomId = settings.name!.split('/').last;
          final userId = ref.read(authNotifierProvider).value!.userId!;
          return ForwardFadePushRoute((_) => ProviderScope(
            overrides: [
                getCurrentGameRoomIdProvider.overrideWithValue(roomId),
                getSignedInPlayerIdProvider.overrideWithValue(userId),
              ], child: const GameView()));
        }
      },
    );
  }
}
