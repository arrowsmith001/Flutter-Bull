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

@Riverpod(keepAlive: false)
class TimerNotifier extends _$TimerNotifier {

  
  
  @override
  Stream<TimerState> build(int? utcEnd) async* {
    if (utcEnd == null) yield TimerState(remainingTimeMilliseconds: 0);

    final remainingMs = utcEnd! - DateTime.now().millisecondsSinceEpoch;
    if (remainingMs <= 0) yield TimerState(remainingTimeMilliseconds: 0);

// TODO: Check that this cancels
    yield* Stream.periodic(Duration(milliseconds: 23), (_) {
      return _buildState(utcEnd);
    });
  }

  TimerState _buildState(int utcEnd) {
    final remainingMs = utcEnd - DateTime.now().millisecondsSinceEpoch;
    if (remainingMs <= 0) return TimerState(remainingTimeMilliseconds: 0);
    return TimerState(remainingTimeMilliseconds: remainingMs);
  }
}
