import 'package:flutter/material.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_back_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpControlBar extends ConsumerStatefulWidget {
  const SignUpControlBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpControlBarState();
}

class _SignUpControlBarState extends ConsumerState<SignUpControlBar> {

  void onExitSignUp() {
    ref.read(appStateNotifierProvider.notifier).setSignUpPageState(SignUpPageState.closed);
  }

  void onValidateSignUpForm() {
    ref.read(appStateNotifierProvider.notifier).setSignUpPageState(SignUpPageState.validating);
  }

  bool get isSigningUp =>
      ref.watch(appStateNotifierProvider).valueOrNull?.busyWith.contains(Busy.signingUp) ?? false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: UtterBullBackButton(onPressed: () => onExitSignUp()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: UtterBullButton(
              leading:
                  isSigningUp ? const UtterBullCircularProgressIndicator() : null,
              color: Theme.of(context).primaryColorDark,
              onPressed: isSigningUp ? null : () => onValidateSignUpForm(),
              title: isSigningUp ? 'Signing up' : 'Let\'s go!'),
        )
      ]),
    );
  }
}
