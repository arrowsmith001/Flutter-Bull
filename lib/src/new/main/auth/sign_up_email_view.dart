import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/notifications/notification_view.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_event_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_back_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../mixins/auth_hooks.dart';
import '../../../widgets/notifications/static_recent_notification_center.dart';
import 'sign_up_control_bar.dart';

bool skipValidate = true;

class SignUpEmailView extends ConsumerStatefulWidget {
  const SignUpEmailView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpEmailViewState();
}

class _SignUpEmailViewState extends ConsumerState<SignUpEmailView>
    with Auth, MediaDimensions, AuthHooks {
  @override
  void initState() {
    super.initState();

    // ref.read(authNotifierProvider.notifier).setRoute('signUpEmail');
  }

  final _emailInputController = TextEditingController()
    ..text = "${Random().nextInt(100000)}@a.com";

  final _passwordInputController = TextEditingController()..text = "a" * 8;
  final _confirmPasswordInputController = TextEditingController()
    ..text = "a" * 8;

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String? errorMessage;

  final _notifKey = GlobalKey<StaticRecentNotificationCenterState>();

  void onSignUpFormValidation() async {
    final bool isValid = skipValidate || _formKey.currentState!.validate();

    if (!isValid) {
      ref
          .read(appStateNotifierProvider.notifier)
          .setSignUpPageState(SignUpPageState.invalid);
      return;
    }
    else
    {
      ref
          .read(appStateNotifierProvider.notifier)
          .setSignUpPageState(SignUpPageState.valid);
    }

    _notifKey.currentState?.dismiss();

    await auth.signUpWithEmailAndPassword(
        _emailInputController.text.trim(), _passwordInputController.text);

  }


  void onSignUpPageClosed() {
    if (mounted) {
          Navigator.of(context).pop();
        }
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    _confirmPasswordInputController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void onAuthError(String errorMessage) {
    Logger().d('onAuthError $errorMessage');
    setState(() {
      this.errorMessage = errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(
        appEventNotifierProvider
            .select((value) => value.valueOrNull?.newSignUpPageState), (_, next) {
      if (next == SignUpPageState.validating) {
        onSignUpFormValidation();
      }
    });

    ref.listen(
        appEventNotifierProvider
            .select((value) => value.valueOrNull?.newBusy),
        (_, next) {
      if (next == Busy.signingUp) {
        setState(() {
          errorMessage = null;
        });
      }
    });

    ref.listen(
        appEventNotifierProvider
            .select((value) => value.valueOrNull?.newNotBusy),
        (_, next) {
      if (next == Busy.signingUp && isSignedIn) {
        ref.read(appStateNotifierProvider.notifier).setSignUpPageState(SignUpPageState.closed);
      }
    });

    ref.listen(authNotifierProvider.select((value) => value.valueOrNull?.error),
        (_, next) {
      if (next != null) onAuthError(next.message);
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.125,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorDark),
                  child: Row(
                    children: [
                      Expanded(
                        child: Hero(
                            tag: 'signUpTitle',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.1,
                                  vertical: height * 0.025),
                              child: UglyOutlinedText(text: "Sign up"),
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Center(
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                                readOnly: isSigningUp,
                                                focusNode: _emailFocus,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                                maxLines: 1,
                                                errorText: state.errorText,
                                                controller:
                                                    _emailInputController);
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
                                      onTap: () =>
                                          _passwordFocus.requestFocus(),
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
                                                  _passwordInputController
                                                      .text),
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
                                                controller:
                                                    _passwordInputController);
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
                                          validator: (_) => InputValidators
                                              .stringMatchValidator(
                                                  _passwordInputController.text,
                                                  _confirmPasswordInputController
                                                      .text),
                                          builder: (state) {
                                            return UtterBullTextField(
                                                readOnly: isSigningUp,
                                                focusNode:
                                                    _confirmPasswordFocus,
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
                              )),

                          // Flexible(
                          //     child: Text(errorMessage!, style: TextStyle(color: Colors.red),),
                          //   )
                        ],
                      )),
                    )),
                // Flexible(
                //     child: Padding(
                //   padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                //   child: StaticRecentNotificationCenter(key: _notifKey),
                // )),
                SizedBox.fromSize(
                    size: Size(width, height * 0.1), child: SignUpControlBar())
              ],
            ),
          ),
          Positioned(
              bottom: height * 0.1,
              width: width * 0.9,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.025),
                child: StaticRecentNotificationCenter(key: _notifKey),
              ))
        ],
      ),
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
