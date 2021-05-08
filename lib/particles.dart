
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:image/image.dart' as image;
import 'package:flutter/widgets.dart' as widgets;
import 'gen/assets.gen.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:developer' as dev;


class ParticleEffect extends StatefulWidget {
  ParticleEffect(this.image);
  final ui.Image image;
  @override
  _ParticleEffectState createState() => _ParticleEffectState();
}

class _ParticleEffectState extends State<ParticleEffect> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  List<Particle> particles = [];
  final int numberOfParticles = 20;
  final Color color = Colors.white;
  final int maxSize = 30;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    particles = [];
    int i = numberOfParticles;
    while(i > 0){
      particles.add(new Particle(color, maxSize, widget.image));
      i--;
    }

    _controller = new AnimationController(vsync: this, duration: Duration(days: 100));
    _controller.addListener(() { updateParticlePosition();});
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: ParticlePainter(particles: particles, controller: _controller),
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height)
    );
  }

  void updateParticlePosition() {

    particles.forEach((element) {element.updatePosition();});
    setState(() {

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

class ParticlePainter extends CustomPainter {
  List<Particle> particles;
  AnimationController controller;

  ParticlePainter({required this.particles, required this.controller});
  @override
  void paint(Canvas canvas, Size size) {
    //particles.forEach((particle) {particle.draw(canvas, size);});
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  Color color = Colors.white;
  double direction = 0;
  double speed = 0;
  int size = 0;
  double x = 100;
  double y = 200;
  ui.Image image;

  Particle(Color color, int maxSize, this.image){
    this.color = color;//.withOpacity(Random().nextDouble());
    this.direction = Random().nextDouble() * 360;
    this.speed = 1;
    this.size = Random().nextInt(maxSize);
  }

  void updatePosition() {
    var a = 180 - (direction + 90);
    direction > 0 && direction < 180 ?
    x += speed * sin(direction) / sin(speed)
        : x -= speed * sin(direction) / sin(speed);

    direction > 90 && direction < 270 ?
    y += speed * sin(a) / sin(speed)
        : y -= speed * sin(a) / sin(speed);
  }

  Future<void> draw(Canvas canvas, int canvasSize) async {
    Paint paint = new Paint()
        ..color = color
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    canvas.drawImage(image, (Offset(x,y)), paint);

    //canvas.drawCircle(Offset(x,y), 5.0, paint);
  }



  void assignRandomPositionIfUninitialized(canvasSize) {
    if(x == null){
      this.x = Random().nextDouble() * canvasSize.width;
    }
    if(y == null){
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }

  void randomlyChangeDirectionIfEdgeReached(canvasSize) {
    if(x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0){
      direction = Random().nextDouble() * 360;
    }
  }
}

