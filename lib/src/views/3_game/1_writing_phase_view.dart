import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/view_models/writing_phase_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/3_game/1_writing_phase_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
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
    with RoomID, UserID {
  UtterBullServer get _getServer => ref.read(utterBullServerProvider);

  final TextEditingController _submissionController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  bool isSubmissionPending = false;

  Future<void> _onSubmitText() async {
    setState(() {
      isSubmissionPending = true;
    });

    await _getServer.submitText(roomId, userId!, _submissionController.text);

    setState(() {
      isSubmissionPending = false;
      _focusNode.canRequestFocus = false;
    });
  }

  Future<void> _onWithdrawText() async {
    setState(() {
      isSubmissionPending = true;
    });

    await _getServer.submitText(roomId, userId!, null);

    setState(() {
      isSubmissionPending = false;
      _focusNode.canRequestFocus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vmProvider = writingPhaseViewNotifierProvider(roomId, userId!);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(
      body: vmAsync.whenDefault((WritingPhaseViewModel vm) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildPrompt(context, vm),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildTextSubmission(context, vm),
              )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildBottom(context, vm),
              )
            ],
          ),
        );
      }),
    );
  }

  SizedBox _buildBottom(BuildContext context, WritingPhaseViewModel vm) {
    final bool hasSubmitted = vm.hasSubmitted;
    final bool canSubmit = !isSubmissionPending && !hasSubmitted;

    final submitTextButton = UtterBullButton(
        onPressed: canSubmit ? () => _onSubmitText() : null,
        isLoading: !canSubmit,
        title: 'Submit');

    final editTextButton = UtterBullButton(
        isShimmering: false,
        onPressed: () {
          _onWithdrawText();
        },
        title: 'Edit');

    final playersReadyPrompt = AutoSizeText(vm.playersSubmittedTextPrompt,
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
        child: hasSubmitted ? editBar : submitTextButton);

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

  Widget _buildPrompt(BuildContext context, WritingPhaseViewModel vm) {
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
                text: vm.writingPrompt.truthOrLie,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: vm.writingTruthOrLie
                        ? UtterBullGlobal.truthColor
                        : UtterBullGlobal.lieColor),
              ),
            ]),
            textAlign: TextAlign.center),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: vm.writingPrompt.forOrAbout,
                style: Theme.of(context).textTheme.headlineSmall!),
            const TextSpan(text: " "),
            TextSpan(
              text: vm.writingPrompt.target,
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
          child: UtterBullPlayerAvatar(null, vm.playerWritingFor.avatarData),
        )),
      ],
    );
  }

  Widget _buildTextSubmission(BuildContext context, WritingPhaseViewModel vm) {
    final bool hasSubmitted = vm.hasSubmitted;

    return Container(
      decoration: BoxDecoration(
          color: hasSubmitted
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
          readOnly: hasSubmitted,
        ),
      )),
    );
  }
}
