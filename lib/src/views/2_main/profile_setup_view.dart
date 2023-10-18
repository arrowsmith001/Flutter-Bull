import 'dart:html';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/camera_service.dart';
import 'package:flutter_bull/src/views/2_main/change_avatar_view.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dart:html' as html;

// TODO: Profile setup: name, photo (sequential)
// TODO: Forbid entering newline in name

class ProfileSetupView extends ConsumerStatefulWidget {
  const ProfileSetupView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileSetupViewState();
}

class _ProfileSetupViewState extends ConsumerState<ProfileSetupView>
    with UserID {
  final _nameInputController = TextEditingController();

  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final asyncPlayer = ref.watch(playerNotifierProvider(userId));

    ref.listen(
        playerNotifierProvider(userId)
            .select((value) => value.value?.player.name), (_, next) {
      if (next != null) {
        _nameInputController.text = next;
      }
    });

    var setUpProfileHeader =
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        "Set up your profile",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    ]);

    var nameEntry = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Enter your name:',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: FormField(
              key: _formFieldKey,
              validator: (_) =>
                  InputValidators.nameValidator(_nameInputController.text),
              builder: (state) {
                return UtterBullTextField(
                    errorText: state.errorText,
                    maxLength: 20,
                    controller: _nameInputController);
              },
            ),
          ),
        ),
        Flexible(
          child: SizedBox(
            width: 200,
            child: UtterBullButton(
                title: 'Confirm', onPressed: () => _onSetName()),
          ),
        ),
      ],
    );

    var photoEntry = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Set display picture (optional):',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Flexible(
            child: Hero(
          tag: 'avatar',
          child: GestureDetector(
              onTap: () => _onPress(context),
              child: asyncPlayer.whenDefault((data) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: UtterBullPlayerAvatar(null, data.avatarData!),
                  ))),
        )),
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const Spacer(flex: 1,),
          Flexible(
            flex: 1,
            child: setUpProfileHeader,
          ),
          Flexible(flex: 2, child: nameEntry),
          Flexible(flex: 2, child: photoEntry),
        ],
      ),
    );
  }

  Future<void> _onSetName() async {
    bool isValid = _formFieldKey.currentState?.validate() ?? false;
    if (isValid) {
      return ref
          .read(playerNotifierProvider(userId).notifier)
          .setName(_nameInputController.text);
    }
  }

  bool hasPermission = false;

  CameraService get camService => CameraService();

  Future<void> _onPress(BuildContext context) async {
    final navigator = Navigator.of(context);

    if (await camService.isPermissionGranted) {
      //if (!camService.isCameraControllerInitialized) {
      await camService.initialize();
      final success = await camService.createController();
      //}
      Logger().d(success);

      if (success) {
        await navigator.push(MaterialPageRoute(
            builder: (context) => ChangeAvatarView(camService)));

        await camService.dispose();
      }
    }
  }
}

class InputValidators {
  static String? nameValidator(String s) {
    return emptyValidator(s);
  }

  static String? emptyValidator(String s) {
    return s.trim() == "" ? "Name cannot be blank" : null;
  }

  static String? emailValidator(String text) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);

    if (text == "utterbullfan@gmail.com") {
      return "Delighted to meet you, fellow fan, but we need your actual email address :)";
    }

    return emailValid
        ? null
        : 'Please enter a valid email address i.e. utterbullfan@gmail.com';
  }

  static String? stringMatchValidator(String s1, String s2) {
    if (s1 != s2) {
      return "Passwords much match";
    }

    return null;
  }

  static String? passwordValidator(String password) {
    if (password.length < 8)
      return 'Password must be at least 8 characters long';

    if (password.contains(' ')) return 'Password must not contain whitespace';

    return null;
  }

  static String? nonEmptyStringValidator(String text) {
    return text.trim().isNotEmpty ? null : "Name field must not be empty";
  }
}
