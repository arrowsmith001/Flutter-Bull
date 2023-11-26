import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/assets.gen.dart';

class UtterBullCircularProgressIndicator extends StatefulWidget {
  final Size? size;
  const UtterBullCircularProgressIndicator({super.key, this.size});
  @override
  State<UtterBullCircularProgressIndicator> createState() =>
      _UtterBullCircularProgressIndicatorState();
}

class _UtterBullCircularProgressIndicatorState
    extends State<UtterBullCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController animController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1250));
  late Animation<double> anim =
      CurvedAnimation(parent: animController, curve: Curves.elasticInOut);

  @override
  void initState() {
    super.initState();
    animController.repeat();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(size: widget.size,
      child: AnimatedBuilder(
        animation: anim,
        builder: (_, child) => Transform.rotate(
          angle: anim.value * pi,
          child: child,
        ),
        child: AspectRatio(
            aspectRatio: 1, child: Image.asset(Assets.images.loading.path)),
      ),
    );
  }
}
