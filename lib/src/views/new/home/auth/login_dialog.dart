import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_back_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LoginDialog>
    with MediaDimensions {
  final _formKey = GlobalKey<FormState>();

  final _emailInputController =
      TextEditingController(text: 'example@gmail.com');
  final _passwordController = TextEditingController(text: 'a' * 8);
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool isLoggingIn = false;

  void onValidateLoginForm() async {
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
        setState(() {
      if (mounted) isLoggingIn = true;
    });

      await ref.read(authNotifierProvider.notifier).signInWithEmailAndPassword(
          _emailInputController.text.trim(), _passwordController.text);
        setState(() {
      if (mounted) isLoggingIn = false;
    });
  }

  void onExitLogin() {
    if (mounted) Navigator.of(context).maybePop();
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.authState),
        (prev, next) {
      if (prev == AuthState.signedOut && next != AuthState.signedOut) {
        if (mounted) Navigator.of(context).pop();
      }
    });

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(24.0)),
      height: height * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Center(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark),
                      child: Hero(
                          tag: 'loginTitle',
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1,
                                vertical: height * 0.015),
                            child: UglyOutlinedText(text: "LOGIN"),
                          )),
                    ),
                  ),
                ],
              )),
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1, vertical: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () => _emailFocus.requestFocus(),
                                  child: AutoSizeText(
                                    'Enter your email address:',
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FormField(
                                      validator: (_) =>
                                          InputValidators.emailValidator(
                                              _emailInputController.text
                                                  .trim()),
                                      builder: (state) {
                                        return UtterBullTextField(
                                            readOnly: isLoggingIn,
                                            focusNode: _emailFocus,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                            maxLines: 1,
                                            errorText: state.errorText,
                                            controller: _emailInputController);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.1, vertical: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () => _passwordFocus.requestFocus(),
                                  child: AutoSizeText(
                                    'Confirm password:',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FormField(
                                      validator: (_) =>
                                          InputValidators.passwordValidator(
                                              _passwordController.text),
                                      builder: (state) {
                                        return UtterBullTextField(
                                            readOnly: isLoggingIn,
                                            focusNode: _passwordFocus,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                            obscureText: true,
                                            maxLines: 1,
                                            errorText: state.errorText,
                                            controller: _passwordController);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  )),
              Flexible(
                child: SizedBox.fromSize(
                    size: Size(width, height * 0.1),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UtterBullBackButton(
                                  onPressed: () => onExitLogin()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UtterBullButton(
                                  leading: isLoggingIn
                                      ? UtterBullCircularProgressIndicator()
                                      : null,
                                  color: Theme.of(context).primaryColorDark,
                                  onPressed: isLoggingIn
                                      ? null
                                      : () => onValidateLoginForm(),
                                  title: isLoggingIn
                                      ? 'Logging in'
                                      : 'Login'),
                            )
                          ]),
                    )),
              )
            ],
          ),
        )),
      ),
    );
  }
}
