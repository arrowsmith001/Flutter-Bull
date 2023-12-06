import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin AppHooks<T extends ConsumerStatefulWidget> on ConsumerState<T> {


  // Notifiers
  AppStateNotifier get appNotifier =>
      ref.read(appStateNotifierProvider.notifier);
      

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



  // Activities
  bool get isLeavingGame => isBusyWith(Busy.leavingGame);
  bool get isStartingGame => isBusyWith(Busy.startingGame);
  bool get isEndingRound => isBusyWith(Busy.endingRound);
  bool get isVoting => isBusyWith(Busy.voting);
  bool get isRevealing => isBusyWith(Busy.revealing);
  bool get isRevealingNext => isBusyWith(Busy.revealingNext);
  bool get isSubmittingText => isBusyWith(Busy.submittingText);

  bool isBusyWith(Busy busy) => _app?.busyWith.contains(busy) ?? false;
  bool isBusyWithAny(List<Busy> busy) =>
      _app?.busyWith.any((e) => busy.contains(e)) ?? false;
}
