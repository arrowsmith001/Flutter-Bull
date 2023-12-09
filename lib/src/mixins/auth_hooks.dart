import 'package:flutter_bull/extensions/object.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin AuthHooks<T extends ConsumerStatefulWidget> on ConsumerState<T> {

  late String? userId = ref.watch(authNotifierProvider).valueOrNull?.userId;
  late String? gameId = ref.watch(authNotifierProvider).valueOrNull?.occupiedRoomId;

  // Notifiers
  AppStateNotifier get appNotifier =>
      ref.read(appStateNotifierProvider.notifier);

  // Auth
  late bool isSignedIn =
        ref.watch(authNotifierProvider).valueOrNull?.authState.isNotIn([null, AuthState.signedOut]) ?? false;

  late bool isInGame = ref.watch(authNotifierProvider).valueOrNull?.occupiedRoomId != null;



}
