
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_view_model.freezed.dart';

@freezed
class GameViewModel with _$GameViewModel {
  factory GameViewModel(
      {required String path}
      ) = _GameViewModel;
}
