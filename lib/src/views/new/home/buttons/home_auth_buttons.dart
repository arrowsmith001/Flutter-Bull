import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/new/home/auth/login_dialog.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool unavailable = false;

class HomeAuthButtons extends ConsumerWidget {
  const HomeAuthButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onLoginPressed() async {
      ref.read(authNotifierProvider.notifier).setRoute('login');
      await showDialog(
        
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: const Dialog(
                  
                  backgroundColor: Color.fromARGB(0, 255, 255, 255),
                  shadowColor: Color.fromARGB(0, 255, 255, 255),
                  child: LoginDialog(),
                ));
          });
      ref.read(authNotifierProvider.notifier).setRoute('/');
    }

    void onSignUpPressed(WidgetRef ref) {
      ref.read(authNotifierProvider.notifier).onSignUpPage();
    }

    if (unavailable)
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Utter Bull is down for maintenance",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32),
            ),
          )
        ],
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: UtterBullButton(
              maxHeight: 80,
              isShimmering: false,
              onPressed: unavailable ? null : () => onLoginPressed(),
              title: 'Login'),
        )),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Hero(
            tag: "signUpTitle",
            child: UtterBullButton(
                onPressed: unavailable ? null : () => onSignUpPressed(ref),
                title: 'Sign Up'),
          ),
        )),
      ],
    );
  }
}
