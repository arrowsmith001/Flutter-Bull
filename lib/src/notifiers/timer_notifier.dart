import 'dart:async';

import 'package:flutter_bull/src/notifiers/states/timer_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'timer_notifier.g.dart';

@Riverpod(keepAlive: true)
class TimerNotifier extends _$TimerNotifier {

  @override
  Stream<TimerState> build(int? utcEnd) async* {

    if (utcEnd == null) {
      yield TimerState();
      return;
    }
  
    final remainingMs = utcEnd - DateTime.now().millisecondsSinceEpoch;
    if (remainingMs <= 0) {
      yield TimerState();
      return;
    }
    

    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return _buildState(utcEnd);
    })
    .startWith(TimerState(timeRemaining: Duration(milliseconds: remainingMs)));

  }


  TimerState _buildState(int utcEnd) {
    final remainingMs = utcEnd - DateTime.now().millisecondsSinceEpoch;
    if (remainingMs <= 0) return TimerState();
    return TimerState(timeRemaining: Duration(milliseconds: remainingMs));
  }

}
