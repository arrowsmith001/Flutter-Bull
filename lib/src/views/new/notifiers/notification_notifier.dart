import 'dart:async';

import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/notification_notifier_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'notification_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationNotifier extends _$NotificationNotifier {
  @override
  Stream<NotificationNotifierState> build() async* {
    ref.listen(
        authNotifierProvider.select((value) => value.valueOrNull?.errorMessage),
        (previous, next) {
      if (next != null) {
        final notif = Notification(message: next, type: NotificationType.error);
        _addNotification(notif);
      }
    });
  }

  void _addNotification(Notification notif) 
  {
    final currentNotifs = state.valueOrNull?.notifs ?? [];
    final newState = NotificationNotifierState(notifs: [...currentNotifs, notif]);
    state = AsyncData(newState);
  }
}
