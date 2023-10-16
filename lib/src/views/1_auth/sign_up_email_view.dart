import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class SignUpEmailView extends ConsumerStatefulWidget {
  const SignUpEmailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpEmailViewState();
}

class _SignUpEmailViewState extends ConsumerState<SignUpEmailView>
    with Auth, MediaDimensions {
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();
  final _confirmPasswordInputController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  var _formKey = GlobalKey<FormState>();

  bool isSigningUp = false;

  void _onSignUp() async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      await auth.signUpWithEmailAndPassword(
          _emailInputController.text.trim(), _passwordInputController.text);
    } else {
      auth.setValidateSignUpForm(false);
    }
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    _confirmPasswordInputController.dispose();
    super.dispose();
  }

  void onAuthError(String errorMessage) {
    Logger().d('onAuthError $errorMessage');
    setState(() {
      this.errorMessage = errorMessage;
    });
  }

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.isSigningUp),
        (prev, next) {
      if (next != null) {
        setState(() {
          isSigningUp = next;
        });
      }
    });

    ref.listen(
        authNotifierProvider.select(
            (value) => value.valueOrNull?.isValidatingSigningUp), (prev, next) {
      if (next == true) {
        _onSignUp();
      }
    });

    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.errorMessage),
        (prev, next) {
      if (next != null) onAuthError(next);
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Hero(
                    tag: 'signUpTitle',
                    child: UglyOutlinedText(text: "Sign up"))),
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.1, vertical: 16.0),
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
                                            _emailInputController.text.trim()),
                                    builder: (state) {
                                      return UtterBullTextField(
                                          readOnly: isSigningUp,
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
                                  'Choose a password:',
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
                                        InputValidators.passwordValidator(
                                            _passwordInputController.text),
                                    builder: (state) {
                                      return UtterBullTextField(
                                          readOnly: isSigningUp,
                                          focusNode: _passwordFocus,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                          obscureText: true,
                                          maxLines: 1,
                                          errorText: state.errorText,
                                          controller: _passwordInputController);
                                    },
                                  ),
                                ),
                              )
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
                                onTap: () =>
                                    _confirmPasswordFocus.requestFocus(),
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
                                        InputValidators.stringMatchValidator(
                                            _passwordInputController.text,
                                            _confirmPasswordInputController
                                                .text),
                                    builder: (state) {
                                      return UtterBullTextField(
                                          readOnly: isSigningUp,
                                          focusNode: _confirmPasswordFocus,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                          obscureText: true,
                                          maxLines: 1,
                                          errorText: state.errorText,
                                          controller:
                                              _confirmPasswordInputController);
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
                  size: Size(width, height * 0.1), child: SignUpControlBar()),
            )
          ],
        ),
      )),
    );
  }

  // _buildBottomBarContents(BuildContext context) {
  //   if (isSigningUp)
  //     return Row(
  //       children: [
  //         SizedBox.fromSize(
  //             size: Size(100, 100),
  //             child: UtterBullCircularProgressIndicator()),
  //         Text("Signing you up...")
  //       ],
  //     );
  //   else
  //     return UtterBullButton(
  //                       title: 'Sign Up', onPressed: () => _onSignUp());
  // }
}

class SignUpControlBar extends ConsumerStatefulWidget {
  const SignUpControlBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpControlBarState();
}

class _SignUpControlBarState extends ConsumerState<SignUpControlBar> {
  void onExitSignUp() {
    ref.read(authNotifierProvider.notifier).onExitSignUp();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
      child: Row(children: [
        IconButton(
            onPressed: () => onExitSignUp(),
            icon: Icon(Icons.exit_to_app_sharp)),
        UtterBullButton(
            color: Theme.of(context).primaryColorDark,
            onPressed: () {},
            title: 'Let\'s go!')
      ]),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({required this.child, super.key, this.height});
  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final main = ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );

    if (height == null) return child;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [Expanded(child: SizedBox(height: height, child: main))],
        )
      ],
    );
  }
}
