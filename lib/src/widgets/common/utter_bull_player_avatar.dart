import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';

// TODO: Incorporate
enum NamePosition {
  below, rightCenter
}

class UtterBullPlayerAvatar extends StatefulWidget {
  const UtterBullPlayerAvatar(this.name, this.data);

  final Uint8List? data;
  final String? name;

  @override
  State<UtterBullPlayerAvatar> createState() => _UtterBullPlayerAvatarState();
}

class _UtterBullPlayerAvatarState extends State<UtterBullPlayerAvatar> {

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1, child: 
    Container(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
                clipBehavior: Clip.none,
            alignment: Alignment.center, 
            children: [
    
              _buildAvatar(context),
    
              widget.name == null ? SizedBox.shrink() : 
              PositionedDirectional(
                  bottom: -constraints.maxHeight * 0.05,
                  child: SizedBox(
                  height: constraints.maxHeight * 0.2, 
                  child: Center(child: UglyOutlinedText(widget.name! , outlineColor: Color.lerp(Theme.of(context).colorScheme.primary, Colors.black, 0.4)),)),
                )
            ],
          );
        }
      ),
    ));
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
