import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation.dart';
import 'package:flutter/src/widgets/framework.dart';

class SwapRoute extends CoordinatedPageRoute {
  SwapRoute(super.builder)
      : super(transitionDuration: const Duration(milliseconds: 350));

  final curve = Curves.bounceInOut;

  final offset = const Offset(0, -0.25);
  final reverse = Tween(begin: 1.0, end: 0.0);

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {

    final Tween<Offset> offsetTween = Tween(begin: offset, end: Offset.zero);
    final CurvedAnimation curvedAnim =
        CurvedAnimation(parent: animation, curve: curve);

    return FadeTransition(
      opacity: animation,
      child:
          SlideTransition(position: curvedAnim.drive(offsetTween), child: child),
    );
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    final Tween<Offset> offsetTween = Tween(begin: Offset.zero, end: offset);
    final CurvedAnimation curvedAnim =
        CurvedAnimation(parent: animation, curve: curve);

    return FadeTransition(
      opacity: animation.drive(reverse),
      child:
          SlideTransition(position: curvedAnim.drive(offsetTween), child: child),
    );
  }
}
