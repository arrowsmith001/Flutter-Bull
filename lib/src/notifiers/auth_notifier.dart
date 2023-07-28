import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/notifiers/loadable.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'auth_notifier.g.dart';


@Riverpod(keepAlive: false)
class AuthNotifier extends _$AuthNotifier {

  AuthService get _authService => ref.read(authServiceProvider);
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);

  @override
  Stream<AuthNotifierState> build() {
    return _authService.streamUserId().switchMap((userId) {
      return _streamService.streamPlayerExists(userId).map((exists) {

        final newState = AuthNotifierState(userId : userId, playerProfileExists: exists);

        return newState;
        // (state.value == newState) ? state.value! : newState;
      });
    });
  }

  Future<void> signIn() async {

    state = state.copyWithPrevious(AsyncLoading());

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signInAnonymously();
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
}
