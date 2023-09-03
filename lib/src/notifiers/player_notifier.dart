import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bull/src/custom/data/abstract/storage_service.dart';
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
  ImageStorageService get _imgService => ref.read(imageStorageServiceProvider);

  @override
  Stream<PlayerWithAvatar> build(String userId) {
    // TODO: Consider where existence checks belong ("pending" player notifier with timeout??)
    // TODO: Wrap this inside "pending" player or something
    return _streamService.streamPlayer(userId).asyncMap((player) 
    
      async => PlayerWithAvatar(player, await _imgService.downloadImage(player.profilePhotoPath ?? 'pp/default/avatar.jpg'))); // TODO: Make default a local file
  }

  Future<void> setName(String text) async {
    await _dbService.setName(state.requireValue.player.id!, text);
  }
}

class PlayerWithAvatar {
  final Player player;
  final Uint8List? avatarData;

  PlayerWithAvatar(this.player, this.avatarData);
}
