import 'package:flutter/material.dart';

class RoundedBorder extends StatelessWidget {
  const RoundedBorder({
    required this.child,
    this.background,
    this.color,
    this.thickness = 4.0,
    this.radius = 12.0,
    super.key,
  });

  final Widget child;
  final Widget? background;
  final Color? color;
  final double thickness;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        color: color ?? Colors.white.withAlpha(200),
        child: Padding(
          padding: EdgeInsets.all(thickness),
          child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),

            child: Stack(
              children: [
                Positioned.fill(child: background ?? const SizedBox.shrink()),
                child
              ],
            ),
          ),
        ),
      ),
    );
  }
}
