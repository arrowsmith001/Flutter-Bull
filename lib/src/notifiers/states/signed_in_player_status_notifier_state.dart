import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/model/player_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signed_in_player_status_notifier_state.freezed.dart';

@freezed
class SignedInPlayerStatusNotifierState with _$SignedInPlayerStatusNotifierState {

  factory SignedInPlayerStatusNotifierState({
    Player? player,
    PlayerStatus? status,
    required bool exists
    }) = _SignedInPlayerStatusNotifierState;


}