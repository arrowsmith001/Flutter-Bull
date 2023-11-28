import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin AuthHooks<T extends ConsumerStatefulWidget> on ConsumerState<T> {

  String? get userId => ref.watch(authNotifierProvider).valueOrNull?.userId;
  String? get gameId => ref.watch(authNotifierProvider).valueOrNull?.occupiedRoomId;

  // Notifiers
  AppStateNotifier get appNotifier =>
      ref.read(appStateNotifierProvider.notifier);

  // Auth
  bool get isSignedIn =>
      _auth?.authState?.isNotIn([null, AuthState.signedOut]) ?? false;
  bool get isInGame => _auth?.occupiedRoomId != null;

  // Activities
  bool get isCreatingRoom =>
      _app?.busyWith.contains(Busy.creatingGame) ?? false;
  bool get isJoiningRoom => _app?.busyWith.contains(Busy.joiningGame) ?? false;
  bool get isSigningUp => _app?.busyWith.contains(Busy.signingUp) ?? false;
  bool get isSigningOut => _app?.busyWith.contains(Busy.signingOut) ?? false;
  bool get isLoggingIn => _app?.busyWith.contains(Busy.loggingIn) ?? false;

  // Page States
  bool get isOnSignUpPage =>
      _app?.signUpPageState.isNotIn([null, SignUpPageState.closed]) ?? false;
  bool get isOnCameraPage =>
      _app?.cameraViewState.isNotIn([null, CameraViewState.closed]) ?? false;

  AppState? get _app => ref.watch(appStateNotifierProvider).valueOrNull;
  AuthNotifierState? get _auth => ref.watch(authNotifierProvider).valueOrNull;
}
