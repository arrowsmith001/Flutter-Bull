import 'dart:async';

import 'package:flutter_bull/main.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/notifiers/loadable.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
part 'auth_notifier.g.dart';

class AuthNotifierState extends Loadable {
  AuthNotifierState(this.userId, this.isSignedIn);

  final bool isSignedIn;
  final String? userId;

  @override
  String toString() {
    return userId ?? '<null id>';
  }
}

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  AuthService get _authService => ref.read(authServiceProvider);

  @override
  Stream<AuthNotifierState> build() {
    return _authService
        .streamUserId()
        .map((userId) => AuthNotifierState(userId, userId != null));
  }

  Future<void> signIn() async {
    state = AsyncLoading();

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signInAnonymously();
  }

  Future<void> signOut() async {
    state = AsyncLoading();

    //await Future.delayed(Duration(seconds: 1));

    await _authService.signOut();
  }
}
