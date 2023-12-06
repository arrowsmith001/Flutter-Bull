import 'package:flutter/material.dart';
import 'package:flutter_bull/src/new/notifiers/misc/auth_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_states.g.dart';


@Riverpod(keepAlive: true)
String getSignedInPlayerId(Ref ref) =>
    throw UnimplementedError('getSignedInPlayerId');


@Riverpod(keepAlive: true)
String getCurrentGameRoomId(Ref ref) =>
    throw UnimplementedError('getCurrentGameRoomId');



@Riverpod(keepAlive: true)
int getProgress(Ref ref) =>
    throw UnimplementedError('getProgress');

mixin Auth<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  AuthNotifier get auth => ref.read(authNotifierProvider.notifier);
  AsyncValue<AuthNotifierState> get watchAuthState =>
      ref.watch(authNotifierProvider);
}

mixin MediaDimensions<T extends StatefulWidget> on State<T> {
  late final height = MediaQuery.of(context).size.height;
  late final width = MediaQuery.of(context).size.width;
  double get aspectRatio => height / width;
}
