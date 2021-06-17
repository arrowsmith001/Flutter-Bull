import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/extensions.dart';
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


  LinearGradient getGradient(double t) => LinearGradient(
    begin: begin, end: end,
      colors: <Color>[
        colors[0],
        colors[1],
        colors[2],
        colors[0],
        colors[1],
        colors[2]
      ],
      stops: [
        0,
        6*t > 4 ? 0.5 * ((t-(4/6)) / (2/6)) : 0,
        6*t > 2 ? (t-(2/6)) / (4/6) : 0,
        6*t < 4 ? (3/2)*t : 1,
        6*t < 2 ? 0.5 + 0.5*(3*t) : 1,
        1
      ]
  );

}

class PieClipper extends CustomClipper<Path> {

  PieClipper([this.t = 0]);
  double t;

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

    Path path = Path()..moveTo(center.dx, center.dy);
    double xT = x.clamp(0, w);
    double yT = y.clamp(0, h);

    // TODO: Is there a better way to do this?
    path.lineTo(xT, yT);
    if(t < 0.25) path.lineTo(w, 0);
    if(t < 0.5) path.lineTo(w, h);
    if(t < 0.75) path.lineTo(0, h);
    path.lineTo(0, 0);
    path.lineTo(w2, 0);
    path.lineTo(center.dx, center.dy);


      // path
      //   ..lineTo(0, h)
      //   ..lineTo(0, 0)
      //   ..lineTo(w2, 0)
      //   ..lineTo(center.dx, center.dy);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

}
