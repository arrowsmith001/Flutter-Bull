import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/views/new/notification_center.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/state_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/app_state.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_back_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class LoginDialog extends ConsumerStatefulWidget {
  const LoginDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LoginDialog>
    with MediaDimensions {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _notifKey = GlobalKey<StaticRecentNotificationCenterState>();

  final _emailInputController = TextEditingController()..text = "a@a.a";
  final _passwordController = TextEditingController()..text = "a" * 8;
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  void setIsLoggingIn(bool isLoggingIn) {
    if (mounted) {
      setState(() {
        //this.isLoggingIn = isLoggingIn;
      });
    }
  }

  void onValidateLoginForm() async {
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setIsLoggingIn(true);

    _notifKey.currentState?.dismiss();

    await ref.read(authNotifierProvider.notifier).signInWithEmailAndPassword(
        _emailInputController.text.trim(), _passwordController.text);

    setIsLoggingIn(false);
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
        if (ModalRoute.of(context)?.isCurrent ?? false)
          Navigator.of(context).pop();
      }
    });

    final title = Container(
      height: height * 0.125,
      decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
      child: Hero(
          tag: 'loginTitle',
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.015),
            child: UglyOutlinedText(text: "LOGIN"),
          )),
    );

    final email = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _emailFocus.requestFocus(),
          child: AutoSizeText(
            'Email address:',
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FormField(
              validator: (_) => InputValidators.emailValidator(
                  _emailInputController.text.trim()),
              builder: (state) {
                return ref.watch(stateNotifierProvider).whenDefault((app) {
                  
                  bool isLoggingIn = app.busyWith.contains(Busies.loggingIn);

                  return UtterBullTextField(
                      readOnly: isLoggingIn,
                      focusNode: _emailFocus,
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 1,
                      errorText: state.errorText,
                      controller: _emailInputController);
                });
              },
            ),
          ),
        ),
      ],
    );

    final password = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _passwordFocus.requestFocus(),
          child: AutoSizeText(
            'Password:',
            maxLines: 1,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FormField(
              validator: (_) =>
                  InputValidators.passwordValidator(_passwordController.text),
              builder: (state) {
                return ref.watch(stateNotifierProvider).whenDefault((app) {
                  bool isLoggingIn = app.busyWith.contains(Busies.loggingIn);

                  return UtterBullTextField(
                      readOnly: isLoggingIn,
                      focusNode: _passwordFocus,
                      style: Theme.of(context).textTheme.headlineMedium,
                      obscureText: true,
                      maxLines: 1,
                      errorText: state.errorText,
                      controller: _passwordController);
                });
              },
            ),
          ),
        ),
      ],
    );

    final bottomControls = SizedBox.fromSize(
        size: Size(width, height * 0.1),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UtterBullBackButton(onPressed: () => onExitLogin()),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ref.watch(stateNotifierProvider).whenDefault((app) {
                  bool isLoggingIn = app.busyWith.contains(Busies.loggingIn);

                  return UtterBullButton(
                      leading: isLoggingIn
                          ? UtterBullCircularProgressIndicator()
                          : null,
                      color: Theme.of(context).primaryColorDark,
                      onPressed:
                          isLoggingIn ? null : () => onValidateLoginForm(),
                      title: isLoggingIn ? 'Logging in' : 'Login');
                })),
          ]),
        ));

    return Form(
      key: _formKey,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(24.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: title,
                  ),
                ],
              ),
              Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: 12.0),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Flexible(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: email,
                              )),
                          Flexible(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: password,
                              )),
                        ])),
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
                child: StaticRecentNotificationCenter(key: _notifKey),
              ),
              bottomControls,
            ],
          ),
        ),
      ),
    );
  }
}
