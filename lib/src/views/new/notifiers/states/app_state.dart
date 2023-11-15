import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  factory AppState({
    @Default(AuthBarState.show) AuthBarState authBarState,
    @Default(SignUpPageState.closed) SignUpPageState signUpPageState,
    @Default(CameraViewState.closed) CameraViewState cameraViewState,
    @Default([]) List<Busies> busyWith,
  }) = _AppState;

}

enum AuthBarState { hide, show }

enum SignUpPageState { open, validating, closed }

enum CameraViewState { open, closed }

enum Busies { loggingIn, signingUp, creatingGame, joiningGame, signingOut }
