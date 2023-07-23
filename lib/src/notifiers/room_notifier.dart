import 'dart:async';

import 'package:flutter_bull/main.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
part 'room_notifier.g.dart';

@Riverpod(keepAlive: true)
class RoomNotifier extends _$RoomNotifier {
  AuthService get _authService => ref.read(authServiceProvider);
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);

  @override
  Stream<GameRoom> build(String? arg) {
    return _streamService.streamGameRoom(arg);
  }
}
