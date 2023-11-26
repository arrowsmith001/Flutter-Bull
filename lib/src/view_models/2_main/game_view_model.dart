
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_view_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_view_model.freezed.dart';

@freezed
class GameViewModel with _$GameViewModel {
  factory GameViewModel(
      {required GamePath path, required PlayerState? playerState}
      ) = _GameViewModel;
}
