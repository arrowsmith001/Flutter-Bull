import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/home/auth_notifier.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeMainButtons extends ConsumerStatefulWidget {
  const HomeMainButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeMainButtonsState();
}

class _HomeMainButtonsState extends ConsumerState<HomeMainButtons> {
  @override
  Widget build(BuildContext context) {
    return HomeAuthButtons();
  }
}

class HomeAuthButtons extends ConsumerWidget {
  const HomeAuthButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onLoginPressed() {}

    void onSignUpPressed(WidgetRef ref) {
      ref.read(authNotifierProvider.notifier).onSignUpPage();

    }

    return Column(
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: UtterBullButton(onPressed: onLoginPressed, title: 'Login'),
        )),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Hero(
            tag: "signUpTitle",
            child: UtterBullButton(
                onPressed: () => onSignUpPressed(ref), title: 'Sign Up'),
          ),
        )),
      ],
    );
  }
}

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
