import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/loading.dart';

class LoadingMessage extends StatefulWidget {
  LoadingMessage(this.message, {super.key});
  final String message;

  @override
  State<LoadingMessage> createState() => _LoadingMessageState();
}

class _LoadingMessageState extends State<LoadingMessage> with MediaDimensions {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Loading(
            dim: width * 0.4,
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Expanded(
              child: AutoSizeText(  
              widget.message,
              textAlign: TextAlign.center,
              
              maxLines: 2,
              style: Theme.of(context).textTheme.headlineLarge,
                    ),
            )
          ],),
        )
      ],
    );
  }
}