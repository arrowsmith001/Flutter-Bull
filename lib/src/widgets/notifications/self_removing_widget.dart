import 'dart:async';
import 'package:flutter/material.dart';

class SelfRemovingWidget<T> extends StatefulWidget {
  SelfRemovingWidget(
      {super.key,
      required this.child,
      required this.lifetime,
      required this.remove,
      required this.data});

  final Widget child;
  final Duration lifetime;
  final VoidCallback remove;
  final T data;

  @override
  State<SelfRemovingWidget> createState() => _SelfRemovingWidgetState();
}

class _SelfRemovingWidgetState<T> extends State<SelfRemovingWidget<T>> {
  late Timer t;

  @override
  void initState() {
    super.initState();
    t = Timer(widget.lifetime, () {
      widget.remove.call();
      t.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
