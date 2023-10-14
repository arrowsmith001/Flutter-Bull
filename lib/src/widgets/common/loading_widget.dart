import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({this.message, super.key});

  final String? message;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Flexible(
            child: Center(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          layoutBuilder: (child, prev) {
                            return widget.message == null
                                ? const SizedBox.shrink()
                                : Text(widget.message!,
                                    style: Theme.of(context).textTheme.bodyLarge);
                          }),
                    ),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: UtterBullCircularProgressIndicator()),
                  ],
                ),
              )),
        )),
        Spacer()
      ],
    );
  }
}
