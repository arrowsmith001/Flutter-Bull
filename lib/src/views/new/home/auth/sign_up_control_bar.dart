import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_back_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class SignUpControlBar extends ConsumerStatefulWidget {
  const SignUpControlBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpControlBarState();
}

class _SignUpControlBarState extends ConsumerState<SignUpControlBar> {

  void onExitSignUp() {
    ref.read(appNotifierProvider.notifier).setSignUpPageState(SignUpPageState.closed);
  }

  void onValidateSignUpForm() {
    ref.read(appNotifierProvider.notifier).setSignUpPageState(SignUpPageState.validating);
  }

  bool get isSigningUp =>
      ref.watch(appNotifierProvider).valueOrNull?.busyWith.contains(Busy.signingUp) ?? false;

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
                  isSigningUp ? UtterBullCircularProgressIndicator() : null,
              color: Theme.of(context).primaryColorDark,
              onPressed: isSigningUp ? null : () => onValidateSignUpForm(),
              title: isSigningUp ? 'Signing up' : 'Let\'s go!'),
        )
      ]),
    );
  }
}
