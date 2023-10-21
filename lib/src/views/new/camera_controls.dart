import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/new/notifiers/camera_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/camera_notifier_state.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_back_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraControls extends ConsumerStatefulWidget {
  const CameraControls({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CameraControlsState();
}

class _CameraControlsState extends ConsumerState<CameraControls>
    with MediaDimensions {
  void _onClose() {
    ref.read(cameraNotifierProvider.notifier).close();
  }

  void _onTakePicture() {
    ref.read(cameraNotifierProvider.notifier).takePicture();
  }

  void _onDiscardPhoto() {
    ref.read(cameraNotifierProvider.notifier).discardPicture();
  }

  void _onUploadPhoto() {
    ref.read(cameraNotifierProvider.notifier).uploadPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(cameraNotifierProvider).whenDefault(
      (data) {
        final bool cameraActive =
            data.cameraState != CameraState.hasTakenPicture;

        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: cameraActive
                ? _buildCameraControls(context)
                : _buildPictureControls(context));
      },
    );
  }

  _buildPictureControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      IconButton(
        iconSize: 50,
        onPressed: () => _onDiscardPhoto(), icon: Icon(Icons.delete)),
        IconButton(
        iconSize: 50,
        onPressed: () => _onUploadPhoto(), icon: Icon(Icons.upload))
    ],);
  }

  _buildCameraControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(height: 100,),
            ClipPath(
              clipper: const _BottomAppBarClipper(
                  shape: CircularNotchedRectangle(), notchMargin: 5),
              child: Container(
                color: Colors.black,
                width: width,
                height: height * 0.05,
              ),
            ),
            Positioned(
                bottom: 10,
                height: 90,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  alignment: Alignment.center,
                  iconSize: 90,
                  icon: Icon(Icons.camera),
                  onPressed: () => _onTakePicture(),
                )),
            Positioned(
                left: 10,
                child: Container(
                  width: 50,
                  height: 50,
                  child: UtterBullBackButton(
                    color: Colors.white.withOpacity(0),
                    onPressed: () => _onClose()),
                ))
          ],
        )
      ],
    );
  }
  
}

class _BottomAppBarClipper extends CustomClipper<Path> {
  const _BottomAppBarClipper({
    required this.shape,
    required this.notchMargin,
  });

  final NotchedShape shape;
  final double notchMargin;

  @override
  Path getClip(Size size) {
    return shape.getOuterPath(
        Offset.zero & size,
        Rect.fromCenter(
            center: Offset(size.width / 2, 0), width: 90, height: 20));
  }

  @override
  bool shouldReclip(_BottomAppBarClipper oldClipper) {
    return false;
  }
}
