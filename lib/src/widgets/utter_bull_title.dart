import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:zwidget/zwidget.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:logger/logger.dart';

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

  final double bullImgRotateFactor = 0.05;

  late Animation<double> bullImgRotateAnim = TweenSequence<double>([
    TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -bullImgRotateFactor * pi)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween(
                begin: -bullImgRotateFactor * pi, end: bullImgRotateFactor * pi)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween<double>(begin: bullImgRotateFactor * pi, end: 0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1),
  ]).animate(animController);

  final double utterRotateFactor = 0.1;
  late final double utterRotateExtent = utterRotateFactor * pi;

  late Animation<double> utterAnim = TweenSequence<double>([
    TweenSequenceItem(
        tween: Tween<double>(begin: -1.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween(begin: 1.0, end: -1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2)
  ]).animate(animController);

  final double bullRotateFactor = 0.1;
  late final double bullRotateExtent = bullRotateFactor * pi;

  late Animation<double> bullAnim = TweenSequence<double>([
    TweenSequenceItem(
        tween: Tween<double>(begin: -1.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2),
    TweenSequenceItem(
        tween: Tween(begin: 1.0, end: -1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1)
  ]).animate(animController);

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  final String utter = 'UTTER';
  final String bull = 'BULL';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: constraints.biggest.height * 0.45,
            left: constraints.biggest.width * 0.1,
            child: AnimatedBuilder(
              animation: utterAnim,
              builder: (context, child) {
                return ZWidget.builder(
                  rotationY: utterAnim.value * utterRotateExtent,
                  builder: (_) => UglyOutlinedText(
                    textSpan: TextSpan(children: [
                      ...List<TextSpan>.generate(utter.length, (i) {
                        return TextSpan(
                            text: utter[i],
                            style: TextStyle(
                              color: Color.lerp(
                                  UtterBullGlobal.truthColor,
                                  Colors.white,
                                  0.3 +
                                      (1 + utterAnim.value) * (0.1 + i * 0.05)),
                            ));
                      })
                    ]),
    
                    maxLines: 1,
                    fillColor: Color.lerp(
                        UtterBullGlobal.truthColor, Colors.white, 0.7),
                    outlineColor: Color.lerp(
                        UtterBullGlobal.truthColor,
                        Colors.black,
                        0.85), //const Color.fromARGB( 255, 112, 112, 112)
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            bottom: constraints.biggest.height * 0.1,
            child: AnimatedBuilder(
                animation: animController,
                builder: (context, _) {
                  return Transform.rotate(
                    angle: bullImgRotateAnim.value,
                    child: Transform.translate(
                      offset: Offset(10 * cos(animController.value * 2 * pi),
                          5 * sin(animController.value * 2 * pi)),
                      child: Assets.images.bullHeadMouthOpen
                          .image(width: constraints.biggest.width * 0.5),
                    ),
                  );
                }),
          ),
          Positioned(
            top: constraints.biggest.height * 0.45,
            right: constraints.biggest.width * 0.05,
            child: Transform.scale(
              scale: 1.1,
              child: Transform.rotate(
                angle: -0.076 * pi,
                child: AnimatedBuilder(
                  animation: bullAnim,
                  builder: (context, child) {
                    // Logger().d(bullRotateFactor.toString() +
                    //     " " +
                    //     bullAnim.value.toString());
                    return ZWidget.builder(
                      rotationY: bullAnim.value * bullRotateExtent,
                      builder: (_) => UglyOutlinedText(
                        textSpan: TextSpan(children: [
                          ...List<TextSpan>.generate(bull.length, (i) {
                            return TextSpan(
                                text: bull[i],
                                style: TextStyle(
                                  color: Color.lerp(
                                      UtterBullGlobal.lieColor,
                                      Colors.white,
                                      0.1 +
                                          (1 + bullAnim.value) *
                                              (0.1 + i * 0.05)),
                                ));
                          })
                        ]),
    
                        fillColor: Color.lerp(
                            UtterBullGlobal.lieColor, Colors.white, 0.2),
                        maxLines: 1,
                        outlineColor: Color.lerp(
                            UtterBullGlobal.lieColor,
                            Colors.black,
                            0.85), //const Color.fromARGB( 255, 112, 112, 112)
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
