import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_notifier_state.freezed.dart';

@freezed
class AuthNotifierState with _$AuthNotifierState {
  factory AuthNotifierState({
    String? userId,
    String? route,
    bool? playerProfileExists,
    bool? signUpPage,
    bool? validateSignUpForm,
    bool? signUp,
    String? errorMessage,
    @Default('') String message,
  }) = _AuthNotifierState;
}
