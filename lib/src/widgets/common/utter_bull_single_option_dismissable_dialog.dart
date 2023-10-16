import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';

class UtterBullSingleOptionDismissableDialog extends StatelessWidget {
  const UtterBullSingleOptionDismissableDialog(
      {super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            Flexible(flex: 2,
                  child: UtterBullTextBox(message)),
            UtterBullButton(
                title: 'OK',
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
