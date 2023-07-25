import 'dart:async';

import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'room_notifier.g.dart';

@Riverpod(keepAlive: true)
class RoomNotifier extends _$RoomNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);

  @override
  Stream<GameRoom> build(String? arg) {
    return _streamService.streamGameRoom(arg);
  }
}
