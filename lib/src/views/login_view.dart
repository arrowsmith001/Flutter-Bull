import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {

    final authNotifier = ref.watch(authNotifierProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () => authNotifier.signIn(), child: Text('Sign in'))
/*         TextButton(
            onPressed: () => authNotifier.signUp(),
            child: Text('Continue as guest')) */
      ],
    );
  }
}
