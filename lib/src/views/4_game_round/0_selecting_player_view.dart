import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_round_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectingPlayerPhaseView extends ConsumerStatefulWidget {
  const SelectingPlayerPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectingPlayerPhaseViewState();
}

class _SelectingPlayerPhaseViewState
    extends ConsumerState<SelectingPlayerPhaseView>
    with RoomID, WhoseTurnID, UserID {
  late Timer _timer;
  static const int timerDurationMs = 100; // 1500;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(milliseconds: timerDurationMs), () {
      _onTimerEnd();
    });
  }

  void _onTimerEnd() {
    Navigator.of(context).pushReplacementNamed(RoundPhase.shuffling.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AutoSizeText('Selecting Next Player',
              style: Theme.of(context).textTheme.displayLarge),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
