import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/mixins/voting_phase_view_model.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';



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
                          child: UglyOutlinedText(
                            text: time.minuteString,
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
                          child: UglyOutlinedText(
                            text: time.secondString,
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