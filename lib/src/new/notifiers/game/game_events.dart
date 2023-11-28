import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_event_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_events.freezed.dart';

@freezed
class GameEvents with _$GameEvents {
  factory GameEvents({
    List<LobbyPlayer>? newPresentPlayers,
    GameRoute? newGameRoute,
    
    }) = _GameEvents;

}