import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_notifier_state.freezed.dart';

@freezed
class AuthNotifierState with _$AuthNotifierState {
  factory AuthNotifierState({
    String? userId,
    String? route,
    bool? playerProfileExists,
    bool? isSigningUp,
    bool? isValidatingSigningUp,
    @Default('') String message, 
    String? errorMessage,
  }) = _AuthNotifierState;


}
