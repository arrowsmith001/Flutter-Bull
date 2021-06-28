
import 'dart:math';

import 'package:flutter/animation.dart';

// TODO Migrate to "Curves"


// For animations that go slightly beyond the final threshold, then back
class OvershootCurve extends Curve{
  OvershootCurve([this.T = 1]);
  final double T;

  @override
  double transform(double t) {
    return (T+1) * pow(t-1,3) + T * pow(t-1,2) + 1;
  }
}


// For animations that go slightly behind the initial value, then forward
class AnticipateCurve extends Curve{
  AnticipateCurve([this.T = 1]);
  final double T;

  @override
  double transform(double t) {
    return (T+1) * pow(t,3) - T * pow(t,2);
  }
}

// For animations that go slightly behind the initial value and slightly beyond the final threshold
class AnticipateOvershootCurve extends Curve{
  AnticipateOvershootCurve([this.T = 1]);
  final double T;

  @override
  double transform(double t) {
    if(t<0.5) return 0.5*((T+1)*pow(2*t,3)-T*(pow(2*t,2)));
    return 0.5*((T+1)*pow(2*t-2,3)+T*(pow(2*t-2,2))) + 1;
  }
}

// For animations that want a "bounce" effect
class BounceCurve extends Curve{
  const BounceCurve();

  @override
  double transform(double t) {
    if(t<0.31489) return 8*pow(1.1226*t,2).toDouble();
    if(t<0.65990) return 8*pow(1.1226*t - 0.54719, 2) + 0.7;
    if(t<0.85908) return 8*pow(1.1226*t - 0.8526, 2) + 0.9;
    return 8*pow(1.1226*t - 1.0435, 2) + 0.95;
  }
}

// For animations than slow down towards the end
class DecelerateCurve extends Curve{
  const DecelerateCurve([this.T=1]);
  final double T;

  @override
  double transform(double t) {
    return (1 - pow(1-t, 2*T)).toDouble();
  }
}

// For animations that want to jump and then return as a bounce
class JumpThenBounceCurve extends Curve{

  const JumpThenBounceCurve();
  final Curve decel = const DecelerateCurve();
  final Curve bounce = const BounceCurve();

  @override
  double transform(double t) {
    if(t < 0.5) return decel.transform(2*t);
    return 1-bounce.transform(2*(t-0.5));
  }
}


class SinCurve extends Curve{

  const SinCurve({this.factor = 1.0, this.offset = 0.0, this.amp = 1.0, this.abs = false});
  final double factor;
  final double offset;
  final double amp;
  final bool abs;
  @override
  double transform(double t) {
    double d = amp*sin(2*pi*(t*(1/factor) + offset));
    if(!abs) return d;
    return max(0.0, d);
  }
}