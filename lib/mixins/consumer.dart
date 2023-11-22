import 'package:flutter_bull/src/views/new/notifiers/app/app_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin ConsumerFunctions<T extends ConsumerStatefulWidget> on ConsumerState<T> {

  AppNotifier get appNotifier => ref.read(appNotifierProvider.notifier);

  bool get isSignedIn {
    final authState = ref.watch(authNotifierProvider).valueOrNull?.authState;
    return authState != null && authState != AuthState.signedOut;
  }

  bool get isInGame => ref.watch(authNotifierProvider).valueOrNull?.occupiedRoomId != null;


  bool get isCreatingRoom => ref.watch(appNotifierProvider).valueOrNull?.busyWith.contains(Busy.creatingGame) ?? false;
  bool get isJoiningRoom => ref.watch(appNotifierProvider).valueOrNull?.busyWith.contains(Busy.joiningGame) ?? false;
  bool get isSigningUp => ref.watch(appNotifierProvider).valueOrNull?.busyWith.contains(Busy.signingUp) ?? false;
  bool get isSigningOut => ref.watch(appNotifierProvider).valueOrNull?.busyWith.contains(Busy.signingOut) ?? false;

  bool get canAuthBarShow => ref.watch(appNotifierProvider.select((value) => value.valueOrNull?.authBarState == AuthBarState.show));

  bool get isOnSignUpPage {
    final signUpPageState = ref.watch(appNotifierProvider).valueOrNull?.signUpPageState;
    return signUpPageState != null && signUpPageState != SignUpPageState.closed;
  }

  bool get isOnCameraPage {
    final cameraPageState = ref.watch(appNotifierProvider).valueOrNull?.cameraViewState;
    return cameraPageState != null && cameraPageState != CameraViewState.closed;
  }
}