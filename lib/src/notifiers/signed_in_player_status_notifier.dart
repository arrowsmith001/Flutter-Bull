import 'dart:async';

import 'package:flutter_bull/src/model/player_status.dart';
import 'package:flutter_bull/src/notifiers/states/signed_in_player_status_notifier_state.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
part 'signed_in_player_status_notifier.g.dart';

@Riverpod(keepAlive: true)
class SignedInPlayerStatusNotifier extends _$SignedInPlayerStatusNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  UtterBullServer get _server => ref.read(utterBullServerProvider);

  // TODO: Include timeout
  // TODO: Maybe make another one for network status

  @override
  Stream<SignedInPlayerStatusNotifierState> build(String? userId) {
    if (userId == null) return Stream.empty();
    final playerStream = _streamService.streamPlayer(userId);
    final statusStream = statusSubject;

    return CombineLatestStream.combine2(playerStream, statusStream,
        (player, status) {
      Logger().d('SignedInPlayerStatusNotifier: $player $status');
      return SignedInPlayerStatusNotifierState(
          player: player, status: status, exists: true);
    });
  }

  BehaviorSubject<PlayerStatus> statusSubject =
      BehaviorSubject.seeded(PlayerStatus(busy: false, messageWhileBusy: ''));

  Future<void> createRoom() async {
    statusSubject
        .add(PlayerStatus(busy: true, messageWhileBusy: 'Creating Room'));

    await _server.createRoom(state.value!.player!.id!);

    statusSubject.add(PlayerStatus(busy: false));
  }

  Future<void> joinRoom(String? roomCode) async {
    if (roomCode == null ) throw Exception('Error joining room with roomCode $roomCode');
    if (roomCode == '') throw Exception('Error joining room: roomCode blank');

    statusSubject
        .add(PlayerStatus(busy: true, messageWhileBusy: 'Joining Room'));

    await _server.joinRoom(state.value!.player!.id!, roomCode);

    statusSubject.add(PlayerStatus(busy: false));
  }

  Future<void> leaveRoom(String? roomId) async {
    if (roomId == null) throw Exception('Error leaving room $roomId');

    statusSubject
        .add(PlayerStatus(busy: true, messageWhileBusy: 'Exiting Room'));

    await _server.removeFromRoom(state.value!.player!.id!, roomId);

    statusSubject.add(PlayerStatus(busy: false));
  }
}
