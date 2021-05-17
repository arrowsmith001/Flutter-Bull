import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter_bull/utilities/res.dart';

import '../../classes/classes.dart';


class UtterBullTitle extends StatefulWidget {

  final ResourceManager rm = new ResourceManager();

  @override
  _UtterBullTitleState createState() => _UtterBullTitleState();
}

class _UtterBullTitleState extends State<UtterBullTitle> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  late ui.Image bull_image;
  late ui.Image utter_text_image;
  late ui.Image bull_text_image;
  late ui.Image spiny_1_image;
  late ui.Image spiny_2_image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bull_image = widget.rm.getUiImage(Assets.images.transparentBullImg);
    utter_text_image = widget.rm.getUiImage(Assets.images.transparentUtter);
    bull_text_image = widget.rm.getUiImage(Assets.images.transparentBull);
    spiny_1_image = widget.rm.getUiImage(Assets.images.spiny1);
    spiny_2_image = widget.rm.getUiImage(Assets.images.spiny2);
    
    _controller = AnimationController(vsync: this);
    _controller.duration = Duration(seconds: 10);
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) _controller.forward(from: 0);
    });

    utterAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Interval(0, 1)))..addListener(() {
      setState(() {
        _utterFraction = utterAnim.value;
      });});
    bullAnim = Tween<double>(begin: 0, end: 1).animate(_controller)..addListener(() {
      setState(() {
        _bullFraction = bullAnim.value;
      });});
    bullPicAnim = Tween<double>(begin: 0, end: 1).animate(_controller)..addListener(() {
      setState(() {
        _bullPicFraction = bullPicAnim.value;
      });});
    spiny1Anim = Tween<double>(begin: 0, end: 1).animate(_controller)..addListener(() {
      setState(() {
        _spiny1Fraction = spiny1Anim.value;
      });});
    spiny2Anim = Tween<double>(begin: 0, end: 1).animate(_controller)..addListener(() {
      setState(() {
        _spiny2Fraction = spiny2Anim.value;
      });});

    _controller.forward();
  }
  
  late Animation<double> utterAnim, bullAnim, bullPicAnim, spiny1Anim, spiny2Anim;
  double _utterFraction = 0, _bullFraction = 0, _bullPicFraction = 0, _spiny1Fraction = 0, _spiny2Fraction = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var size = new Size(screenSize.width, screenSize.height);

    var utter = CustomPaint(
        foregroundPainter: UtterPainter(utter_text_image, _utterFraction),
        size: size);

    var bull = CustomPaint(
        foregroundPainter: BullPainter(bull_text_image, _bullFraction),
    size: size);

    var bullPic = CustomPaint(
        foregroundPainter: BullImagePainter(bull_image, _bullPicFraction),
        size: size);

    var spiny1 = CustomPaint(
        foregroundPainter: SpinyPainter1(spiny_1_image, _spiny1Fraction),
        size: size);

    var spiny2 = CustomPaint(
        foregroundPainter: SpinyPainter2(spiny_1_image, _spiny2Fraction),
        size: size);


    return Stack(
      children: [
          spiny2, spiny1, utter, bullPic, bull
      ],
    );
  }
}



class UtterPainter extends SingleImageCustomPainterAlwaysRepaint {
  UtterPainter(ui.Image image, this._fraction) : super(image);
  double _fraction;

  @override
  void paint(Canvas canvas, Size size) {

    var imageRect = MyFunctions.getRectFromUiImage(image);
    var dstRect = imageRect;
    var scaleFactor = 0.8;

    //canvas.rotate(-0.2);
    canvas.translate(10, 35);
    rotateAroundCenter(canvas, 2 * math.pi * -0.02);
    scaleAroundCenter(canvas, 0.8);
    canvas.drawImageRect(image, imageRect, dstRect, Paint());
  }

}

class BullPainter extends SingleImageCustomPainterAlwaysRepaint {
  BullPainter(ui.Image image, this._fraction) : super(image);
  double _fraction;

  @override
  void paint(Canvas canvas, Size size) {

    var imageRect = MyFunctions.getRectFromUiImage(image);
    var dstRect = imageRect;
    var scaleFactor = 0.8;

    canvas.translate(100, 100);
    scaleAroundCenter(canvas, scaleFactor);
    canvas.drawImageRect(image, imageRect, dstRect, Paint());
  }

}

class BullImagePainter extends SingleImageCustomPainterAlwaysRepaint {
  BullImagePainter(ui.Image image, this._fraction) : super(image);
  double _fraction;

  @override
  void paint(Canvas canvas, Size size) {

    var imageRect = MyFunctions.getRectFromUiImage(image);
    var dstRect = imageRect;
    var scaleFactor = 0.6;

    //print(_fraction);

    canvas.translate(0, 75);
    scale(canvas, scaleFactor);
    canvas.drawImageRect(image, imageRect, dstRect, Paint());
  }

}

class SpinyPainter1 extends SingleImageCustomPainterAlwaysRepaint {
  SpinyPainter1(ui.Image image, this._fraction) : super(image);
  double _fraction;

  @override
  void paint(Canvas canvas, Size size) {
    
    var imageRect = MyFunctions.getRectFromUiImage(image);
    var dstRect = imageRect;
    var scaleFactor = 0.45;

    scale(canvas, scaleFactor);
    rotateAroundCenter(canvas, _fraction * 2 * math.pi);

    canvas.drawImageRect(image, imageRect, dstRect, Paint()
    ..colorFilter = ColorFilter.mode(ui.Color.fromARGB(255, 255, 255, 255), ui.BlendMode.srcATop));
  }

}

class SpinyPainter2 extends SingleImageCustomPainterAlwaysRepaint {
  SpinyPainter2(ui.Image image, this._fraction) : super(image);
  double _fraction;

  @override
  void paint(Canvas canvas, Size size) {

    var imageRect = MyFunctions.getRectFromUiImage(image);
    var dstRect = imageRect;
    var scaleFactor = 0.475;

    scale(canvas, scaleFactor);
    rotateAroundCenter(canvas, _fraction * 2 * math.pi * 0.5);
    var colorVal = 179;
    canvas.drawImageRect(image, imageRect, dstRect, Paint()
      ..colorFilter = ColorFilter.mode(ui.Color.fromARGB(255, 230, 230, 0), ui.BlendMode.srcATop));
  }
}

class UtterBullTitlePainter extends CustomPainter{
  UtterBullTitlePainter(this.bull_image, this.utter_text_image, this.bull_text_image, this.spiny_1_image, this.spiny_2_image);

  ui.Image bull_image;
  ui.Image utter_text_image;
  ui.Image bull_text_image;
  ui.Image spiny_1_image;
  ui.Image spiny_2_image;

  getRect(ui.Image img) => Rect.fromLTRB(0,0,img.width.toDouble(),img.height.toDouble());

  @override
  void paint(Canvas canvas, Size size) {

    canvas.drawImageRect(spiny_1_image, getRect(spiny_1_image),getRect(spiny_1_image), Paint()
      ..colorFilter = ColorFilter.mode(ui.Color.fromARGB(255, 255, 255, 255), ui.BlendMode.srcIn));

    canvas.drawImageRect(spiny_1_image, getRect(spiny_1_image),getRect(spiny_1_image),Paint()
      ..colorFilter = ColorFilter.mode(ui.Color.fromARGB(255, 122, 122, 122), ui.BlendMode.srcIn));

    canvas.drawImageRect(utter_text_image, getRect(utter_text_image),getRect(utter_text_image), Paint());
    canvas.drawImageRect(bull_image, getRect(bull_image), getRect(bull_image), Paint());
    canvas.drawImageRect(bull_text_image, getRect(bull_text_image), getRect(bull_text_image), Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
