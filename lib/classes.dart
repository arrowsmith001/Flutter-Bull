import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

abstract class SingleImageCustomPainterAlwaysRepaint extends CustomPainter {

  SingleImageCustomPainterAlwaysRepaint(this.image);
  ui.Image image;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void canvasActionAboutCenter(Canvas canvas, Function func, dynamic funcArg, [Offset offset = Offset.zero]){
    double cx = image.width/2 + offset.dx;
    double cy = image.height/2 + offset.dy;
    canvas.translate(cx, cy);
    func.call(funcArg);
    canvas.translate(-cx, -cy);
  }

  void scale(Canvas canvas, double scaleFactor){
    canvas.scale(scaleFactor, scaleFactor);
  }

  void scaleAroundCenter(Canvas canvas, double scaleFactor){
    canvasActionAboutCenter(canvas, canvas.scale, scaleFactor);
  }

  void rotateAroundCenter(Canvas canvas, double angle, [Offset offset = Offset.zero]) {
    canvasActionAboutCenter(canvas, canvas.rotate, angle, offset);
  }

}

class Validators{

  static String? EmailValidation<T>(T value){
    if(value.toString() == "") return "This field must not be empty";
    return null;
  }

  static String? PasswordValidation<T>(T value){
    if(value.toString() == "") return "This field must not be empty";
    return null;
  }

  static String? UsernameValidation<T>(T value){
    if(value.toString() == "") return "This field must not be empty";
    return null;
  }
}