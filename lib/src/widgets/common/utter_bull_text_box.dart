import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UtterBullTextBox extends StatelessWidget {
  final String text;
  final EdgeInsets padding;

  const UtterBullTextBox(this.text, {this.padding = const EdgeInsets.all(8.0), super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: padding,
        child: Center(
            child: AutoSizeText(
          text,
          style: Theme.of(context).textTheme.displayLarge,
        )),
      ),
    );
  }
}
