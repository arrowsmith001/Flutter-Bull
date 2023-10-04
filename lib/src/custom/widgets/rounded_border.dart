import 'package:flutter/material.dart';

class RoundedBorder extends StatelessWidget {
  const RoundedBorder({
    required this.child,
    this.background,
    this.color,
    this.thickness,
    super.key,
  });

  final Widget child;
  final Widget? background;
  final Color? color;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    final Widget child0 = ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        color: color ?? Colors.white.withAlpha(100),
        child: Padding(
          padding: EdgeInsets.all(thickness ?? 4.0),
          child: child,
        ),
      ),
    );

    if (background != null) {
      return Stack(
        children: [
          Positioned.fill(child: background!),
          child
        ],
      );
    }

    return child0;
  }
}
