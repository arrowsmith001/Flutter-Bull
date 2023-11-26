import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  factory AppState({
    AuthBarState? authBarState,
    SignUpPageState? signUpPageState,
    CameraViewState? cameraViewState,
    @Default([]) List<Busy> busyWith,
    Busy? nowBusy,
    Busy? nowNotBusy,
  }) = _AppState;

}

