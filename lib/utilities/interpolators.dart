import 'dart:math';

// Class for interpolating values for animations. They should expect values of t between 0 and 1.
abstract class Interpolator{
  double getValue(double t);

  static double clamp01(double d) {
    return d < 0.0 ? 0.0 : d > 1.0 ? 1.0 : d;
  }
}

// For animations that go slightly beyond the final threshold, then back
class OvershootInterpolator extends Interpolator{
  OvershootInterpolator([this.T = 1]);
  double T;

  @override
  double getValue(double t) {
    return (T+1) * pow(t-1,3) + T * pow(t-1,2) + 1;
  }
}

// For animations that go slightly behind the initial value, then forward
class AnticipateInterpolator extends Interpolator{
  AnticipateInterpolator([this.T = 1]);
  double T;

  @override
  double getValue(double t) {
    return (T+1) * pow(t,3) - T * pow(t,2);
  }
}

// For animations that go slightly behind the initial value and slightly beyond the final threshold
class AnticipateOvershootInterpolator extends Interpolator{
  AnticipateOvershootInterpolator([this.T = 1]);
  double T;

  @override
  double getValue(double t) {
    if(t<0.5) return 0.5*((T+1)*pow(2*t,3)-T*(pow(2*t,2)));
    return 0.5*((T+1)*pow(2*t-2,3)+T*(pow(2*t-2,2))) + 1;
  }
}

// For animations that want a "bounce" effect
class BounceInterpolator extends Interpolator{
  BounceInterpolator();

  @override
  double getValue(double t) {
    if(t<0.31489) return 8*pow(1.1226*t,2).toDouble();
    if(t<0.65990) return 8*pow(1.1226*t - 0.54719, 2) + 0.7;
    if(t<0.85908) return 8*pow(1.1226*t - 0.8526, 2) + 0.9;
    return 8*pow(1.1226*t - 1.0435, 2) + 0.95;
  }
}

// For animations than slow down towards the end
class DecelerateInterpolator extends Interpolator{
  DecelerateInterpolator([this.T=1]);
  double T;

  @override
  double getValue(double t) {
    return (1 - pow(1-t, 2*T)).toDouble();
  }
}

// For animations that want to jump and then return as a bounce
class JumpThenBounceInterpolator extends Interpolator{

  JumpThenBounceInterpolator();
  Interpolator decel = new DecelerateInterpolator();
  Interpolator bounce = new BounceInterpolator();

  @override
  double getValue(double t) {
    if(t < 0.5) return decel.getValue(2*t);
    return 1-bounce.getValue(2*(t-0.5));
  }
}