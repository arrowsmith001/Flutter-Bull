
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  TimerState._();

  factory TimerState({int? remainingTimeMilliseconds}) = _TimerState;

  String get timeString {
    if (remainingTimeMilliseconds == null) return '--:--:--';


    final int secondsLeft = (remainingTimeMilliseconds! / 1000).floor();
    final int minutesLeft = (secondsLeft / 60).floor();

    return minutesLeft.toString() + ' : ' + secondsLeft.toString();

/*     final int ms = millisecondsLeft - (secondsLeft * 1000);
    final int s = secondsLeft - (minutesLeft * 60);
    final int m = minutesLeft;

    final String millisecondString = ms == 0 ? '--' : ms.toString().padLeft(3 - ms.toString().length, '0');
    final String secondString = s == 0 ? '--' : s.toString().padLeft(2 - s.toString().length, '0');
    final String minuteString = m == 0 ? '--' : m.toString();

    return '$minuteString:$secondString:$millisecondString'; */
  }
}
