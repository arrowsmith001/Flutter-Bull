import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

// TODO: Allow submit on ENTER

class UtterBullTextField extends StatelessWidget {
  const UtterBullTextField(
      {super.key,
      required this.controller,
      this.focusNode,
      this.maxLength,
      this.maxLines,
      this.expands = false,
      this.hintText,
      this.inputFormatters = const [],
      this.readOnly = false,
      this.errorText,
      this.obscureText = false,
      this.style
      
      });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final bool expands;
  final bool readOnly;
  final bool obscureText;
  final String? hintText;
  final String? errorText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AutoSizeTextField(
      obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          errorText: errorText, errorMaxLines: 2, errorStyle: const TextStyle(fontSize: 16)),
        readOnly: readOnly,
        textAlignVertical: TextAlignVertical.center,
        expands: expands,
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        maxLines: maxLines,
        textAlign: TextAlign.center,
        style: style ?? Theme.of(context).textTheme.displayMedium,
        inputFormatters: inputFormatters);
  }
}
