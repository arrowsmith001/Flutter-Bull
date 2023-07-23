import 'dart:async';

import 'package:flutter_bull/main.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
part 'player_notifier.g.dart';

@Riverpod(keepAlive: true)
class PlayerNotifier extends _$PlayerNotifier {
  AuthService get _authService => ref.read(authServiceProvider);
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);

  @override
  Stream<Player> build(String? arg) {
    return _streamService.streamPlayer(arg);
  }
}
