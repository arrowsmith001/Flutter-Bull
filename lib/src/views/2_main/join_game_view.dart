import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bull/src/notifiers/signed_in_player_status_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Execute join game etc  

class JoinGameView extends ConsumerStatefulWidget {
  const JoinGameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinGameViewState();
}

class _JoinGameViewState extends ConsumerState<JoinGameView> with UserID {
  final TextEditingController _textEditController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GameCodeValidator validator = GameCodeValidator();

  @override
  void initState() {
    super.initState();
    _textEditController.addListener(() {
      setState(() {});
    });
    _focusNode.requestFocus();
  }


  void _onJoinGame() {
    
      ref.read(authNotifierProvider.notifier)
        .joinRoom(userId!, _textEditController.text.trim().toUpperCase());
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fromRect(
            rect: const Rect.fromLTWH(0, 0, 100, 100),
            child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop())),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText('Enter Game Code:',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.displayMedium),
              UtterBullTextField(
                  controller: _textEditController,
                  focusNode: _focusNode,
                  maxLength: 5,
                  inputFormatters: [
                    TextInputFormatter.withFunction((_, newValue) =>
                        TextEditingValue(
                            text: newValue.text.toUpperCase(),
                            selection: newValue.selection))
                  ]),
              UtterBullButton(
                  title: 'Join',
                  onPressed: validator.validate(_textEditController.text)
                      ? () => _onJoinGame()
                      : null)
            ],
          ),
        ),
      ],
    );
  }
}

class GameCodeValidator {
  final RegExp regex = RegExp('^[A-Z]{3}\\d{2}\$');

  bool validate(String code) {
    return regex.hasMatch(code);
  }
}
