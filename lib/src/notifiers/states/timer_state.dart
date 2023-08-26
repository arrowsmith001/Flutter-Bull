
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

@freezed
class TimerState with _$TimerState {
  TimerState._();

  factory TimerState({@Default(Duration.zero) Duration timeRemaining}) = _TimerState;

}
