import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bull/src/custom/data/abstract/auth_service.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/loadable.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/room_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/auth_notifier_state.dart';
import 'package:flutter_bull/src/notifiers/states/game_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: false)
class GameNotifier extends _$GameNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);

  @override
  Stream<GameNotifierState> build(String userId, String gameRoomId) {
    final playerStream = _streamService.streamPlayer(userId);
    final roomStream = _streamService.streamGameRoom(gameRoomId);

    return CombineLatestStream.combine2(playerStream, roomStream,
        (player, room) => _buildNewState(player, room));
  }

  GameNotifierState _buildNewState(Player player, GameRoom room) {


    if (state.hasValue) {
      final prevRoom = state.value!.gameRoom;

      final listState = ListState.fromLists(prevRoom.playerIds, room.playerIds);

      return GameNotifierState(signedInPlayer: player, gameRoom: room, playerListState: listState);

    } else {
      return GameNotifierState(
          signedInPlayer: player,
          gameRoom: room,
          playerListState: ListState.init(room.playerIds));
    }
  }
}
