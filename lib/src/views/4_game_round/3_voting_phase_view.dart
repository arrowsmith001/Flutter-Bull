import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/timer_state.dart';
import 'package:flutter_bull/src/notifiers/timer_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/widgets/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class VotingPhaseView extends ConsumerStatefulWidget {
  const VotingPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VotingPhaseViewState();
}

mixin RoomID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get roomId => ref.watch(getCurrentGameRoomIdProvider);
}
mixin UserID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get userId => ref.watch(getSignedInPlayerIdProvider);
}
mixin WhoseTurnID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get whoseTurn => ref.watch(getPlayerWhoseTurnIdProvider);
}

class _VotingPhaseViewState extends ConsumerState<VotingPhaseView>
    with RoomID, UserID, WhoseTurnID {
  static const String voteTrueButtonLabel = 'TRUE';
  static const String voteBullButtonLabel = 'BULL';

  void onVoteTrue() => vote(true);

  void onVoteBull() => vote(false);

  void onEndRound() {
    final gameNotifier = ref.read(gameNotifierProvider(roomId).notifier);
    gameNotifier.endRound(userId);
  }

  void vote(bool trueOrFalse) {
    final gameNotifier = ref.read(gameNotifierProvider(roomId).notifier);
    gameNotifier.vote(userId, trueOrFalse);
  }

  @override
  Widget build(BuildContext context) {
    final game = gameNotifierProvider(roomId);
    final gameStateAsync = ref.watch(game);

    final endTime = ref.watch(game.select((value) => value.value?.endTime));
    final timer = ref.watch(timerNotifierProvider(endTime));

    return gameStateAsync.whenDefault((g) {
      final whoseTurnAvatar = g.getAvatar(whoseTurn);
      final statement = g.getStatement(whoseTurn);
      final isMyTurn = g.isTurnOf(userId);

      return Column(
        children: [
          Flexible(
            flex: 3,
            child: Column(children: [
              Expanded(child: _buildStatementTextBox(statement)),
              Expanded(
                  child: UtterBullPlayerAvatar(whoseTurnAvatar.avatarData)),
            ]),
          ),
          !timer.hasValue ? SizedBox.shrink() : Flexible(child: Text(timer.value!.timeString)),
          Flexible(flex: 5, child: _buildVoteButtons()),
          !isMyTurn
              ? SizedBox.shrink()
              : Flexible(
                  flex: 1,
                  child: TextButton(
                    child: Text('End Round'),
                    onPressed: () => onEndRound(),
                  )),
        ],
      );
    });
  }

  Widget _buildStatementTextBox(String statement) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: AutoSizeText(
          statement,
          style: Theme.of(context).textTheme.bodyMedium,
        )),
      ),
    );
  }

  Widget _buildVoteButtons() {
    return Row(children: [
      Expanded(
          child: TextButton(
              onPressed: () => onVoteTrue(), child: Text(voteTrueButtonLabel))),
      Expanded(
          child: TextButton(
              onPressed: () => onVoteBull(), child: Text(voteBullButtonLabel))),
    ]);
  }
}

// TODO: Compare performance with notified stream version
class TimerDisplay extends StatefulWidget {
  const TimerDisplay(this.endTimeUTC, {super.key});
  final int? endTimeUTC;
  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    var startTime = DateTime.now();

    msStart = widget.endTimeUTC == null
        ? 0
        : widget.endTimeUTC! - startTime.millisecondsSinceEpoch;

    msRemaining = msStart;

    _ticker = createTicker((elapsed) {
      setState(() {
        _updateMsRemaining(elapsed);
      });
      if (msRemaining == 0) _ticker.stop();
    });
    _ticker.start();
  }

  late final int msStart;
  late final Ticker _ticker;
  late int msRemaining;

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  String get timeString {
    final int secondsLeft = (msRemaining / 1000).floor();
    final int minutesLeft = (secondsLeft / 60).floor();

    /* final int ms = msRemaining - (secondsLeft * 1000);
    final int s = secondsLeft - (minutesLeft * 60);
    final int m = minutesLeft;

    final String millisecondString =
        ms == 0 ? '--' : ms.toString().padLeft(3 - ms.toString().length, '0');
    final String secondString =
        s == 0 ? '--' : s.toString().padLeft(2 - s.toString().length, '0');
    final String minuteString = m == 0 ? '--' : m.toString(); */

    return minutesLeft.toString() + ' : ' + secondsLeft.toString();
    //return '$minuteString:$secondString:$millisecondString';
  }

  @override
  Widget build(BuildContext context) {
    return Text(timeString);
  }

  void _updateMsRemaining(Duration elapsed) {
    msRemaining = max(0, msStart - elapsed.inMilliseconds);
  }
}
