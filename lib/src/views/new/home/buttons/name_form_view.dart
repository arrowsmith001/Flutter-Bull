import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/2_main/profile_setup_view.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameFormView extends ConsumerStatefulWidget {
  const NameFormView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileSetupViewNewState();
}

class _ProfileSetupViewNewState extends ConsumerState<NameFormView> {

  final TextEditingController _nameInputController =
      TextEditingController(text: 'Alex');
  final FocusNode _nameFocus = FocusNode();//..requestFocus();

  bool isSaving = false;
  bool get canSubmit => _nameInputController.text.trim().isNotEmpty;

  void _onSubmitName() async {
    setState(() {
      isSaving = true;
    });
    await ref.read(authNotifierProvider.notifier).submitName(_nameInputController.text.trim());
    setState(() {
      isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _nameFocus.requestFocus(),
              child: AutoSizeText(
                'Display name:',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormField(
                validator: (_) => InputValidators.nonEmptyStringValidator(
                    _nameInputController.text),
                builder: (state) {
                  return UtterBullTextField(
                    
                      readOnly: isSaving,
                      focusNode: _nameFocus,
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 1,
                      errorText: state.errorText,
                      controller: _nameInputController..addListener(() {setState(() {
                        
                      });}));
                },
              ),
            ),
            UtterBullButton(
              leading: isSaving ? UtterBullCircularProgressIndicator() : null,
              title: isSaving ? 'Saving' : 'OK',
              onPressed: canSubmit && !isSaving ? () => _onSubmitName() : null,
            )
          ],
        ),
      ],
    );
  }
}
