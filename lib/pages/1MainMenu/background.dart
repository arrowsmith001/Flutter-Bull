import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/particles.dart';
import 'package:flutter_bull/resources.dart';
import 'package:flutter_bull/utilities.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart';
import '../../widgets.dart';

class MainMenuBackgroundEffect extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var rm = new ResourceManager();
    return MainMenuBackgroundEffectProxy(
        [
          rm.getUiImage(Assets.images.transparentBubble)
        ],
        Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height));
  }
}


class MainMenuBackgroundEffectProxy extends StatefulWidget {
  MainMenuBackgroundEffectProxy(this.image, this.screenSize);
  final List<ui.Image> image;
  final Size screenSize;

  @override
  _MainMenuBackgroundEffectProxyState createState() => _MainMenuBackgroundEffectProxyState();
}

class _MainMenuBackgroundEffectProxyState extends State<MainMenuBackgroundEffectProxy> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<ImageParticle> bubbles = [];

  final int numberOfBubbles = 20;
  final double minScale = 0.2;
  final double maxScale = 0.6;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.duration = Duration(days: 1);
    _controller.addListener(() { updateParticlePosition(); });
    _controller.forward();

    var image = widget.image;
    var screenSize = widget.screenSize;

    var randoms = new List.generate(numberOfBubbles, (index) => Random().nextDouble());
    randoms.sort();

    for(int i = 0; i < numberOfBubbles; i++)
    {
      ui.Image randomImage = image[(image.length * Random().nextDouble()).toInt()];
      Bubble bubble = new Bubble(randomImage, screenSize, scale: ui.lerpDouble(minScale, maxScale, randoms[i])!);
      bubble.x = -bubble.desiredWidth + Random().nextDouble() * (screenSize.width + bubble.desiredWidth);
      bubble.y = -bubble.desiredHeight + Random().nextDouble() * (screenSize.height + bubble.desiredHeight);
      bubbles.add(bubble);
    }
  }

  void updateParticlePosition() {

    bubbles.forEach((bubble) { bubble.updatePosition(); });
    setState(() {

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return CustomPaint(
      foregroundPainter: ParticlePainter(bubbles),
      size: screenSize
    );


  }

}



class ParticlePainter extends CustomPainter {
  List<ImageParticle> particles;

  ParticlePainter(this.particles);
  @override
  void paint(Canvas canvas, Size size) {
    particles.forEach((particle) { particle.draw(canvas, size); });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


abstract class ImageParticle {
  void updatePosition();
  void draw(Canvas canvas, Size size);
}


class Bubble extends ImageParticle{

  final double baseSpeed = 3;

  late double x;
  late double y;
  late double desiredWidth;
  late double desiredHeight;
  late double ySpeed;
  double drift = 0.4;
  double driftOffset = Random().nextDouble() * 2 * 3.14;

  Bubble(this.image, this.screenSize, {double scale = 1.0}){
    this.desiredWidth = image.width * scale;
    this.desiredHeight = image.height * scale;
    ySpeed = baseSpeed * scale;
  }

  ui.Image image;
  Size screenSize;
  
  @override Rect getImageRect(){
    return new Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble());
  }

  @override
  void updatePosition() {
    if(y < -desiredHeight){
      x = -image.width + Random().nextDouble() * (screenSize.width + image.width);
      y = screenSize.height + desiredHeight;

    }

    y -= ySpeed;
    x += drift * sin(0.005 * y + driftOffset);
    
  }

  @override
  void draw(Canvas canvas, Size size) {


    canvas.drawImageRect(image, getImageRect(),
        new Rect.fromLTRB(x, y, x+desiredWidth, y+desiredHeight),
        new Paint()..color = Colors.white..invertColors=true); //Offset(size.width/i, size.height/i)

  }

}

