import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_event_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/lobby_player.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_events.freezed.dart';

@freezed
class GameEvents with _$GameEvents {
  factory GameEvents({
    List<LobbyPlayer>? newPresentPlayers,
    GameRoute? newGameRoute,
    // TimeData? newTimeData, 
    // RoundStatus? newRoundStatus
    
    }) = _GameEvents;

}