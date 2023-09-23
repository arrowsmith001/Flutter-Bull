import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';

class UtterBullPlayerAvatar extends StatefulWidget {
  const UtterBullPlayerAvatar(this.data);

  final Uint8List? data;

  @override
  State<UtterBullPlayerAvatar> createState() => _UtterBullPlayerAvatarState();
}

class _UtterBullPlayerAvatarState extends State<UtterBullPlayerAvatar> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1, child: _buildAvatar(context));
  }

  Widget _buildAvatar(BuildContext context) {
    if (widget.data == null) return UtterBullCircularProgressIndicator();
    return Image.memory(
      widget.data!,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      frameBuilder: ((context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return CropCircled(child: child);
        return frame != null
            ? CropCircled(child: child)
            : const SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(strokeWidth: 6),
              );
      }),
    );
  }
}

class CropCircled extends StatelessWidget {
  const CropCircled({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final offPrimary = Color.lerp(primary, Colors.white, 0.75)!;

    return ClipOval(
      child: Container(
        color: primary,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipOval(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   stops: [0.05, 0.5, 0.95],
              //   colors: [ primary, offPrimary, primary ])),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
