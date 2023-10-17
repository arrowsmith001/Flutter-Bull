import 'package:flutter/material.dart';

class UtterBullBackButton extends StatelessWidget {
  const UtterBullBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {

    return Ink(
  decoration: ShapeDecoration(
    color: Colors.blue,
    shape: CircleBorder(),
  ),
  child: IconButton(onPressed: onPressed,
            icon: Icon(
              Icons.exit_to_app_sharp, color: Theme.of(context).primaryColorLight,)),
);
  }
}
