import 'dart:async';

import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'player_notifier.g.dart';

@Riverpod(keepAlive: true)
class PlayerNotifier extends _$PlayerNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  DataService get _dbService => ref.read(dataServiceProvider);

  @override
  Stream<Player> build(String? arg) {
    return _streamService.streamPlayer(arg);
  }

  Future<void> setName(String text) async {
    await _dbService.setName(state.requireValue.id!, text);
  }
}
