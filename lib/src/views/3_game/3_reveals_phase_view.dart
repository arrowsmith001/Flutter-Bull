import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/controlled_navigator.dart';
import 'package:flutter_bull/src/navigation/navigation_controller.dart';
import 'package:flutter_bull/src/notifiers/view_models/reveals_phase_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/3_game/3_reveals_phase_view_model.dart';
import 'package:flutter_bull/src/views/0_app/splash_view.dart';
import 'package:flutter_bull/src/views/5_reveals_phase/reveal_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevealsPhaseView extends ConsumerStatefulWidget {
  const RevealsPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RevealsPhaseState();
}

// TODO: Subsume timer stuff into class/hook
// TODO: In-out zoom/hero effect?
class _RevealsPhaseState extends ConsumerState<RevealsPhaseView>
    with UserID, RoomID, WhoseTurnID {
  final navController = RevealsPhaseNavigationController();

  late Timer _timer;

  late Duration timerDuration =
      UtterBullGlobal.revealsPreambleTimeMilliseconds; // 1500;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(timerDuration, () {
      _onTimerEnd();
    });
  }

  void _onTimerEnd() {
    Navigator.of(_preambleNavKey.currentState!.context)
        .pushReplacementNamed('');
  }

  final _preambleNavKey = GlobalKey<NavigatorState>();

  late final vmProvider = revealsPhaseViewNotifierProvider(roomId);
  AsyncValue<RevealsPhaseViewModel> get vmAsync => ref.watch(vmProvider);

  @override
  Widget build(BuildContext context) {
/*    final vmProvider = revealsPhaseViewNotifierProvider(roomId);
   final vmAsync = ref.watch(vmProvider); */

    ref.listen(vmProvider.select((value) => value.valueOrNull?.path),
        (_, next) {
      if (next != null) navController.navigateTo(next);
    });

    return Navigator(
      key: _preambleNavKey,
      observers: [CoordinatedRouteObserver()],
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return PageRouteBuilder(pageBuilder: (_, __, ___) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AutoSizeText('Time to Reveal!',
                      style: Theme.of(context).textTheme.displayLarge),
                ),
              ),
            );
          });
        }

        return ForwardFadePushRoute((context) {
          return Center(
            child: vmAsync.whenDefault((vm) {
              return ControlledNavigator(
                  observers: [CoordinatedRouteObserver()],
                  controller: navController,
                  data: vm);
            }),
          );
        });
      },
    );
  }
}

class RevealsPhaseNavigationController
    extends NavigationController<RevealsPhaseViewModel> {
  @override
  Route get defaultRoute =>
      MaterialPageRoute(builder: (context) => const SplashView());

  @override
  String generateInitialRoute(RevealsPhaseViewModel data) {
    return data.path;
  }

  @override
  PageRoute? generateRoute() {
    final whoseTurn = nextRoutePath;

    return ForwardPushRoute((context) => ProviderScope(
        overrides: [getPlayerWhoseTurnIdProvider.overrideWithValue(whoseTurn)],
        child: const RevealView()));
  }
}
