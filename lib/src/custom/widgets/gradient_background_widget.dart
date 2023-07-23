import 'package:flutter/material.dart';

class GradientBackgroundWidget extends StatelessWidget {
  const GradientBackgroundWidget({super.key, this.child, required this.theme});
  final Widget? child;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
     return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              focalRadius: 20.0,
              colors: [theme.shadowColor, theme.colorScheme.background],
              stops: [0, 0.75])),
     
          child: child,
        );
  }
}