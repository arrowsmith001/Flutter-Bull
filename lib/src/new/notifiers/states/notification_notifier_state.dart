
import 'package:flutter_bull/src/new/notifiers/states/notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_notifier_state.freezed.dart';

@freezed
class NotificationNotifierState with _$NotificationNotifierState {
  factory NotificationNotifierState({@Default([]) List<Notification> notifs}) =
      _NotificationNotifierState;
}
