import 'dart:async';
import 'dart:typed_data';

import 'package:camera/src/camera_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/camera_service.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/camera_notifier_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'camera_notifier.g.dart';

@Riverpod(keepAlive: true)
class CameraNotifier extends _$CameraNotifier {
  CameraService cameraService = CameraService();

  @override
  Stream<CameraNotifierState> build() async* {}

  Future<bool> initialize() async {
    setData(copy(cameraState: CameraState.requested));

    if (await cameraService.isPermissionGranted) {
      //if (!camService.isCameraControllerInitialized) {

      await cameraService.initialize();
      final success = await cameraService.createController();
      //}

      Logger().d('camera initialize: $success');

      if (success) {
        setData(copy(
            cameraState: CameraState.ready,
            controller: cameraService.controller));
      }

      return success;
    }

    return false;
  }

  Future<void> dispose() async {
    Logger().d('camera dispose');
    setData(copy(controller: null));

    await cameraService.controller?.dispose();

    setData(copy(cameraState: CameraState.disposed));
  }

  Future<void> close() async {
    Logger().d('camera close');
    setData(copy(cameraState: CameraState.closed));
    await dispose();
  }

  $CameraNotifierStateCopyWith<CameraNotifierState> get copy =>
      (state.value ?? CameraNotifierState()).copyWith;

  void setData(CameraNotifierState newState) {
    state = AsyncData(newState);
  }

  void takePicture() async {
    Logger().d('takePicture 0');
    if (kIsWeb) cameraService.controller?.pausePreview();
    Logger().d('takePicture 1');
    setData(copy(cameraState: CameraState.isTakingPicture));
    Logger().d('takePicture 2');
    await cameraService.takePicture();
    Logger().d('takePicture 3');
    setData(copy(
        cameraState: CameraState.hasTakenPicture,
        lastPicture: cameraService.imageData));
    Logger().d('takePicture 4');
  }

  void discardPicture() async {
    Logger().d('discardPicture 0');
    await cameraService.discardPhoto();

    Logger().d('discardPicture 1');
    if (kIsWeb) cameraService.controller?.resumePreview();
    Logger().d('discardPicture 2');
    setData(copy(cameraState: CameraState.ready));
    Logger().d('discardPicture 3');
  }

  Future<void> uploadPhoto() async {
    assert(cameraService.imageData != null, 'No image to upload');
    assert(cameraService.imageDataAvailable == true,
        'Image data deemed unavailable even though it exists');

    await _upload(cameraService.imageData!);

    await close();
  }

  Future<void> pickImage() async {
    ImagePicker ip = ImagePicker();
    final xfile = await ip.pickImage(source: ImageSource.gallery);

    assert(xfile != null, 'Picked image null: $xfile');

    final data = await xfile!.readAsBytes();
    _upload(data);
  }

  Future<void> _upload(Uint8List uint8list) async {
    final String? userId = ref.read(authNotifierProvider).valueOrNull?.userId;

    assert(userId != null, "Can't upload image: userId null");

    setData(copy(cameraState: CameraState.uploadingPhoto));

    final imgStorage = ref.read(imageStorageServiceProvider);
    final db = ref.read(dataServiceProvider);
    final timestamp = DateTime.timestamp();

    final String path = 'pp/$userId/$timestamp.jpg';
    await imgStorage.uploadImage(uint8list, path);
    await db.setImagePath(userId!, path);

    await cameraService.discardPhoto();
  }
}
