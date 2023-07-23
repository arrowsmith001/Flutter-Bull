import 'package:flutter/material.dart';

class RowOfN<T> extends StatelessWidget {
  final Widget? child;
  final int length;

  final List<T>? data;
  final Widget Function(Widget?, T)? transform;

  RowOfN({super.key, this.length = 1, this.transform, this.child, this.data}) {
    assert(transform != null || child != null);
    assert(transform == null || 
    (data != null && length == data!.length));
  }

  @override
  Widget build(BuildContext context) {
    
    bool isTransform = transform != null;
    bool isChild = child != null;

    bool isTransformableChild = isTransform && isChild;

    return Row(
        children: List.generate(
            length,
            (i) => Flexible(
                child:
                    isTransformableChild || isTransform ? transform!(child, data![i]) 
                      : child!)));
  }
}