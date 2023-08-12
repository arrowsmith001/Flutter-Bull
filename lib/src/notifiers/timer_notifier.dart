import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/timer_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'timer_notifier.g.dart';

@Riverpod(keepAlive: true)
class TimerNotifier extends _$TimerNotifier {

  
  
  @override
  Stream<TimerState> build(int? utcEnd) {

    Logger().d('utcEnd $utcEnd');

    if (utcEnd == null) return Stream.value(TimerState());

    final remainingMs = utcEnd - DateTime.now().millisecondsSinceEpoch;
    if (remainingMs <= 0) return Stream.value(TimerState());

    Logger().d('remainingMs $remainingMs');

    // TODO: Check that this cancels
    return Stream.periodic(Duration(seconds: 1), (_) {
      return _buildState(utcEnd);
    });
  }

  TimerState _buildState(int utcEnd) {
    final remainingMs = utcEnd - DateTime.now().millisecondsSinceEpoch;
    if (remainingMs <= 0) return TimerState();
    return TimerState(timeRemaining: Duration(milliseconds: remainingMs));
  }
}
