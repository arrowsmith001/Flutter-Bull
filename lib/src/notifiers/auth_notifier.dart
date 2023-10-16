import 'dart:async';

import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  AuthService get _authService => ref.read(authServiceProvider);
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);

  @override
  Stream<AuthNotifierState> build() async* {
    yield* _authService.streamUserId().switchMap((userId) async* {
      if (userId == null) {
        Logger().d('yielding Null');
        yield AuthNotifierState(userId: null);
      } else {
        Logger().d('yielding Not Null');
        yield* _streamService
            .streamPlayer(userId)
            .map((player) =>
                AuthNotifierState(userId: userId, playerProfileExists: true))
            .startWith(
                AuthNotifierState(userId: userId, playerProfileExists: false));
      }
    });
  }

  Future<void> signIn() async {
    state = const AsyncLoading<AuthNotifierState>()
        .copyWithPrevious(AsyncData<AuthNotifierState>(
            AuthNotifierState(message: "Signing you in as a guest...")))
        .copyWithPrevious(state);

    try {
      await Future.delayed(const Duration(seconds: 1));
      await _authService.signInAnonymously();
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.fromString(e.toString()));
    }
  }

  Future<void> signUp() async {
    state = state.copyWithPrevious(AsyncLoading());

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signInAnonymously();
  }

  Future<void> signOut() async {
    state = state.copyWithPrevious(AsyncLoading());

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signOut();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    state = AsyncData<AuthNotifierState>(
            AuthNotifierState(isSigningUp: true, isValidatingSigningUp: false))
        .copyWithPrevious(state);

    try {
      await Future.delayed(Duration(seconds: 1));
      await _authService.createUserWithEmailAndPassword(email, password);
    } catch (e) {
      state = AsyncData<AuthNotifierState>(AuthNotifierState(
              errorMessage: "Error signing up: $e", isSigningUp: false))
          .copyWithPrevious(state);
    }
  }

  void setRoute(String route) {
    state = AsyncData<AuthNotifierState>(AuthNotifierState(route: route))
        .copyWithPrevious(state);
  }

  void setValidateSignUpForm(bool validate) {
    state = AsyncData<AuthNotifierState>(
            AuthNotifierState(isValidatingSigningUp: validate))
        .copyWithPrevious(state);
  }

  void setState(AsyncValue<AuthNotifierState> newState) {
    state = newState.copyWithPrevious(state);
  }
  
  void onSignUp() {
    setState(AsyncData(AuthNotifierState(signUpEvent: true)));
  }


  void onExitSignUp() {
    setState(AsyncData(AuthNotifierState(signUpEvent: false)));
    }
}
