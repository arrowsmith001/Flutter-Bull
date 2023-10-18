import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/new/auth_notifier.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
