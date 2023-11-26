import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_events.freezed.dart';

@freezed
class AppEvents with _$AppEvents {
  factory AppEvents({
    AuthBarState? newAuthBarState,
    SignUpPageState? newSignUpPageState,
    CameraViewState? newCameraViewState,
    Busy? newBusy,
    Busy? newNotBusy,
  }) = _AppEvents;

}