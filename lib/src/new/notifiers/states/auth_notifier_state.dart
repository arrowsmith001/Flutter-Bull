import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_notifier_state.freezed.dart';

@freezed
class AuthNotifierState with _$AuthNotifierState {
  factory AuthNotifierState({
    AuthState? authState,
    String? userId,
    String? occupiedRoomId,
    bool? profilePhotoExists,
    AuthError? error,
    @Default('') String message,
  }) = _AuthNotifierState;

}

class AuthError {
  final String message;
  final DateTime time = DateTime.now();

  AuthError(this.message);
}

enum AuthState {
  signedOut,
  signedInNoPlayerProfile,
  signedInNoName,
  signedInNoPic,
  signedIn
}

