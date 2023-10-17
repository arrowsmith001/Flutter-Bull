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
        yield value.copyWith(userId: null);
      } else {
        Logger().d('yielding Not Null');
        yield* _streamService
            .streamPlayer(userId)
            .map((player) =>
                value.copyWith(userId: userId, playerProfileExists: true))
            .startWith(
                value.copyWith(userId: userId, playerProfileExists: false));
      }
    });
  }

  Future<void> signIn() async {
    state = const AsyncLoading<AuthNotifierState>().copyWithPrevious(
        AsyncData<AuthNotifierState>(
            value.copyWith(message: "Signing you in as a guest...")));

    try {
      await Future.delayed(const Duration(seconds: 1));
      await _authService.signInAnonymously();
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.fromString(e.toString()));
    }
  }

  Future<void> signUp() async {
    state = state.copyWithPrevious(const AsyncLoading());

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signInAnonymously();
  }

  Future<void> signOut() async {
    state = state.copyWithPrevious(const AsyncLoading());

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signOut();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {

    setData(value.copyWith(signUp: true, validateSignUpForm: false));

    try {
      await Future.delayed(const Duration(seconds: 1));
      await _authService.createUserWithEmailAndPassword(email, password);

      setData(value.copyWith(signUp: false));
    } catch (e) {
      setData(
          value.copyWith(errorMessage: "Error signing up: $e", signUp: false));
    }
  }

  void setRoute(String route) {
    setData(value.copyWith(route: route));
  }

  void setValidateSignUpForm(bool validate) {
    setData(value.copyWith(validateSignUpForm: validate));
  }


  void onSignUpPage() {
    setData(value.copyWith(signUpPage: true));
  }

  void onExitSignUpPage() {
    setData(value.copyWith(signUpPage: false));
  }

  void setData(AuthNotifierState newState) {
    Logger().d('newState $newState');
    state = AsyncData(newState);
  }

  AuthNotifierState get value => state.value ?? AuthNotifierState();
}
