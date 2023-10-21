import 'dart:html' as html;
import 'dart:js_interop';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

// TODO: Debug this shit (breakpointn at camcontroller initialize), fails particularly on first invoke
class CameraService {

  List<CameraDescription>? cameras;

  Future<void> initialize() async {
    Logger().d('initialize');
    try {
      cameras ??= await availableCameras();
      Logger().d('initialization complete');
    } catch (e) {
      Logger().d(e);
    }
  }

  Future<bool> get isPermissionGranted async {
    Logger().d('isPermissionGranted');
    final status =
        await html.window.navigator.permissions?.query({"name": "camera"});
    final granted = status?.state != 'denied';
    Logger().d('state: ${status?.state}');
    return granted;
  }

  Future<bool> createController() async {
    try {
      assert(cameras != null);

      Iterator<List<CameraLensDirection>> preferences = [
        [CameraLensDirection.front],
        [CameraLensDirection.external],
        CameraLensDirection.values
      ].iterator;

      while (_cam == null) {
        preferences.moveNext();
        _cam = cameras!
            .where((c) => preferences.current.contains(c.lensDirection))
            .firstOrNull;
      }

      await dispose();
      await _setController(_cam!);
    } catch (e) {
      Logger().d(e.toString());
      return false;
    }

    return true;
  }

  bool isCameraControllerInitialized = false;

  CameraDescription? _cam;
  CameraController? _controller;

  CameraController? get controller {
    if (isCameraControllerInitialized == false) return null;
    return _controller;
  }

  Uint8List? imageData;
  bool imageDataAvailable = false;

  Future<void> takePicture() async {
    await _controller?.pausePreview();
    final currentImageFile = await controller?.takePicture();
    if (currentImageFile != null) {
      
      imageData = await currentImageFile.readAsBytes();
      imageDataAvailable = true;
    }


  }

  Future<void> dispose() async {
    await _controller?.dispose();
  }

  Future<void> discardPhoto() async {
    imageDataAvailable = false;
    await _controller?.resumePreview();
  }

  Future<void> _setController(CameraDescription cam) async {
    const resolutionPreset = ResolutionPreset.max;

    final newController =
        CameraController(cam, resolutionPreset, enableAudio: false);

    Logger().d('newController.initialize();');
    await newController.initialize();
    Logger().d('newController.initialize() COMPLETE');

    isCameraControllerInitialized = true;
    _controller = newController;
  }
}
