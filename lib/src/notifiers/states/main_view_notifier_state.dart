import 'package:flutter_bull/src/model/player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_view_notifier_state.freezed.dart';

@freezed
class MainViewNotifierState with _$MainViewNotifierState {

  factory MainViewNotifierState({
    required Player signedInPlayer
    }) = _MainViewNotifierState;


}
