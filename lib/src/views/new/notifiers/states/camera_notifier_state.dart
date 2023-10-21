
import 'dart:typed_data';

import 'package:camera/src/camera_controller.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_notifier_state.freezed.dart';

@freezed
class CameraNotifierState with _$CameraNotifierState {
  factory CameraNotifierState({
    CameraState? cameraState, CameraController? controller, Uint8List? lastPicture,
  }) = _CameraNotifierState;
}


enum CameraState {
  requested, denied, ready, closed, disposed, isTakingPicture, hasTakenPicture, open, uploadingPhoto
}