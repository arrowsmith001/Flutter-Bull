import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter_bull/extensions.dart';
import 'package:flutter_bull/utilities/interpolators.dart';

class AnimatedVoterAvatar extends StatefulWidget {

  AnimatedVoterAvatar(this.avatar, this.v);
  final Widget avatar;
  final double v;

  final OvershootInterpolator osInterp = new OvershootInterpolator(2);

  @override
  _AnimatedVoterAvatarState createState() => _AnimatedVoterAvatarState();
}

class _AnimatedVoterAvatarState extends State<AnimatedVoterAvatar> {


  @override
  Widget build(BuildContext context) {

    Widget avatar = widget.avatar;
    double v = widget.v;
    var pi = math.pi;

    double t_scale = v < 0.25 ? math.sin(2 * v * pi) : v < 0.75 ? 1 : math.sin(2 * (v-0.5) * pi);
    double t_rot = v < 0.25 ? 0 : v < 0.75 ? math.sin(4 * (v - 0.25) * pi) : 0;

    // TODO Make animation good

    return avatar
        .ScaleExt(1 + widget.osInterp.getValue(t_scale))
        .RotateExt(math.pi * 0.3 * t_rot, new Offset(0, 15))
        .TranslateExt(dx: t_rot * 25);
  }
}
