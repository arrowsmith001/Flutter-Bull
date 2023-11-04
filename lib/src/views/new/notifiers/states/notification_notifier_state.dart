import 'dart:typed_data';

import 'package:camera/src/camera_controller.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_notifier_state.freezed.dart';

@freezed
class NotificationNotifierState with _$NotificationNotifierState {
  factory NotificationNotifierState({@Default([]) List<Notification> notifs}) =
      _NotificationNotifierState;
}
