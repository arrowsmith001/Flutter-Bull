
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
