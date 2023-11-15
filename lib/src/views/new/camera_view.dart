import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/rounded_border.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/camera_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/camera_notifier_state.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_back_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_circular_progress_indicator.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camera_controls.dart';

class CameraView extends ConsumerStatefulWidget {
  const CameraView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView> with MediaDimensions {
  final double borderRadius = 16.0;
  @override
  Widget build(BuildContext context) {

    final preview = ref.watch(cameraNotifierProvider).when(
        data: (data) {
          if (data.cameraState == CameraState.hasTakenPicture) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: UtterBullPlayerAvatar(null, data.lastPicture),
            );
          }

          if (data.cameraState == CameraState.ready) {
            return LayoutBuilder(builder: (context, constraints) {

              return ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CameraPreview(
                                  data.controller!,
                                  child: CustomPaint(
                                    painter: HolePainter(
                                        Colors.white.withAlpha(150)),
                                  ),
                                ),
                    ],
                  ));
            });
          }

          return UtterBullCircularProgressIndicator();
          return ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: CameraPreview(
                    data.controller!,
                    child: CustomPaint(
                      painter: HolePainter(Colors.white.withAlpha(150)),
                    ),
                  )));
        },
        error: (e, s) => ErrorWidget(e),
        loading: () => UtterBullCircularProgressIndicator());

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: preview)
                // Flexible(
                //     child: Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: Colors.black,
                //         borderRadius: BorderRadius.circular(borderRadius)),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 4.0),
                //       child: preview,
                //     ),
                //   ),
                // )),
              ],
            ),
          ),
        ),
        Positioned(bottom: 0, child: CameraControls())
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // ref.read(cameraNotifierProvider.notifier).dispose();
  }
}

class HolePainter extends CustomPainter {
  HolePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.shortestSide / 2;

    final Path path = Path();
    path.fillType = PathFillType.evenOdd;
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    path.addRect(Rect.fromCenter(
        center: center, width: size.width, height: size.height));
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
