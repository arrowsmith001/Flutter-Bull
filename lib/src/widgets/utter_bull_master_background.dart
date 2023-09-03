import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'dart:ui' as ui;

// TODO: Move master background to login screen only
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
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    doubleAnim = CurvedAnimation(parent: animController, curve: Curves.linear);

    animController.addListener(() {
      setState(() {});
    });

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
                child: _buildStaticBackground())),
        widget.child,
      ],
    );
  }

  Widget _buildStaticBackground() {

    final imageTiled = 
      Image.asset(Assets.images.bullOutlinePadded.path,
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
                  child: CustomPaint(
                      painter: BullBackgroundPainter(snapshot.data!)))
            ],
          );
        });
  }

  Future<ui.Image> _loadImage() async {
    final ByteData data = await rootBundle.load(Assets.images.at.path);

    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 100,
      targetWidth: 100,
    );

    var frame = await codec.getNextFrame();
    return frame.image;
  }
}

class BullBackgroundPainter extends CustomPainter {
  BullBackgroundPainter(this.image);

  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    final height = image.height;
    final int numberOfRows = (size.height / height).ceil();

    canvas.drawImage(image, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
