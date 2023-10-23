import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_notifier_state.freezed.dart';

@freezed
class AuthNotifierState with _$AuthNotifierState {
  factory AuthNotifierState({
    AuthState? authState,
    AuthBarState? authBarState,
    HomePageState? homePageState,
    String? userId,
    String? route,
    String? occupiedRoomId,
    bool? validateSignUpForm,
    bool? signUp,
    bool? login,
    bool? signUpPage,
    bool? profilePhotoExists,
    String? errorMessage,
    @Default('') String message,
  }) = _AuthNotifierState;
}

enum AuthState {
  signedOut, signedInNoPlayerProfile, signedInNoName, signedInNoPic, signedIn
}


enum AuthBarState {
  hide, show
}