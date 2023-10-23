import 'package:flutter/material.dart';
import 'package:flutter_bull/src/views/new/notifiers/auth_notifier.dart';
import 'package:flutter_bull/src/views/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_states.g.dart';

mixin UserID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String? get userId => ref.watch(authNotifierProvider).valueOrNull?.userId;
}

@Riverpod(keepAlive: true)
String getSignedInPlayerId(Ref ref) =>
    throw UnimplementedError('getSignedInPlayerId');

mixin RoomID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get roomId => ref.watch(getCurrentGameRoomIdProvider);
}

@Riverpod(keepAlive: true)
String getCurrentGameRoomId(Ref ref) =>
    throw UnimplementedError('getCurrentGameRoomId');

mixin WhoseTurnID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get whoseTurnId => ref.watch(getPlayerWhoseTurnIdProvider);
}

@Riverpod(keepAlive: true)
String getPlayerWhoseTurnId(Ref ref) =>
    throw UnimplementedError('getPlayerWhoseTurnId');

mixin Auth<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  AuthNotifier get auth => ref.read(authNotifierProvider.notifier);
  AsyncValue<AuthNotifierState> get watchAuthState =>
      ref.watch(authNotifierProvider);
}

mixin MediaDimensions<T extends StatefulWidget> on State<T> {
  late final height = MediaQuery.of(context).size.height;
  late final width = MediaQuery.of(context).size.width;
}
