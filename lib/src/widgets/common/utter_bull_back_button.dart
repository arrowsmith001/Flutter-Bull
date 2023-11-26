import 'package:flutter/material.dart';

class UtterBullBackButton extends StatelessWidget {
  const UtterBullBackButton(
      {super.key, this.onPressed, this.color = Colors.blue});

  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: color,
        shape: const CircleBorder(),
      ),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.exit_to_app_sharp,
            color: Theme.of(context).primaryColorLight,
          )),
    );
  }
}
