import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';

class UtterBullTitle extends StatefulWidget {
  const UtterBullTitle({
    super.key,
  });

  @override
  State<UtterBullTitle> createState() => _UtterBullTitleState();
}

class _UtterBullTitleState extends State<UtterBullTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController animController =
      AnimationController(vsync: this, duration: const Duration(seconds: 5))
        ..repeat(reverse: false);
  final double rotateFactor = 0.05;
  late Animation<double> rotateAnim = TweenSequence<double>([
    TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -rotateFactor * pi)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween(begin: -rotateFactor * pi, end: rotateFactor * pi)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: rotateFactor* pi, end: 0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1),
  ]).animate(animController);

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(

      builder: (context, constraints) => Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: constraints.biggest.height * 0.45,
            left: constraints.biggest.width *0.1,
            child: UglyOutlinedText('Utter',
            
                maxLines: 1,
                outlineColor: const Color.fromARGB(
                    255, 112, 112, 112) // Theme.of(context).colorScheme.primary,
                ),
          ),
          Positioned(
            left: 0, bottom: 0,
            child: AnimatedBuilder(
                animation: animController,
                builder: (context, _) {
                  return Transform.rotate(
                    angle: rotateAnim.value,
                    child: Transform.translate(
                      offset: Offset(10 * cos(animController.value * 2 * pi),
                          5 * sin(animController.value * 2 * pi)),
                      child: Assets.images.bullHead.image(width: constraints.biggest.width * 0.5),
                    ),
                  );
                }),
          ),
          Positioned(
            top: constraints.biggest.height * 0.45,
            right: constraints.biggest.width *0.1,
            child: Transform.rotate(
              angle: -0.076 * pi,
              child: UglyOutlinedText('Bull',
                  maxLines: 1,
                  outlineColor: const Color.fromARGB(
                      255, 112, 112, 112) // Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
