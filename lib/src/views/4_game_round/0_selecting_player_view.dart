import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/mixins/game_hooks.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectingPlayerPhaseView extends ConsumerStatefulWidget {

  const SelectingPlayerPhaseView({super.key, this.isFinalRound = false});

  final bool isFinalRound;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectingPlayerPhaseViewState();
}

class _SelectingPlayerPhaseViewState
    extends ConsumerState<SelectingPlayerPhaseView>
    with Progress, GameHooks {
  late Timer _timer;

  late Duration timerDurationMs =
      UtterBullGlobal.selectingPlayerScreenDuration;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(timerDurationMs, () {
      _onTimerEnd();
    });
  }

  void _onTimerEnd() {
    if(widget.isFinalRound)
    {
      Navigator.of(context).pushReplacementNamed('${RoundPhase.reader.name}/true');
    }
    else
    {
      Navigator.of(context).pushReplacementNamed(RoundPhase.shuffling.name);
    }
  }

  final AutoSizeGroup _autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (widget.isFinalRound ? 'One More To Go!' : 'Selecting Next Player')
                .split(' ')
                .map((s) => AutoSizeText(s,
                    maxLines: 1,
                    group: _autoSizeGroup,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge))
                .toList(),
          ),
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
