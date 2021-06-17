import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import 'firebase.dart';

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

  Rect shrinkImageToFitSize(ui.Image image, Size size) {
    if(image.height <= size.height && image.width <= size.width)
      return Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());

    double heightRatio = size.height / image.height;
    double widthRatio = size.width / image.width;

    double w, h;
    if(heightRatio < widthRatio)
      {
        w = image.width.toDouble() * heightRatio;
        h = image.height.toDouble() * heightRatio;
      }
    else
      {
        w = image.width.toDouble() * widthRatio;
        h = image.height.toDouble() * widthRatio;
      }

      double dw = size.width - w;
      double dh = size.height - h;
      return Rect.fromLTWH(dw/2, dh/2, w, h);
  }

}

class MyBorderRadii {

  static const DIALOG_BORDER_RADIUS = 10.0;
  static const BorderRadius BOTTOM_ONLY = BorderRadius.only(
      bottomLeft: Radius.circular(DIALOG_BORDER_RADIUS),
      bottomRight: Radius.circular(DIALOG_BORDER_RADIUS));

  static const BorderRadius TOP_ONLY = BorderRadius.only(
      topLeft: Radius.circular(DIALOG_BORDER_RADIUS),
      topRight: Radius.circular(DIALOG_BORDER_RADIUS));

  static const BorderRadius ALL = BorderRadius.all(Radius.circular(DIALOG_BORDER_RADIUS));

  static const BorderRadius NONE = BorderRadius.zero;

  static const BorderRadius BOTTOM_LEFT_ONLY = BorderRadius.only(
      bottomLeft: Radius.circular(DIALOG_BORDER_RADIUS));

  static const BorderRadius BOTTOM_RIGHT_ONLY = BorderRadius.only(
      bottomRight: Radius.circular(DIALOG_BORDER_RADIUS));


  static BorderRadius bottomOnly(double r) => BorderRadius.only(
      bottomLeft: Radius.circular(r),
      bottomRight: Radius.circular(r));

  static BorderRadius topOnly(double r) => BorderRadius.only(
      topLeft: Radius.circular(r),
      topRight: Radius.circular(r));

  static BorderRadius all(double r) => BorderRadius.all(Radius.circular(r));

  static BorderRadius bottomLeftOnly(double r) => BorderRadius.only(
      bottomLeft: Radius.circular(r));

  static BorderRadius bottomRightOnly(double r) => BorderRadius.only(
      bottomRight: Radius.circular(r));

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