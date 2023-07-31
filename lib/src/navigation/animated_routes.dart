import 'package:flutter/material.dart';

abstract class SlideRoute extends PageRouteBuilder {
  SlideRoute(this.child) : super(pageBuilder: (context, _, __) => child);

  final Widget child;

  Offset get getInitialOffset;


  Offset? exitOffset;

  @override
  RoutePageBuilder get pageBuilder => (context, animation, secondaryAnimation) 
  {
    const begin = Offset.zero;

    // TODO: Make exit appropriate - based off previous
    var end = getInitialOffset;

    final tween = Tween(begin: begin, end: end);

    final curved = CurvedAnimation(
        parent: secondaryAnimation, curve: Curves.easeInOut);
    final offsetAnimation = curved.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  };

  @override
  RouteTransitionsBuilder get transitionsBuilder =>
      ((context, animation, secondaryAnimation, child) {
        var begin = getInitialOffset;
        const end = Offset.zero;

        final tween = Tween(begin: begin, end: end);

        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        final offsetAnimation = curved.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

class BackwardRoute extends SlideRoute {
  BackwardRoute(Widget child) : super(child);

  @override
  Offset get getInitialOffset => Offset(-1.0, 0.0);
}

class ForwardRoute extends SlideRoute {
  ForwardRoute(Widget child) : super(child);

  @override
  Offset get getInitialOffset => Offset(1.0, 0.0);
}

class UpwardRoute extends SlideRoute {
  UpwardRoute(Widget child) : super(child);

  @override
  Offset get getInitialOffset => Offset(0.0, 1.0);
}

class DownwardRoute extends SlideRoute {
  DownwardRoute(Widget child) : super(child);

  @override
  Offset get getInitialOffset => Offset(0.0, -1.0);
}
