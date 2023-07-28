import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_status.freezed.dart';
part 'player_status.g.dart';

@freezed
class PlayerStatus extends Entity with _$PlayerStatus {
  const factory PlayerStatus(
      {
      String? id,
      String? errorMessage,
      @Default(false) bool busy,
      @Default('') String messageWhileBusy,
      }) = _PlayerStatus;

  factory PlayerStatus.fromJson(Map<String, Object?> json) =>
      _$PlayerStatusFromJson(json);
}
