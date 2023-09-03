import 'dart:typed_data';

import 'package:flutter/material.dart';

class UtterBullPlayerAvatar extends StatefulWidget {
  const UtterBullPlayerAvatar(this.data);

  final Uint8List? data;

  @override
  State<UtterBullPlayerAvatar> createState() => _UtterBullPlayerAvatarState();
}

class _UtterBullPlayerAvatarState extends State<UtterBullPlayerAvatar> {
  @override
  Widget build(BuildContext context) {
    if (widget.data == null) return CircularProgressIndicator();
    return Image.memory(
      widget.data!,
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
    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: child,
      ),
    );
  }
}
