import 'dart:async';

import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_events.dart';
import 'package:flutter_bull/src/new/notifiers/app/app_state_notifier.dart';
import 'package:flutter_bull/src/new/notifiers/game/game_events.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/timer_notifier.dart';
import 'package:flutter_bull/src/view_models/4_game_round/3_voting_phase_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'game_event_notifier.g.dart';

class GameRoute {
  final GamePhase phase;
  final int progress;
  final int subPhase;

  GameRoute(this.phase, this.progress, this.subPhase);

  @override
  operator ==(Object other) {
    if (other is GameRoute) {
      return phase == other.phase &&
          progress == other.progress &&
          subPhase == other.subPhase;
    }
    return false;
  }
  
  @override
  int get hashCode => phase.hashCode ^ progress.hashCode ^ subPhase.hashCode;
  
  @override
  String toString() {
    return 'GameRoute(phase: $phase, progress: $progress, subPhase: $subPhase)';
  }
}

@Riverpod(keepAlive: true)
class GameEventNotifier extends _$GameEventNotifier {
  
  @override
  Stream<GameEvents> build(String? gameId) async* {
    if (gameId == null) return;

    ref.listen(
        gameNotifierProvider(gameId)
            .select((value) => value.valueOrNull?.presentPlayers), (_, next) {
      if (next != null) setData(GameEvents(newPresentPlayers: next));
    });

    ref.listen(gameNotifierProvider(gameId).select((value) {
      final GamePhase? phase = value.valueOrNull?.gameRoom.phase;
      final int? progress = value.valueOrNull?.gameRoom.progress;
      final int? subPhase = value.valueOrNull?.gameRoom.subPhase;

      if(phase == null || progress == null || subPhase == null) return null;
      return GameRoute(phase, progress, subPhase);
    }), (_, next) {
      if (next != null) setData(GameEvents(newGameRoute: next));
    });


    yield GameEvents();
  }

  // void addSignUpPageEvent(SignUpPageState state) {
  //   setData(AppEvents(newSignUpPageState: state));
  // }

  // void addAuthBarEvent(AuthBarState state) {
  //   setData(AppEvents(newAuthBarState: state));
  // }

  // void addBusyEvent(Busy busy) {
  //   setData(AppEvents(newBusy: busy));
  // }

  // void addCameraViewEvent(CameraViewState state) {
  //   setData(AppEvents(newCameraViewState: state));
  // }

  // void addNotBusyEvent(Busy notBusy) {
  //   setData(AppEvents(newNotBusy: notBusy));
  // }

  void setData(GameEvents newState) {
    Logger().d('setting new AppEvents: $newState');
    state = AsyncData(newState);
  }
}
