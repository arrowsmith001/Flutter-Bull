import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/voting_phase_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VotingEndView extends ConsumerStatefulWidget {
  const VotingEndView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VotingEndViewState();
}

class _VotingEndViewState extends ConsumerState<VotingEndView>
    with RoomID, UserID, WhoseTurnID {
  static const String voteTrueButtonLabel = 'TRUE';
  static const String voteBullButtonLabel = 'BULL';

  get gameNotifier => ref.read(gameNotifierProvider(roomId).notifier);
  
  void onVoteTrue() => vote(true);


  void onVoteBull() => vote(false);

  void onEndRound() {
    gameNotifier.endRound(userId);
  }

  void vote(bool trueOrFalse) {
    gameNotifier.vote(userId, trueOrFalse);
  }

  @override
  Widget build(BuildContext context) {
    final vmProvider =
        votingPhaseViewNotifierProvider(roomId, userId, whoseTurnId);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(
      body: vmAsync.whenDefault((vm) {
        return Column(
          children: [
            Flexible(
              flex: 3,
              child: Column(children: [
                Expanded(
                    child:
                        _buildStatementTextBox(vm.playersWhoseTurnStatement)),
                Expanded(
                    child:
                        UtterBullPlayerAvatar(vm.playerWhoseTurn.player.name!, vm.playerWhoseTurn.avatarData)),
              ]),
            ),
            Flexible(child: _buildTimer(vm.timeData.toString())),
            Flexible(flex: 5, child: _buildVoteButtons()),
            vm.isReading && vm.roundStatus != RoundStatus.inProgress
                ? SizedBox.shrink()
                : Flexible(
                    flex: 1,
                    child: TextButton(
                      child: Text('End Round'),
                      onPressed: () => onEndRound(),
                    )),
          ],
        );
      }),
    );
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

  Widget _buildTimer(String timeString) {
    return Text(timeString);
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

    _timer = createTicker((elapsed) {
      setState(() {
        _updateMsRemaining(elapsed);
      });
      if (msRemaining == 0) _timer.stop();
    });
    _timer.start();
  }

  late final int msStart;
  late final Ticker _timer;
  late int msRemaining;

  @override
  void dispose() {
    _timer.dispose();
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
