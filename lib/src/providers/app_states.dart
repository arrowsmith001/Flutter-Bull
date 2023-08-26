import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'app_states.g.dart';


mixin UserID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get userId => ref.watch(getSignedInPlayerIdProvider);
}

@Riverpod(keepAlive: true)
String getSignedInPlayerId(Ref ref) => throw UnimplementedError('getSignedInPlayerId');



mixin RoomID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get roomId => ref.watch(getCurrentGameRoomIdProvider);
}

@Riverpod(keepAlive: true)
String getCurrentGameRoomId(Ref ref) => throw UnimplementedError('getCurrentGameRoomId');



mixin WhoseTurnID<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String get whoseTurnId => ref.watch(getPlayerWhoseTurnIdProvider);
}

@Riverpod(keepAlive: true)
String getPlayerWhoseTurnId(Ref ref) => throw UnimplementedError('getPlayerWhoseTurnId');
