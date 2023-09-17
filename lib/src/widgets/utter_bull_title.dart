import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';

class UtterBullTitle extends StatelessWidget {
  const UtterBullTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UglyOutlinedText(
      'Utter Bull',
      outlineColor: const Color.fromARGB(255, 112, 112, 112) // Theme.of(context).colorScheme.primary,
    );
  }
}