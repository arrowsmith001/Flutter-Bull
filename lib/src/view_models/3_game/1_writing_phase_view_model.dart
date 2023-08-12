import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/services/game_server.dart';
import 'package:flutter_bull/src/view_models/game_data_functions.dart';
import 'package:flutter_bull/src/widgets/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part '1_writing_phase_view_model.freezed.dart';

@freezed
class WritingPhaseViewModel with _$WritingPhaseViewModel {
  factory WritingPhaseViewModel(
      {required GameRoom game,
      required List<PlayerWithAvatar> players,
      required String userId}) {
    final isWritingTruth = game.targets[userId] == userId;
    final targetPlayer =
        GameDataFunctions.getTargetPlayer(game, players, userId);
    final targetName = isWritingTruth ? 'YOURSELF' : targetPlayer.player.name!;

    return WritingPhaseViewModel._(
        playerWritingFor: targetPlayer,
        writingTruthOrLie: isWritingTruth,
        writingPromptString:
            'Write a ${isWritingTruth ? 'TRUTH' : 'LIE'} about $targetName');
  }

  factory WritingPhaseViewModel._({
    required PlayerWithAvatar playerWritingFor,
    required bool writingTruthOrLie,
    required String writingPromptString,
  }) = _WritingPhaseViewModel;
}
