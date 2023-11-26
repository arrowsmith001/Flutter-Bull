import 'dart:async';

import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  AuthService get _authService => ref.read(authServiceProvider);
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  DataService get _dataService => ref.read(dataServiceProvider);

  AppStateNotifier get appNotifier =>
      ref.read(appStateNotifierProvider.notifier);

  @override
  Stream<AuthNotifierState> build() async* {
    yield* _authService.streamUserId().switchMap((userId) async* {
      if (userId == null) {
        Logger().d('yielding Null');
        yield value.copyWith(
            userId: null, occupiedRoomId: null, authState: AuthState.signedOut);
      } else {
        Logger().d('yielding Not Null');
        yield* _streamService
            .streamPlayer(userId)
            .map((player) => value.copyWith(
                userId: userId,
                authState: player.name == null
                    ? AuthState.signedInNoName
                    : player.profilePhotoPath == null
                        ? AuthState.signedInNoPic
                        : AuthState.signedIn,
                occupiedRoomId: player.occupiedRoomId,
                profilePhotoExists: player.profilePhotoPath != null))
            .startWith(value.copyWith(
                userId: userId, authState: AuthState.signedInNoPlayerProfile));
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

  Future<void> signInAnonymously() async {
    state = state.copyWithPrevious(const AsyncLoading());

    await _authService.signInAnonymously();
  }

  Future<void> signOut() async {
    ref.read(appStateNotifierProvider.notifier).addBusy(Busy.signingOut);

    state = state.copyWithPrevious(const AsyncLoading());

    await _authService.signOut();

    ref.read(appStateNotifierProvider.notifier).removeBusy(Busy.signingOut);
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    appNotifier.addBusy(Busy.signingUp);

    try {
      await _authService.createUserWithEmailAndPassword(email, password);

      appNotifier.setSignUpPageState(SignUpPageState.closed);
    } catch (e) {
      setData(value.copyWith(error: AuthError("Error signing up: $e")));
    } finally {
      appNotifier.removeBusy(Busy.signingUp);
    }
  }

  Future<void> submitName(String name) async {
    try {
      await _dataService.setName(value.userId!, name);

      setData(value.copyWith(message: "Name successfully set to $name"));
    } catch (e) {
      setData(value.copyWith(error: AuthError("Error setting name: $e")));
    }
  }


  Future<void> signInWithEmailAndPassword(String email, String password) async {
    appNotifier.addBusy(Busy.loggingIn);

    try {
      await _authService.signInWithEmailAndPassword(email, password);

      setData(value.copyWith(message: "Successfully logged in"));
    } catch (e) {
      setData(value.copyWith(error: AuthError("Error logging in: $e")));
    } finally {
      appNotifier.removeBusy(Busy.loggingIn);
    }
  }

 

  Future<void> createRoom(String userId) async {
    appNotifier.addBusy(Busy.creatingGame);
    try {
      await ref.read(utterBullServerProvider).createRoom(userId);
    } catch (e) {
      setData(value.copyWith(error: AuthError(e.toString())));
    } finally {
      appNotifier.removeBusy(Busy.creatingGame);
    }
  }

  Future<dynamic> oneSecond() => Future.delayed(Duration(seconds: 1));

  Future<void> joinRoom(String userId, String roomCode) async {
    appNotifier.addBusy(Busy.joiningGame);
    try {
      await ref.read(utterBullServerProvider).joinRoom(userId, roomCode);
    } catch (e) {
      pushError('$e');
    } finally {
      appNotifier.removeBusy(Busy.joiningGame);
    }
  }

  AuthNotifierState get value => state.value ?? AuthNotifierState();

  void pushError(String s) {
    setData(value.copyWith(error: AuthError(s)));
  }

  void setData(AuthNotifierState newState) {
    Logger().d('newState $newState');
    state = AsyncData(newState);
  }
}

// class CreateGameError extends Error {
//   final String message;
//   CreateGameError(this.message);
// }
