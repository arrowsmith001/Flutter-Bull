import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bull/src/custom/data/abstract/storage_service.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
part 'player_notifier.g.dart';

@Riverpod(keepAlive: true)
class PlayerNotifier extends _$PlayerNotifier {
  DataStreamService get _streamService => ref.read(dataStreamServiceProvider);
  DataService get _dbService => ref.read(dataServiceProvider);
  ImageStorageService get _imgService => ref.read(imageStorageServiceProvider);

  @override
  Stream<PublicPlayer> build(String userId) {

    Logger().d('userId: $userId');
    // TODO: Consider where existence checks belong ("pending" player notifier with timeout??)
    // TODO: Wrap this inside "pending" player or something
    return _streamService.streamPlayer(userId).asyncMap((player) async {
      Logger().d('userId: $userId, player: $player');
      final pwa = PublicPlayer(
          player,
          await _imgService.downloadImage(
              player.profilePhotoPath ?? 'pp/default/avatar.jpg'));
      Logger().d('pwa: $pwa');
      return pwa;
    }); // TODO: Make default a local file
  }

  Future<void> setName(String text) async {
    await _dbService.setName(state.requireValue.player.id!, text);
  }
}

class PublicPlayer {
  final Player player;
  final Uint8List? avatarData;

  PublicPlayer(this.player, this.avatarData);
}
