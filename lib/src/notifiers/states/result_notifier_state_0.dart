import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/result_generator.dart';

part 'result_notifier_state_0.freezed.dart';

@freezed
class ResultNotifierState0 with _$ResultNotifierState0 {

  factory ResultNotifierState0({
    required GameRoom game,  
    required Map<String, Achievement> achievements}) {

    final ResultGenerator resultGenerator = ResultGenerator(game, achievements);

    return ResultNotifierState0._(
      resultGenerator: resultGenerator
    );
  }

  factory ResultNotifierState0._(
      {required ResultGenerator resultGenerator}) = _ResultNotifierState0;
}
