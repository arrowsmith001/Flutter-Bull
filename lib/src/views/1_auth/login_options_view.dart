import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_single_option_dismissable_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginOptionsView extends ConsumerStatefulWidget {
  const LoginOptionsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginOptionsViewState();
}

class _LoginOptionsViewState extends ConsumerState<LoginOptionsView>
    with MediaDimensions {
  static const double buttonPadding = 16.0;

  AuthNotifier get authNotifier => ref.read(authNotifierProvider.notifier);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    'New to the Utter Bull?',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: UtterBullButton(
                          title: "Sign up",
                          onPressed: () => _onSignUpWithEmail()),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                      child: UtterBullButton(
                          isShimmering: false,
                          title: "Sign in",
                          onPressed: () => _onSignUpWithEmail()),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text(
                    'Just want to get playing ASAP?',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.175),
                      child: UtterBullButton(
                          isShimmering: false,
                          title: "Continue as guest",
                          onPressed: () => _onContinueAsGuest()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      
      ],
    );
  }

  void _onSignUpWithEmail() {
    //ref.read(authNotifierProvider.notifier).setRoute('signUpEmail');
  }

  Widget _buildGoogleButton() {
    return Padding(
      padding: const EdgeInsets.all(buttonPadding),
      child: UtterBullButton(
          title: "Sign up with Google",
          onPressed: null, // () => _onSignUpWithGoogle(),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.images.google.image(),
          )),
    );
  }

  void _onSignUpWithGoogle() {}

  Future<void> _onContinueAsGuest() async {
    await authNotifier.signIn();
  }

  void _onSignUpExplanationPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const UtterBullSingleOptionDismissableDialog(
            message: 'Utter Bull requires an account for players to identify and interact with one another.\n\nAfter creating an account, all content you produce in the game is associated with an anonymized player profile.\n\nWe do not actively collect or store the data produced by your interactions with this application for purposes beyond game functionality.'));
  }
}
