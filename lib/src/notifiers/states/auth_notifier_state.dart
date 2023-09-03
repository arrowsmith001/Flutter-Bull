import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_notifier_state.freezed.dart';

@freezed
class AuthNotifierState with _$AuthNotifierState {
  factory AuthNotifierState({
    String? userId,
    @Default(false) bool playerProfileExists,
    @Default('') String message,
  }) = _AuthNotifierState;

}
