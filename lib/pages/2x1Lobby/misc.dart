
import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/utilities/local_res.dart';
import 'package:flutter_bull/utilities/res.dart';

class MySliderTrack extends SliderTrackShape with BaseSliderTrackShape {
  // TODO Make dots show
  static const bool isEnabled = true;
  static const bool isDiscrete = true;
  // @override
  // Rect getPreferredRect({required RenderBox parentBox, Offset offset = Offset.zero, required SliderThemeData sliderTheme, bool isEnabled = isEnabled, bool isDiscrete = isDiscrete}) {
  //   // TODO: implement getPreferredRect
  //   return Rect.fromLTWH(0, 0, parentBox.size.width, parentBox.size.height);
  // }

  @override
  void paint(PaintingContext context, Offset offset, {required RenderBox parentBox, required SliderThemeData sliderTheme, required Animation<double> enableAnimation, required Offset thumbCenter, bool isEnabled = isEnabled, bool isDiscrete = isDiscrete, required TextDirection textDirection}) {
    final Canvas canvas = context.canvas;
    final Rect rect = getPreferredRect(parentBox: parentBox, sliderTheme: sliderTheme);
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(10));

    canvas.drawRRect(rrect, new Paint()..color = sliderTheme.activeTrackColor!);
    //canvas.d
  }

}

class RoundTimerSliderThumbShape extends SliderComponentShape {

  static const Color NUMBER_COLOR = Colors.blueAccent;

  RoundTimerSliderThumbShape(this.sliderValue, {
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius = 10.0,
  });

  double sliderValue;

  late TextPainter _textPainter = new TextPainter(
    text: TextSpan(
        style: AppStyles.defaultStyle(fontSize: 54, color: NUMBER_COLOR, shadows: [BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 45)]),
        text: sliderValue.toInt().toString()),
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,);

  final double enabledThumbRadius;

  final double disabledThumbRadius;
  double get _disabledThumbRadius =>  disabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    // canvas.drawCircle(
    //   center,
    //   radiusTween.evaluate(enableAnimation),
    //   Paint()..color = colorTween.evaluate(enableAnimation)!,
    // );
    var rm = ResourceManager();
    var image = rm.uiImageMap[Assets.images.clock.path];
    var bg = rm.uiImageMap[Assets.images.clockBg.path];
    if(image == null || bg == null) return;

    var src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    double f = image.width.toDouble() / image.height.toDouble();
    double length = (enabledThumbRadius * 2) * 0.9;

    var dest = Rect.fromCenter(center: center, width: length * f, height: length);

    double dyOffset = 5.0;
    canvas.drawImageRect(bg, src, dest, Paint());
    canvas.drawImageRect(image, src, dest, Paint()..color = Colors.white);
    _textPainter.layout();
    _textPainter.paint(canvas, new Offset(center.dx - _textPainter.width/2, dyOffset + center.dy - _textPainter.height/2));
  }
}
