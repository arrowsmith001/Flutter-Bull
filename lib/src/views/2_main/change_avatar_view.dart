import 'dart:html';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/camera_service.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dart:html' as html;


enum PermissionState { unknown, denied, prompt, granted }

enum CameraState { unavailable, pending, available }

class ChangeAvatarView extends ConsumerStatefulWidget {
  const ChangeAvatarView(this.camService, {super.key});
  final CameraService camService;

  @override
  ConsumerState<ChangeAvatarView> createState() => _ChangeAvatarViewState();
}

class _ChangeAvatarViewState extends ConsumerState<ChangeAvatarView>
    with UserID {

  @override
  void initState() {
    super.initState();
  }

  bool initialized = false;

  CameraService get _camService => widget.camService;
  Uint8List? get imageAsBytes => _camService.imageData;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    final avatarAsync = ref.watch(playerNotifierProvider(userId));

    final captureButton = Flexible(
        child: PlaceholderButton(
            onPressed: _camService == null ? null : () => onCapture(),
            title: 'Capture'));

    final backButton = Flexible(
        child: PlaceholderButton(
            onPressed: () => Navigator.of(context).pop(), title: 'Back'));

    final discardButton = Flexible(
        child: PlaceholderButton(onPressed: () => onDiscard(), title: 'Discard'));

    final saveButton = Flexible(
        child: PlaceholderButton(onPressed: () => onSave(), title: 'Save'));

    final main = Hero(
      tag: 'avatar',
      child: CameraPreview(
        _camService.controller!,
        child: CustomPaint(
          painter: HolePainter(Colors.white.withAlpha(150)),
        ),
      ),
    );

    if(!_camService.imageDataAvailable)
    {
        return Column(
        children: [
          main,
          captureButton,
          backButton,
        ],
      );
    }
    else {
      return Column(
      children: [
        UtterBullPlayerAvatar(null, imageAsBytes)
        ,
        saveButton,
        discardButton,
      ],
    );
    }
  }

  Widget _buildCameraDenied(BuildContext context) {
    return Text("Camera Denied", style: TextStyle(color: Colors.red));
  }

  Widget _buildCameraPrompted(BuildContext context) {
    return Text("Camera Requested", style: TextStyle(color: Colors.blue));
  }

  Widget _buildCameraPermissionUnknown(BuildContext context) {
    return const CircularProgressIndicator();
  }

  bool isTakingPhoto = false;

  Future<void> onCapture() async {
    setState(() {
      isTakingPhoto = true;
    });

    try {
      await _camService.takePicture();
    } catch (e) {}

    setState(() {
      isTakingPhoto = false;
    });
  }

  Future<void> onDiscard() async {
    await _camService.discardPhoto();
    setState(() {});
  }

  Future<void> onSave() async {
    if (imageAsBytes == null) return;

    final imgStorage = ref.read(imageStorageServiceProvider);
    final db = ref.read(dataServiceProvider);
    final userId = ref.read(getSignedInPlayerIdProvider);
    final timestamp = DateTime.timestamp();

    final String path = 'pp/$userId/$timestamp.jpg';
    await imgStorage.uploadImage(imageAsBytes!, path);
    await db.setImagePath(userId, path);

    await _camService.discardPhoto();

    setState(() {});
  }

  void _onCameraControllerEvent() {
    Logger().d('_onCameraControllerEvent');
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
