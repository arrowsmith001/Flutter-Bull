import 'package:flutter/material.dart';

class ConditionalOverlay extends StatelessWidget {
  const ConditionalOverlay(
      {super.key, required this.child, required this.isActive});
  final Widget child;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(opacity: isActive ? 0.7 : 1, child: child),
        isActive
            ? Positioned.fill(
                child: Container(color: Colors.grey.withAlpha(100)))
            : const SizedBox.shrink()
      ],
    );
  }
}
