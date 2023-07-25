import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/notifiers/loadable.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'auth_notifier.g.dart';

@immutable
class AuthState {
  const AuthState(this.userId, this.playerProfileExists);

  final bool playerProfileExists;
  final String? userId;

  bool get isSignedIn => userId != null;

  @override
  String toString() {
    return userId ?? '<null id>';
  }

  @override
  bool operator ==(Object other) {
    return other is AuthState && other.userId == userId;
  }
}

@Riverpod(keepAlive: false)
class AuthNotifier extends _$AuthNotifier {
  AuthService get _authService => ref.read(authServiceProvider);
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);

  @override
  Stream<AuthState> build() {
    return _authService.streamUserId().switchMap((userId) {
      return _streamService.streamPlayerExists(userId).map((exists) {
        final newState = AuthState(userId, exists);

        return newState;
        // (state.value == newState) ? state.value! : newState;
      });
    });
  }

  String get loadingMessage => _loadingMessage;
  String _loadingMessage = '';

  Future<void> signIn() async {
    _loadingMessage = 'Signing in...';
    state = AsyncLoading();

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signInAnonymously();
  }

  Future<void> signUp() async {
    _loadingMessage = 'Signing in...';
    state = AsyncLoading();

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signInAnonymously();
  }

  Future<void> signOut() async {
    _loadingMessage = 'Signing out...';
    state = AsyncLoading();

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signOut();
  }
}
