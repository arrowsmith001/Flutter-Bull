import 'package:flutter/material.dart';

class PageSwitcherBuilder extends StatefulWidget {
  const PageSwitcherBuilder(
      {Key? key,
      required this.builder,
      this.duration = const Duration(milliseconds: 500),
      this.reverseDuration = const Duration(milliseconds: 500)})
      : super(key: key);
  final Duration duration;
  final Duration reverseDuration;
  final Widget Function(AnimationController controller) builder;

  @override
  State<PageSwitcherBuilder> createState() => _PageSwitcherBuilderState();
}

class _PageSwitcherBuilderState extends State<PageSwitcherBuilder>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    reverseDuration: widget.reverseDuration,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_controller);
  }
}

class PageSwitcherRoute extends PageRouteBuilder {
  PageSwitcherRoute({
    required this.controller,
    required Widget page,
  }) : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return page;
        }) {
    willDisposeAnimationController = false;
  }

  @override
  final AnimationController controller;

  @override
  AnimationController createAnimationController() {
    return controller;
  }
}