import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({required this.child, super.key, this.height});
  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final main = ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );

    if (height == null) return child;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [Expanded(child: SizedBox(height: height, child: main))],
        )
      ],
    );
  }
}
