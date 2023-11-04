import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'dart:ui' as ui;

// TODO: Move master background to login screen only?
class UtterBullMasterBackground extends StatefulWidget {
  const UtterBullMasterBackground({super.key, required this.child});

  final Widget child;

  @override
  State<UtterBullMasterBackground> createState() =>
      _UtterBullMasterBackgroundState();
}

class _UtterBullMasterBackgroundState extends State<UtterBullMasterBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation<double> doubleAnim;

  @override
  void initState() {
    super.initState();

    animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 15));

    doubleAnim = CurvedAnimation(parent: animController, curve: Curves.linear);

    animController.repeat();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        Positioned.fill(
            child: Container(
                decoration: BoxDecoration(
                    gradient: RadialGradient(radius: 2, colors: [
                  Colors.white,
                  Color.lerp(primaryColor, Colors.white, 0.2)!
                ])),
                child: _buildScrollingBackground())),
        widget.child,
      ],
    );
  }

  Widget _buildStaticBackground() {
    final imageTiled = Image.asset(Assets.images.bullOutline.path,
        scale: 3,
        repeat: ImageRepeat.repeat,
        color: Colors.grey.withOpacity(0.2));

    return imageTiled;
  }

  // TODO: Have scrolling background (alternate left-right by row)
  Widget _buildScrollingBackground() {
    // final imageRow = Image.asset(Assets.images.bullOutlinePadded.path,
    //     scale: 3,
    //     repeat: ImageRepeat.repeat,
    //     color: Colors.grey.withOpacity(0.2));

    return FutureBuilder(
        future: _loadImage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return Stack(
            children: [
              Positioned.fill(
                  child: AnimatedBuilder(
                    animation: animController,
                    builder: (_, __) => CustomPaint(
                        painter: BullBackgroundPainter(
                            snapshot.data!, animController.value)),
                  ))
            ],
          );
        });
  }

  Future<ui.Image> _loadImage() async {
    final ByteData data =
        await rootBundle.load(Assets.images.bullOutline.path);

    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 125,
      targetWidth: 125,
    );

    var frame = await codec.getNextFrame();
    return frame.image;
  }
}

class BullBackgroundPainter extends CustomPainter {
  BullBackgroundPainter(this.image, this.value);

  final ui.Image image;
  final double value;
  final Color color = Colors.grey.withAlpha(15);
  final double hPadding = 50.0;
  final double vPadding = 15.0;

  @override
  void paint(Canvas canvas, Size size) {

    final double width = image.width.toDouble() + hPadding;
    final double height = image.height.toDouble() + vPadding;

    final int numberOfRows = (size.height / height).ceil();
    final int numberPerRow = (size.width / width).ceil() + 2;

    final double hOffset = width * value;

    for (int i = 0; i < numberOfRows; i++) {
      for (int j = 0; j < numberPerRow; j++) {

        final bool b = (i % 2) == 0;
        final hAdj = b ? hOffset : -hOffset;

        canvas.drawImage(image, Offset((width * (j - 1)) + hAdj, height * i),
            Paint()..color = color);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
