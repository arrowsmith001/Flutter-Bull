import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/mixins/app_hooks.dart';
import 'package:flutter_bull/src/mixins/auth_hooks.dart';
import 'package:flutter_bull/src/mixins/game_hooks.dart';
import 'package:flutter_bull/src/notifiers/view_models/writing_phase_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/3_game/1_writing_phase_view_model.dart';
import 'package:flutter_bull/src/widgets/common/loading_message.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WritingPhaseView extends ConsumerStatefulWidget {
  const WritingPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WritingPhaseViewState();
}

class _WritingPhaseViewState extends ConsumerState<WritingPhaseView>
    with GameHooks, AppHooks {

  UtterBullServer get _getServer => ref.read(utterBullServerProvider);

  final TextEditingController _submissionController = TextEditingController();
  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  Future<void> _onSubmitText() async {
    if (_submissionController.text.isEmpty) {
      _focusNode.requestFocus();
      return;
    }

    await game.submitText(userId!, _submissionController.text);

    setState(() {
      _focusNode.canRequestFocus = true;
    });
  }

  Future<void> _onWithdrawText() async {
    try {
      await game.submitText(userId, null);

      setState(() {
        _focusNode.canRequestFocus = true;
      });
    } catch (e) {}
    ;
  }

  @override
  Widget build(BuildContext context) {
    
        return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildPrompt(context),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildTextSubmission(context),
              )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildBottom(context),
              )
            ],
          ),
        ),
    );
  }

  SizedBox _buildBottom(BuildContext context) {
    final bool canSubmit = !isSubmittingText && !hasSubmittedText;
    final bool canEdit = !isSubmittingText && hasSubmittedText;

    final submitTextButton = UtterBullButton(
        key: const ValueKey('submitTextButton'),
        onPressed: canSubmit ? () => _onSubmitText() : null,
        title: 'Submit');

    final editTextButton = UtterBullButton(
        key: const ValueKey('editTextButton'),
        onPressed: canEdit ? () => _onWithdrawText() : null,
        isShimmering: false,
        title: 'Edit');

    final playersReadyPrompt = AutoSizeText(playersSubmittedTextPrompt,
        style: const TextStyle(fontSize: 32), maxLines: 2);

    final editBar = Row(
      children: [
        Flexible(flex: 1, child: editTextButton),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: playersReadyPrompt,
          ),
        )
      ],
    );

    return SizedBox(
        height: 65,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: canEdit
              ? editBar
              : canSubmit
                  ? submitTextButton
                  : UtterBullCircularProgressIndicator(),
        ));

    // return SizedBox(
    //     height: 65,
    //     child: AnimatedSwitcher(
    //       transitionBuilder: (child, anim) {
    //         return FadeTransition(
    //             opacity: anim.drive(Tween(begin: 0.0, end: 1.0)),
    //             child: Transform.translate(
    //                 offset: Offset(0, anim.value * 150), child: child));
    //       },
    //       duration: const Duration(seconds: 1),
    //       child: hasSubmitted ? editBar : submitTextButton,
    //     ));
  }

  Widget _buildPrompt(BuildContext context) {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: WritingPrompt.writeA,
                  style: Theme.of(context).textTheme.headlineSmall),
              const TextSpan(text: " "),
              TextSpan(
                text: writingPrompt.truthOrLie,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: writingTruthOrLie == null ? Colors.white 
                    : (writingTruthOrLie ?? false
                        ? UtterBullGlobal.truthColor
                        : UtterBullGlobal.lieColor)),
              ),
            ]),
            textAlign: TextAlign.center),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: writingPrompt.forOrAbout,
                style: Theme.of(context).textTheme.headlineSmall!),
            const TextSpan(text: " "),
            TextSpan(
              text: writingPrompt.target,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: const Color.fromARGB(255, 37, 37, 37)),
            ),
          ]),
          textAlign: TextAlign.center,
        )
      ],
    );

    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: column,
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: UtterBullPlayerAvatar(null, playerWritingFor?.avatarData),
        )),
      ],
    );
  }

  Widget _buildTextSubmission(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: hasSubmittedText
              ? const Color.fromARGB(255, 202, 202, 202).withOpacity(0.7)
              : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16.0)),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UtterBullTextField(
          maxLength: 300,
          focusNode: _focusNode,
          controller: _submissionController,
          hintText: "Type your submission here!",
          maxLines: null,
          expands: true,
          readOnly: hasSubmittedText || isSubmittingText,
        ),
      )),
    );
  }
}
