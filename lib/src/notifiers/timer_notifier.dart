import 'dart:async';

import 'package:flutter_bull/src/notifiers/states/timer_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_notifier.g.dart';

@Riverpod(keepAlive: true)
class TimerNotifier extends _$TimerNotifier {

  
  
  @override
  Stream<TimerState> build(int? utcEnd) {
    
    if (utcEnd == null) return Stream.value(TimerState());

    final remainingMs = utcEnd - DateTime.now().millisecondsSinceEpoch;
    if (remainingMs <= 0) return Stream.value(TimerState());

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
