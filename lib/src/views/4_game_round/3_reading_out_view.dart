import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/mixins/auth_hooks.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_round_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReadingOutView extends ConsumerStatefulWidget {
  const ReadingOutView({super.key});

  @override
  ConsumerState<ReadingOutView> createState() => _ReadingOutViewState();
}

class _ReadingOutViewState extends ConsumerState<ReadingOutView>
    with  Progress, AuthHooks {
  get vmProvider => gameRoundViewNotifierProvider(userId!, gameId!, 'progress');

  AsyncValue<GameRoundViewModel> get vmAsync => ref.watch(vmProvider);

  bool startingRound = false;

  Future<void> onTimerEnd() async {
    setState(() {
      startingRound = true;
    });

    ref.read(gameNotifierProvider(gameId!).notifier).startRound(userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: 
    Container(
      decoration: UtterBullGlobal.gameViewDecoration,
      child: Center(child: vmAsync.whenDefault((vm) {
        final playerWhoseTurn =
            vm.players['progress']!;
    
        Widget avatar = Hero(
            tag: 'avatar',
            child: UtterBullPlayerAvatar(null, playerWhoseTurn.avatarData));
    
        Widget prompt = Hero(
          tag: 'prompt',
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16.0)),
            child: Column(children: [
              Expanded(
                child: UtterBullTextBox(vm.playerWhoseTurnStatement),
              ),
            ]),
          ),
        );
    
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: avatar,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: prompt,
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularTimer(vm.timeToReadOut,
                        onComplete: () => onTimerEnd()),
              ),
            )
          ],
        );
      })),
    ));
  }
}

class CircularTimer extends StatefulWidget {
  const CircularTimer(this.maxSeconds, {super.key, this.onComplete});

  final int maxSeconds;
  final VoidCallback? onComplete;

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer>
    with SingleTickerProviderStateMixin {

  late AnimationController animController;
  late Animation<double> anim;

  @override
  void initState() {
    super.initState();

    animController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.maxSeconds));

    anim = CurvedAnimation(parent: animController, curve: Curves.linear)
        .drive(Tween(begin: widget.maxSeconds.toDouble(), end: 0));

    anim.addListener(() {

      int seconds = anim.value.ceil();

      setState(() {
      if (seconds != secondsRemaining) {
          secondsRemaining = seconds;
      }});
    });

    anim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });

    animController.forward();
  }

  late int secondsRemaining = widget.maxSeconds;

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double radius = min(constraints.maxWidth, constraints.maxHeight) / 2;
        return Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(radius: radius, percent: animController.value),
            Text(secondsRemaining.toString())
          ],
        );
      }
    );
  }
}
