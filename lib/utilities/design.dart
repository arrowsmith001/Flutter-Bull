import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_bull/extensions.dart';
import 'dart:math' as math;

class MovingGradient {
  MovingGradient({required this.colors,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  })
  {
    this.n = colors.length;
  }

  late int n;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  // // Interpolates based on t
  // LinearGradient getGradient(double t) {
  //
  //   final List<Color> colors1 = colors;
  //   final List<Color> colors2 = colors.loop(1);
  //
  //   final LinearGradient lg1 = new LinearGradient(colors: colors1);
  //   final LinearGradient lg2 = new LinearGradient(colors: colors2);
  //
  //   return LinearGradient.lerp(lg1, lg2, t)!;
  // }


  LinearGradient getGradient(double t) {

    List<Color> colors = [this.colors, this.colors].expand((element) => element).toList();
    int n = this.colors.length;
    int N = n*2;

    // TODO Make good

    List<double> stops = List.generate(colors.length, (i)
    {
      //t = 0;
      double lower = lerpDouble(n, 0, t)!;
      double upper = lerpDouble(N, n, t)!;

      if(i < lower.ceil()) return 0.0;
      if(i > upper.ceil()) return 1.0;
      //double tt = lerpDouble();

      double interval = upper - lower - 1;
      double d1 = (i - lower) / interval;

      double d = lerpDouble(0, 1, d1)!;
      //double d = lerpDouble(0, 1, t)!;
      //print('i ${i.toString()} d ${d.toString()} lower ${lower.toString()} upper ${upper.toString()}');
      return d;
    });

    return LinearGradient(
        begin: begin, end: end,
        colors: colors,
        stops: stops
    );

    // return LinearGradient(
    //     begin: begin, end: end,
    //     colors: colors,
    //     stops: [
    //       0,
    //       t > 4/6 ? 0.5 * ((t-(4/6)) / (2/6)) : 0,
    //       t > 2/6 ? (t-(2/6)) / (4/6) : 0,
    //       t < 4/6 ? (3/2)*t : 1,
    //       t < 2/6 ? 0.5 + 0.5*(3*t) : 1,
    //       1
    //     ]
    // );
  }

}

class PieClipper extends CustomClipper<Path> {

  PieClipper([this.t = 0.0]);
  final double t;

  @override
  getClip(Size size) {
    double h = size.height;
    double w = size.width;
    double r = 0.5*math.sqrt(math.pow(h, 2) + math.pow(w, 2));

    double h2 = h/2;
    double w2 = w/2;
    Offset center = new Offset(w2, h2);
    double angle = math.pi -t*math.pi*2;

    double x = center.dx + math.sin(angle)*r;
    double y = center.dy + math.cos(angle)*r;

    double xT = x.clamp(0, w);
    double yT = y.clamp(0, h);

    Path path = Path()..moveTo(center.dx, center.dy);
    path.lineTo(xT, yT);
    if(t < 0.25) path.lineTo(w, 0);
    if(t < 0.5) path.lineTo(w, h);
    if(t < 0.75) path.lineTo(0, h);
    path.lineTo(0, 0);
    path.lineTo(w2, 0);
    path.lineTo(center.dx, center.dy);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return (oldClipper as PieClipper).t != t;
  }

}
