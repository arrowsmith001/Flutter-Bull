import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'dart:ui' as ui;

import 'package:flutter_bull/utilities.dart';

class UtterBullTitle extends StatefulWidget {

  @override
  _UtterBullTitleState createState() => _UtterBullTitleState();
}

class _UtterBullTitleState extends State<UtterBullTitle> {

  late ui.Image bull_image;
  late ui.Image utter_text_image;
  late ui.Image bull_text_image;
  late ui.Image spiny_1_image;
  late ui.Image spiny_2_image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var rm = new ResourceManager();
    bull_image = rm.getUiImage(Assets.images.transparentBullImg);
    utter_text_image = rm.getUiImage(Assets.images.transparentUtter);
    bull_text_image = rm.getUiImage(Assets.images.transparentBull);
    spiny_1_image = rm.getUiImage(Assets.images.spiny1);
    spiny_2_image = rm.getUiImage(Assets.images.spiny2);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var size = new Size(screenSize.width, screenSize.height/3);

    return CustomPaint(
      foregroundPainter: UtterBullTitlePainter(bull_image, utter_text_image, bull_text_image, spiny_1_image, spiny_2_image),
      size: size,
    );
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
    canvas.drawImageRect(spiny_1_image, getRect(spiny_1_image),getRect(spiny_1_image), Paint());
    canvas.drawImageRect(spiny_2_image, getRect(spiny_2_image),getRect(spiny_2_image),Paint());
    canvas.drawImageRect(utter_text_image, getRect(utter_text_image),getRect(utter_text_image), Paint());
    canvas.drawImageRect(bull_image, getRect(bull_image), getRect(bull_image), Paint());
    canvas.drawImageRect(bull_text_image, getRect(bull_text_image), getRect(bull_text_image), Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
