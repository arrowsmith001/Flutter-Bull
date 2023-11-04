import 'dart:typed_data';

import 'package:camera/src/camera_controller.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
class Notification with _$Notification {
  factory Notification(
      {
        required String message,
        required NotificationType type,
        String? subType,
        required DateTime time,
      @Default(false) bool isRead}) = _Notification;

}

enum NotificationType { error, info }
