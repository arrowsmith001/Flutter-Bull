import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/view_models/game_data_functions.dart';

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
