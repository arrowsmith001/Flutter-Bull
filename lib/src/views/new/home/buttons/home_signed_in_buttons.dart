import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSignedInButtons extends ConsumerStatefulWidget {
  const HomeSignedInButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeSignedInButtonsState();
}

class _HomeSignedInButtonsState extends ConsumerState<HomeSignedInButtons> {

  void onJoinRoomPressed() {}

  void onCreateRoomPressed() {
    final userId = ref.read(authNotifierProvider).valueOrNull?.userId;
    ref.read(authNotifierProvider.notifier).createRoom(userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: UtterBullButton(
              isShimmering: false,
              onPressed: onCreateRoomPressed,
              title: 'Create Game'),
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
