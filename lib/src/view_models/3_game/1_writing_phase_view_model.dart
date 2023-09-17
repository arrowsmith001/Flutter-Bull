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
    final targetId = game.targets[userId];
    final isWritingTruth = targetId == userId;

    final targetPlayer =
        GameDataFunctions.getTargetPlayer(game, players, userId);
    final targetText = GameDataFunctions.getTargetText(game, userId);
    final targetName = isWritingTruth ? null : targetPlayer.player.name!;


    final playersSubmitted =
        game.texts.entries.where((element) => element.value != null).length;
    final playerCount = game.playerOrder.length;
    final playersSubmittedTextPrompt =
        '$playersSubmitted/$playerCount players ready';

    return WritingPhaseViewModel._(
      playerWritingFor: targetPlayer,
      writingTruthOrLie: isWritingTruth,
      writingPrompt: WritingPrompt(targetName),
      hasSubmitted: targetText != null,
      playersSubmitted: playersSubmitted,
      playersSubmittedTextPrompt: playersSubmittedTextPrompt,
    );
  }

  factory WritingPhaseViewModel._(
      {required PlayerWithAvatar playerWritingFor,
      required bool writingTruthOrLie,
      required WritingPrompt writingPrompt,
      required bool hasSubmitted,
      required int playersSubmitted,
      required String playersSubmittedTextPrompt}) = _WritingPhaseViewModel;
}

class WritingPrompt {
  WritingPrompt([this._target]);

  final String? _target;
  bool get isTruth => _target == null;

  static const String writeA = 'Write a';
  String get truthOrLie => isTruth ? 'TRUTH' : 'LIE';
  String get forOrAbout => isTruth ? 'about' : 'for';
  String get target => isTruth ? 'yourself' : _target!;
}
