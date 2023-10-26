import 'dart:typed_data';

import 'package:camera/src/camera_controller.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_notifier_state.freezed.dart';

@freezed
class NotificationNotifierState with _$NotificationNotifierState {

  factory NotificationNotifierState(
    {
    required List<Notification> notifs
    }) 
    = _NotificationNotifierState;
}

class Notification {
  final String message;
  final NotificationType type;

  Notification({required this.message, required this.type});
}

enum NotificationType 
{
  error, info
}
