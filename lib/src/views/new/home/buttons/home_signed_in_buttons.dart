import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSignedInButtons extends ConsumerWidget {
  const HomeSignedInButtons({super.key});

  void onCreateRoom() {}

  void onJoinRoomPressed() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: UtterBullButton(onPressed: onCreateRoom, title: 'Create Game'),
        )),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child:
              UtterBullButton(onPressed: onJoinRoomPressed, title: 'Join Game'),
        )),
      ],
    );
  }
}
