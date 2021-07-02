import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/utilities/res.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

import '../../classes/classes.dart';
import 'package:extensions/extensions.dart';

// TODO Investigate title (consult physical device too) <<<<<<
class UtterBullTitle extends StatefulWidget {
  UtterBullTitle({this.size = Size.zero});

  final Size size;
  final ResourceManager rm = new ResourceManager();

  @override
  _UtterBullTitleState createState() => _UtterBullTitleState();
}

class _UtterBullTitleState extends State<UtterBullTitle> with SingleTickerProviderStateMixin {

  Size get size => widget.size;
  ResourceManager get rm => widget.rm;

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

    bull_image = rm.getUiImage(Assets.images.transparentBullImg);
    utter_text_image = rm.getUiImage(Assets.images.transparentUtter);
    bull_text_image = rm.getUiImage(Assets.images.transparentBull);
    spiny_1_image = rm.getUiImage(Assets.images.spiny1);
    spiny_2_image = rm.getUiImage(Assets.images.spiny2);
    
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

  // List<double> getScaleModifiers(List<ui.Image> list) {
  //   double smallest = 1.0;
  //   for(ui.Image img in list)
  //     {
  //
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    //screenSize = largestSizeOfRatio(screenSize, 1, 1);

    //var size = new Size(screenSize.width, screenSize.height);
    //List<double> scales = getScaleModifiers([utter_text_image, bull_text_image, bull_image, spiny_1_image, spiny_2_image]);

    var utter = CustomPaint(
      size: size,
        foregroundPainter: UtterPainter(utter_text_image, _utterFraction));

    var bull = CustomPaint(
        size: size,
        foregroundPainter: BullPainter(bull_text_image, _bullFraction));

    var bullPic = CustomPaint(
        size: size,
        foregroundPainter: BullImagePainter(bull_image, _bullPicFraction));

    var spiny1 = CustomPaint(
        size: size,
        foregroundPainter: SpinyPainter1(spiny_1_image, _spiny1Fraction));

    var spiny2 = CustomPaint(
        size: size,
        foregroundPainter: SpinyPainter2(spiny_1_image, _spiny2Fraction));

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
    var dstRect = fitRectInside(imageRect, size);// imageRect;
    var scaleFactor = 0.8;

    //
    //dstRect = imageRect;
    canvas.translate(10, 35);
    rotateAroundCenter(canvas, 2 * math.pi * -0.02);
    scaleAroundCenter(canvas, scaleFactor);
    //

    canvas.drawImageRect(image, imageRect, dstRect, Paint());
  }


}

class BullPainter extends SingleImageCustomPainterAlwaysRepaint {
  BullPainter(ui.Image image, this._fraction) : super(image);
  double _fraction;

  @override
  void paint(Canvas canvas, Size size) {

    var imageRect = MyFunctions.getRectFromUiImage(image);
    var dstRect = fitRectInside(imageRect, size);// imageRect;
    var scaleFactor = 0.8;

    //
    //dstRect = imageRect;
    canvas.translate(100, 100);
    scaleAroundCenter(canvas, scaleFactor);
    //

    canvas.drawImageRect(image, imageRect, dstRect, Paint());
  }

}

class BullImagePainter extends SingleImageCustomPainterAlwaysRepaint {
  BullImagePainter(ui.Image image, this._fraction) : super(image);
  double _fraction;

  @override
  void paint(Canvas canvas, Size size) {

    var imageRect = MyFunctions.getRectFromUiImage(image);
    var dstRect = fitRectInside(imageRect, size);// imageRect;
    var scaleFactor = 0.6;


    // dstRect = imageRect;
    // canvas.translate(0, 75);
    // scale(canvas, scaleFactor);


    canvas.drawImageRect(image, imageRect, dstRect, Paint());
  }

}

class SpinyPainter1 extends SingleImageCustomPainterAlwaysRepaint {
  SpinyPainter1(ui.Image image, this._fraction) : super(image);
  double _fraction;

  @override
  void paint(Canvas canvas, Size size) {
    
    var imageRect = MyFunctions.getRectFromUiImage(image);
    var dstRect = fitRectInside(imageRect, size);// imageRect;
    var scaleFactor = 0.45;


    // dstRect = imageRect;
    // scale(canvas, scaleFactor);
    // rotateAroundCenter(canvas, _fraction * 2 * math.pi);

    canvas.translate(50, 0);

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
    var dstRect = fitRectInside(imageRect, size);// imageRect;
    var scaleFactor = 0.475;

    //
    //dstRect = imageRect;
    // scale(canvas, scaleFactor);
    // rotateAroundCenter(canvas, _fraction * 2 * math.pi * 0.5);
    //

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
