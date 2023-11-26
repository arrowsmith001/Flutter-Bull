import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/voting_phase_view_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/voting_player.dart';
import 'package:flutter_bull/src/proto/regular_rectangle_packer.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:flutter_bull/src/views/3_game/0_lobby_phase_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumping_dot/jumping_dot.dart';

class VotingPhaseView extends ConsumerStatefulWidget {
  const VotingPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VotingPhaseViewState();
}

class _VotingPhaseViewState extends ConsumerState<VotingPhaseView>
    with RoomID, UserID, WhoseTurnID, SingleTickerProviderStateMixin {
  static const String voteTrueButtonLabel = 'TRUE';
  static const String voteBullButtonLabel = 'BULL';

  late final AnimationController _roundOverAnimController = AnimationController(
      vsync: this,
      duration: UtterBullGlobal.votingEndAnimationDuration,
      reverseDuration: UtterBullGlobal.votingEndAnimationReverseDuration);

  late final Animation<double> _roundOverAnim =
      CurvedAnimation(parent: _roundOverAnimController, curve: Curves.easeOut);

  bool roundOverAnimationReversing = false;

  Color? testColor;
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final modalAnim = ModalRoute.of(context)!.animation!;
      modalAnim.addListener(() {
        if (modalAnim.isCompleted) {}
      });
    });
  }

  @override
  void dispose() {
    _roundOverAnimController.dispose();
    super.dispose();
  }

  double get screenHeight => MediaQuery.of(context).size.height / 2;

  GameNotifier get gameNotifier =>
      ref.read(gameNotifierProvider(roomId).notifier);

  final _timerKey = GlobalKey<TimeDisplayWidgetState>();

  void onVoteTrue() => vote(true);

  void onVoteBull() => vote(false);

  void onEndRound() {
    gameNotifier.endRound(userId!);
  }

  void vote(bool trueOrFalse) {
    gameNotifier.vote(userId!, trueOrFalse);
  }

  void onTimerChange(TimeData time) {
    _timerKey.currentState?.onChange(time);
  }

  void onRoundTimerEnd() async {
    playRoundOverAnimation('TIMES UP!');
  }

  void onAllPlayersVoted() async {
    playRoundOverAnimation('VOTES ARE IN!');
  }

  String? roundEndAnimationMessage;
  void playRoundOverAnimation(String message) async {
    setState(() {
      roundEndAnimationMessage = message;
    });
    await _roundOverAnimController.forward(from: 0);
    setState(() {
      roundOverAnimationReversing = true;
    });
    _roundOverAnimController.reverse(from: 1);
  }

  Size size(BuildContext context) => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    final vmProvider =
        votingPhaseViewNotifierProvider(roomId, userId!, whoseTurnId);
    final vmAsync = ref.watch(vmProvider);

    ref.listen(vmProvider.select((vm) => vm.valueOrNull?.timeData),
        (prev, next) {
      if (prev != null && next != null && prev != next) {
        onTimerChange(next);
      }
    });

    ref.listen(vmProvider.select((vm) => vm.valueOrNull?.roundStatus),
        (prev, next) {
      if (next == RoundStatus.endedDueToTime) {
        onRoundTimerEnd();
      }
      if (next == RoundStatus.endedDueToVotes) {
        onAllPlayersVoted();
      }
    });

    return Scaffold(
      body: vmAsync.whenDefault((vm) {
        final Widget main = Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: _buildTop(context, vm),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: _buildMiddle(vm),
              ),
            ),
            Flexible(
              child: _buildBottom(context, vm),
            ),
          ],
        );

        final Widget timesUpAnimationView = TimesUpAnimationView(
            message: roundEndAnimationMessage ?? '',
            animation: _roundOverAnim,
            isReversing: roundOverAnimationReversing);

        return Stack(
          alignment: Alignment.center,
          children: [main, timesUpAnimationView],
        );
      }),
    );
  }

  Column _buildTop(BuildContext context, VotingPhaseViewModel vm) {
    final height = size(context).height;
    final width = size(context).width;

    final time = Container(
        color: testColor ?? Theme.of(context).primaryColor,
        child: TimeDisplayWidget(key: _timerKey, vm.timeData));

    final avatar = UtterBullPlayerAvatar(null, vm.playerWhoseTurn.avatarData);

    final text = UtterBullTextBox(
      vm.playersWhoseTurnStatement,
      opacity: 0.8,
      padding: const EdgeInsets.all(12.0),
    );

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(
        child: Container(
          color: Color.lerp(Theme.of(context).primaryColor, Colors.white, 0.5),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 0),
            child: LayoutBuilder(builder: (context, constraints) {
              final Size size = constraints.biggest;
              return Stack(alignment: Alignment.center, children: [
                Positioned.fromRect(
                  rect: Rect.fromLTWH(0, 0, size.width * 0.4, size.width * 0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: avatar,
                  ),
                ),
                Positioned.fromRect(
                    rect: Rect.fromLTWH(size.width * 0.4, 0, size.width * 0.6,
                        size.width * 0.4),
                    child: SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: text,
                    ))),
              ]);
            }),
          ),
        ),
      ),
      SizedBox(height: height * 0.1, child: time),
    ]);
  }

  Stack _buildMiddle(VotingPhaseViewModel vm) {
    return Stack(children: [
      PlayersVotedWrapList(vm: vm),
      //SaboteurPickerLayer(ids: vm.eligibleVoterIds, onChanged: onSelectedSaboteurChanged)
    ]);
  }

  ClipRRect _buildBottom(BuildContext context, VotingPhaseViewModel vm) {
    late final Widget child;

    switch (vm.voteOptionsState) {
      case VoteOptionsState.voterCanVote:
        child = _buildVoteButtons(vm);
      case VoteOptionsState.voterCannotVote:
        child = AutoSizeText(
          "${vm.numberOfPlayersVoting} left to vote...",
          style: Theme.of(context).textTheme.displayMedium,
        );
      case VoteOptionsState.voterRoundEnd:
        child = AutoSizeText(
          "Waiting for ${vm.playerWhoseTurn.player.name} to continue...",
          maxLines: 1,
          style: Theme.of(context).textTheme.displayMedium,
        );
      case VoteOptionsState.readerCanSwitchToTruth:
        child = _buildTruthSwitchPrompt(vm.timeForReaderToSwitchToTruth ?? 0);
      case VoteOptionsState.readerAwaitingVoters:
        child = AutoSizeText(
          "${vm.numberOfPlayersVoting} left to vote...",
          style: Theme.of(context).textTheme.displayMedium,
        );
      case VoteOptionsState.readerRoundEnd:
        child = _buildEndRoundButton(vm.roundStatus != RoundStatus.inProgress);
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(duration: const Duration(seconds: 1), child: child),
        ),
      ),
    );
  }

  String? selectedSaboteurId;
  void onSelectedSaboteurChanged(String? newId) {
    setState(() {
      selectedSaboteurId = newId;
    });
  }

  Widget _buildVoteButtons(VotingPhaseViewModel vm) {
    final enabled = !vm.hasVoted && (vm.roundStatus == RoundStatus.inProgress);
    const aspect = 1.0;
    return Row(children: [
      Expanded(
          child: UtterBullButton(
              aspectRatio: aspect,
              color: UtterBullGlobal.truthColor,
              onPressed: enabled ? () => onVoteTrue() : null,
              title: voteTrueButtonLabel,
              isShimmering: false)),
      Expanded(
          child: UtterBullButton(
        aspectRatio: aspect,
        color: UtterBullGlobal.lieColor,
        onPressed: enabled ? () => onVoteBull() : null,
        title: voteBullButtonLabel,
        below: selectedSaboteurId == null
            ? null
            : Row(children: [
                UtterBullPlayerAvatar(null,
                    vm.votingPlayers[selectedSaboteurId]!.player.avatarData),
                Assets.images.icons.achievements.saboteur.image()
              ]),
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

  Widget _buildWaitingForPlayerText(VotingPhaseViewModel vm) {
    return AutoSizeText(
      vm.waitingForPlayerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }

  Widget _buildTruthSwitchPrompt(int i) {
    return UtterBullButton(
        onPressed: () => onSwitchToTruth(),
        leading: UglyOutlinedText(text: "${i}s"),
        title: 'Switch to truth?');
  }

  void onSwitchToTruth() {
    gameNotifier.setTruth(userId!, true);
  }
}

EdgeInsets voterAvatarPadding = const EdgeInsets.all(4.0);

class PlayersVotedWrapList extends StatelessWidget {
  const PlayersVotedWrapList({
    super.key,
    required this.vm,
  });

  static const double notVotedOpacity = 0.7;

  final VotingPhaseViewModel vm;

  final Duration voteAnimationDuration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RegularRectanglePacker(
            items: vm.votingPlayers.values.map((e) {
      final bool hasVoted = e.voteStatus == VoteStatus.hasVoted;

      final UtterBullPlayerAvatar avatar =
          UtterBullPlayerAvatar(null, e.player.avatarData);

      return Padding(
        padding: voterAvatarPadding,
        child: VoterAvatar(
            voteAnimationDuration: voteAnimationDuration,
            hasVoted: hasVoted,
            isRoundInProgress: vm.roundStatus == RoundStatus.inProgress,
            notVotedOpacity: notVotedOpacity,
            avatar: avatar),
      );
    }).toList()));
  }
}

class VoterAvatar extends StatefulWidget {
  const VoterAvatar({
    super.key,
    required this.voteAnimationDuration,
    required this.hasVoted,
    required this.notVotedOpacity,
    required this.avatar,
    required this.isRoundInProgress,
  });

  final Duration voteAnimationDuration;
  final bool hasVoted;
  final double notVotedOpacity;
  final UtterBullPlayerAvatar avatar;

  final bool isRoundInProgress;

  @override
  State<VoterAvatar> createState() => _VoterAvatarState();
}

class _VoterAvatarState extends State<VoterAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController animController = AnimationController(
      vsync: this,
      duration: widget.voteAnimationDuration,
      value: widget.hasVoted ? 1 : 0);
  late Animation<double> anim =
      CurvedAnimation(parent: animController, curve: Curves.elasticInOut);

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  final double scaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) => Transform.scale(
        scale: lerpDouble(1, 1 / scaleFactor, anim.value),
        child: AnimatedOpacity(
          duration: widget.voteAnimationDuration,
          opacity: widget.hasVoted ? 1 : widget.notVotedOpacity,
          child: AnimatedContainer(
            duration: widget.voteAnimationDuration,
            curve: Curves.elasticInOut,
            transformAlignment: Alignment.center,
            transform: (widget.hasVoted)
                ? Matrix4.identity() * scaleFactor
                : Matrix4.identity(),
            onEnd: () {
              animController.forward();
            },
            child: LabelledAvatar(avatar: widget.avatar, labels: [
              AvatarStateLabel(text: 'VOTED', isActive: widget.hasVoted),
              AvatarStateLabel(
                  text: 'NO VOTE',
                  fill: Colors.grey.shade800,
                  isActive: !widget.hasVoted && !widget.isRoundInProgress),
              AvatarStateLabel(
                  isActive: !widget.hasVoted && widget.isRoundInProgress,
                  child: const LoadingDots())
            ]),
          ),
        ),
      ),
    );
  }
}

class LoadingDots extends StatelessWidget {
  const LoadingDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(2, 2),
          child: JumpingDots(
            innerPadding: 5,
            color: Colors.black,
            verticalOffset: -10,
            numberOfDots: 3,
            delay: 600,
          ),
        ),
        JumpingDots(
          innerPadding: 5,
          color: Colors.white,
          verticalOffset: -10,
          numberOfDots: 3,
          delay: 600,
        ),
      ],
    );
  }
}

class TimesUpAnimationView extends StatefulWidget {
  final Animation<double> animation;

  final bool isReversing;
  final String message;

  const TimesUpAnimationView(
      {super.key,
      required this.animation,
      required this.isReversing,
      required this.message});

  @override
  State<TimesUpAnimationView> createState() => _TimesUpAnimationViewState();
}

class _TimesUpAnimationViewState extends State<TimesUpAnimationView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: widget.isReversing ? 0.0 : (widget.animation.value * 4 * pi),
            child: Transform.scale(
              scale: widget.animation.value,
              child: child,
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: UglyOutlinedText(text: widget.message,
                outlineColor: Theme.of(context).primaryColorDark, maxLines: 1),
          ),
        ));
  }
}

class TimeDisplayWidget extends StatefulWidget {
  const TimeDisplayWidget(this.time, {super.key});

  // TODO: Incoporate round status - rapidly count down timer when all votes are in
  final TimeData time;

  @override
  State<TimeDisplayWidget> createState() => TimeDisplayWidgetState();
}

class TimeDisplayWidgetState extends State<TimeDisplayWidget>
    with TickerProviderStateMixin {
  late TimeData time = widget.time;

  final double scale = 1.25;
  final Curve curve = Curves.elasticOut;
  final int ms = 750;

  final int timeNearlyOverSeconds = 10;

  final Color timeNearlyOverFillColor =
      Color.lerp(Colors.red, Colors.white, 0.25)!;
  final Color timeNearlyOverOutlineColor =
      Color.lerp(Colors.red, Colors.black, 0.25)!;

  Color get textColor =>
      (time.timeRemaining?.inSeconds ?? 0) <= timeNearlyOverSeconds
          ? timeNearlyOverFillColor
          : Colors.white;
  Color? get textOutlineColor =>
      (time.timeRemaining?.inSeconds ?? 0) <= timeNearlyOverSeconds
          ? timeNearlyOverOutlineColor
          : null;

  late final AnimationController _mAnimationController = AnimationController(
      vsync: this, duration: Duration(milliseconds: ms), value: 1);
  late final Animation<double> _mAnimation =
      CurvedAnimation(parent: _mAnimationController, curve: curve)
          .drive(Tween(begin: scale, end: 1.0));

  late final AnimationController _sAnimationController = AnimationController(
      vsync: this, duration: Duration(milliseconds: ms), value: 1);
  late final Animation<double> _sAnimation =
      CurvedAnimation(parent: _sAnimationController, curve: curve)
          .drive(Tween(begin: scale, end: 1.0));

  AnimationController? _windDownAnimationController;

  void windDown() {
    _windDownAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    final Animation<Duration> windDownAnimation = CurvedAnimation(
            parent: _windDownAnimationController!, curve: Curves.easeOut)
        .drive(Tween(begin: time.timeRemaining, end: Duration.zero));

    _windDownAnimationController!.addListener(() {
      setTime(TimeData(windDownAnimation.value));
    });

    _windDownAnimationController!.forward();
  }

  void onChange(TimeData newTime) {
    if (_windDownAnimationController?.isAnimating ?? false) return;
    if (newTime.timeRemaining == Duration.zero &&
        (time.timeRemaining?.inSeconds ?? 0) > 1) {
      windDown();
    } else {
      setTime(newTime);
    }
  }

  void setTime(TimeData newTime) {
    if (time.secondString != newTime.secondString) {
      _sAnimationController.forward(from: 0);
    }
    if (time.minuteString != newTime.minuteString) {
      _mAnimationController.forward(from: 0);
    }
    setState(() {
      time = newTime;
    });
  }

  @override
  void dispose() {
    _mAnimationController.dispose();
    _sAnimationController.dispose();
    _windDownAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (time.timeRemaining == null) {
      return const Center(child: UtterBullCircularProgressIndicator());
    }

    return Center(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedBuilder(
                    animation: _mAnimation,
                    builder: (context, _) {
                      return Transform.scale(
                          scale: _mAnimation.value,
                          child: UglyOutlinedText(text: 
                            time.minuteString,
                            fillColor: textColor,
                            outlineColor: textOutlineColor,
                            //style: Theme.of(context).textTheme.displayLarge,
                          ));
                    })
              ],
            )),
        UglyOutlinedText(text: ': ', fillColor: textColor),
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedBuilder(
                    animation: _sAnimation,
                    builder: (context, _) {
                      return Transform.scale(
                          scale: _sAnimation.value,
                          child: UglyOutlinedText(text: 
                            time.secondString,
                            fillColor: textColor,
                            outlineColor: textOutlineColor,
                            // style: Theme.of(context).textTheme.displayLarge,
                          ));
                    }),
              ],
            )),
      ],
    ));
  }
}

class SaboteurPickerLayer extends StatefulWidget {
  const SaboteurPickerLayer({super.key, required this.ids, this.onChanged});

  final List<String> ids;
  final void Function(String?)? onChanged;

  @override
  State<SaboteurPickerLayer> createState() => _SaboteurPickerLayerState();
}

class _SaboteurPickerLayerState extends State<SaboteurPickerLayer>
    with TickerProviderStateMixin {
  late final AnimationController _entryAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late final Animation<double> _entryAnimation = CurvedAnimation(
          parent: _entryAnimationController, curve: Curves.elasticOut)
      .drive(Tween(begin: 0, end: scale));

  late final AnimationController _exitAnimationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
  late final Animation<double> _exitAnimation = CurvedAnimation(
          parent: _exitAnimationController, curve: Curves.decelerate)
      .drive(Tween(begin: 1, end: exitScale));

  void onChanged(String? selectedId) {
    if (widget.onChanged != null) widget.onChanged!(selectedId);
  }

  final scale = 1.15;
  final exitScale = 1.4;
  String? selectedId;

  @override
  Widget build(BuildContext context) {
    return RegularRectanglePacker(
        items: widget.ids
            .map((e) => GestureDetector(
                onTap: () async {
                  if (selectedId == e) {
                    await _exitAnimationController.forward(from: 0);

                    setState(() {
                      _entryAnimationController.value = 0.0;
                      selectedId = null;
                    });
                  } else {
                    _exitAnimationController.value = 0.0;
                    _entryAnimationController.forward(from: 0);

                    setState(() {
                      selectedId = e;
                    });
                  }

                  onChanged(selectedId);
                },
                child: e == selectedId
                    ? AnimatedBuilder(
                        animation: _exitAnimation,
                        builder: (context, child) => Opacity(
                          opacity: (1 - _exitAnimationController.value),
                          child: Transform.scale(
                            scale: _exitAnimation.value,
                            child: AnimatedBuilder(
                              animation: _entryAnimation,
                              builder: (context, child) => Padding(
                                padding: voterAvatarPadding,
                                child:
                                    Stack(clipBehavior: Clip.none, children: [
                                  Transform.scale(
                                    scale: _entryAnimation.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 5,
                                              color:
                                                  Colors.red.withOpacity(0.5))),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.transparent,
                      )))
            .toList());
  }
}
