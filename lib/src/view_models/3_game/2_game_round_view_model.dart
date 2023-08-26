import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '2_game_round_view_model.freezed.dart';

@freezed
class GameRoundViewModel with _$GameRoundViewModel {
  factory GameRoundViewModel(
      {required RoundPhase roundPhase}
      ) = _GameViewModel;
}
