import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/widgets/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dart:html' as html;

class ChangeAvatarView extends ConsumerStatefulWidget {
  const ChangeAvatarView({super.key});

  @override
  ConsumerState<ChangeAvatarView> createState() => _ChangeAvatarViewState();
}

class _ChangeAvatarViewState extends ConsumerState<ChangeAvatarView> {
  @override
  initState() {
    super.initState();
    initCameras();
  }

  bool initialized = false;

// TODO: Platform channel
  Future<void> initCameras() async {
    final status =
        await html.window.navigator.permissions?.query({"name": "camera"});

    if (status == null) {
      Logger().d('status null');
      await html.window.navigator.getUserMedia(audio: false, video: true);
    } else {
      Logger().d('status ${status}');
    }
    final cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      cameras.forEach((element) {
        Logger().d(element.name + ' ' + element.lensDirection.name);
      });
      Iterator<List<CameraLensDirection>> preferences = [
        [CameraLensDirection.front],
        [CameraLensDirection.external],
        CameraLensDirection.values
      ].iterator;

      CameraDescription? cam;
      while (cam == null) {
        preferences.moveNext();
        cam = cameras
            .where((c) => preferences.current.contains(c.lensDirection))
            .firstOrNull;
      }

      final resolutionPreset = ResolutionPreset.max;

      final newController =
          CameraController(cam, resolutionPreset, enableAudio: false);

      Logger().d('pre-init');
      try {
        await newController.initialize();
      } catch (e) {
        Logger().d(e.toString());
      }
      Logger().d('post-init');

      setState(() {
        _camController = newController;
        Logger().d(_camController!.description.toString());
      });
    } else {
      Logger().d('No cameras!');
    }

    setState(() {
      initialized = true;
    });
  }

  CameraController? _camController;
  @override
  void dispose() {
    super.dispose();
    _camController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(getSignedInPlayerIdProvider);
    final avatarAsync = ref.watch(playerNotifierProvider(userId));

    final captureButton = Flexible(
        child: PlaceholderButton(
            onPressed: _camController == null ? null : () => onCapture(),
            title: 'Capture'));

    final backButton = Flexible(
        child: PlaceholderButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('home'),
            title: 'Back'));

    final discardButton = Flexible(
        child:
            PlaceholderButton(onPressed: () => onDiscard(), title: 'Discard'));

    final saveButton = Flexible(
        child: PlaceholderButton(onPressed: () => onSave(), title: 'Save'));

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Hero(
              tag: 'avatar',
              child: Builder(builder: (context) {

                if (_camController == null || initialized == false) {
                  return avatarAsync.whenDefault((data) {
                    return Opacity(
                        opacity: 0.5,
                        child: UtterBullPlayerAvatar(data.avatarData));
                  });
                }

                if (currentImageFile == null) {
                  return Row(
                    children: [
                      Flexible(
                        child: CameraPreview(
                          _camController!,
                          child: CustomPaint(
                            painter: HolePainter(Colors.white.withAlpha(150)),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return FutureBuilder(
                      future: currentImageFile!.readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return Stack(
                            children: [
                              Positioned.fill(
                                  child: Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              )),
                              Positioned.fill(
                                child: CustomPaint(
                                  painter:
                                      HolePainter(Colors.white.withAlpha(150)),
                                ),
                              )
                            ],
                          );
                        else
                          return Container(color: Colors.grey.withAlpha(50));
                      });
                }
              })),
        ),
        currentImageFile == null ? captureButton : saveButton,
        currentImageFile == null ? backButton : discardButton,
      ]),
    );
  }

  XFile? currentImageFile;
  bool isTakingPhoto = false;

  Future<void> onCapture() async {
    setState(() {
      isTakingPhoto = true;
    });

    try {
      currentImageFile = await _camController!.takePicture();
    } catch (e) {}

    setState(() {
      isTakingPhoto = false;
    });
  }

  Future<void> onDiscard() async {
    await _camController!.initialize();
    setState(() {
      currentImageFile = null;
    });
  }

  Future<void> onSave() async {
    assert(currentImageFile != null);
    final toUpload = await currentImageFile!.readAsBytes();

    final imgStorage = ref.read(imageStorageServiceProvider);
    final db = ref.read(dataServiceProvider);
    final userId = ref.read(getSignedInPlayerIdProvider);
    final timestamp = DateTime.timestamp();

    final String path = 'pp/$userId/$timestamp.jpg';
    await imgStorage.uploadImage(toUpload, path);
    await db.setImagePath(userId, path);
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
