import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lobby_player.freezed.dart';

@freezed
class LobbyPlayer with _$LobbyPlayer {
  factory LobbyPlayer(
      {required PublicPlayer player,
      required bool isLeader,
      required bool isReady,
      required bool isAbsent}) = _LobbyPlayer;
}
