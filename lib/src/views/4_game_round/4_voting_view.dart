import 'dart:math';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/voting_phase_view_notifier.dart';
import 'package:flutter_bull/src/proto/regular_rectangle_packer.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class VotingPhaseView extends ConsumerStatefulWidget {
  const VotingPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VotingPhaseViewState();
}

class _VotingPhaseViewState extends ConsumerState<VotingPhaseView>
    with RoomID, UserID, WhoseTurnID {
  static const String voteTrueButtonLabel = 'TRUE';
  static const String voteBullButtonLabel = 'BULL';

  double get screenHeight => MediaQuery.of(context).size.height / 2;

  GameNotifier get gameNotifier =>
      ref.read(gameNotifierProvider(roomId).notifier);

  void onVoteTrue() => vote(true);

  void onVoteBull() => vote(false);

  void onEndRound() {
    gameNotifier.endRound(userId);
  }

  void vote(bool trueOrFalse) {
    gameNotifier.vote(userId, trueOrFalse);
  }

  // TODO: Notify
  void onRoundTimerEnd() {}

  @override
  Widget build(BuildContext context) {
    final vmProvider =
        votingPhaseViewNotifierProvider(roomId, userId, whoseTurnId);
    final vmAsync = ref.watch(vmProvider);

    ref.listen(vmProvider.select((vm) => vm.valueOrNull?.isRoundInProgress),
        (prev, next) {
      if (next == false) {
        onRoundTimerEnd();
        
      }
    });

    return Scaffold(
      body: vmAsync.whenDefault((vm) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 2,
              child: Column(children: [
                Expanded(
                    child: UtterBullPlayerAvatar(
                        null, vm.playerWhoseTurn.avatarData)),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: UtterBullTextBox(
                    vm.playersWhoseTurnStatement,
                    padding: const EdgeInsets.all(12.0),
                  ),
                )),
              ]),
            ),
            Expanded(child: _buildTimer(vm.timeString)),
            Expanded(
              flex: 1,
              child: PlayersVotedWrapList(vm: vm),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: vm.isReading
                        ? _buildEndRoundButton(!vm.isRoundInProgress)
                        : vm.isRoundInProgress
                            ? _buildVoteButtons(
                                !vm.hasVoted && vm.isRoundInProgress)
                            : _buildWaitingForPlayerText(vm)),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildVoteButtons(bool enabled) {
    return Row(children: [
      Expanded(
          child: UtterBullButton(
              color: UtterBullGlobal.truthColor,
              onPressed: enabled ? () => onVoteTrue() : null,
              title: voteTrueButtonLabel,
              isShimmering: false)),
      Expanded(
          child: UtterBullButton(
        color: UtterBullGlobal.lieColor,
        onPressed: enabled ? () => onVoteBull() : null,
        title: voteBullButtonLabel,
        isShimmering: false,
      )),
    ]);
  }

  Widget _buildEndRoundButton(bool enabled) {
    return UtterBullButton(
      title: 'End Round',
      onPressed: enabled ? () => onEndRound() : null,
    );
  }

  Widget _buildTimer(String timeString) {
    return Center(
        child: AutoSizeText(timeString, style: TextStyle(fontSize: 100)));
  }

  Widget _buildWaitingForPlayerText(VotingPhaseViewModel vm) {
    return AutoSizeText(
      vm.waitingForPlayerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

class PlayersVotedWrapList extends StatelessWidget {
  const PlayersVotedWrapList({
    super.key,
    required this.vm,
  });

  static const double notVotedOpacity = 0.5;

  final VotingPhaseViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RegularRectanglePacker(
          items: vm.eligibleVoterIds
              .map((id) => vm.playerMap[id])
              .toList()
              .map((e) {
            final Widget child = UtterBullPlayerAvatar(null, e!.avatarData);
            if (vm.eligibleVoterStatus[e.player.id] ?? false) {
              return child;
            }
            return Opacity(opacity: notVotedOpacity, child: child);
          }).toList()),
    );
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
