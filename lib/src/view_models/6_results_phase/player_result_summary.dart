import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/src/view_models/3_game/4_result_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_result_summary.freezed.dart';

@freezed
class PlayerResultSummary with _$PlayerResultSummary {
  factory PlayerResultSummary({
    required String playerId,
    required List<PlayerResultSummaryItem> items,
    required int roundScore,
    // required FooledProportion ownRoundFooledProportion,
    // required int correctVotes,
    // required int fastestCorrectVotes,
    // required int minorityVotes,
    // required PlayerWithAvatar? target,
    // required bool targetsLieTurnedOutTrue,
    // required int saboteursUncovered,
    // required FooledProportion? saboteurfooledProportion,
  }) = _PlayerResultSummary;
}

class PlayerResultSummaryItem {
  late final imgs = Assets.images.icons.achievements;

  PlayerResultSummaryItem.round(this.message, {this.positive = true}) {
    icon = imgs.fAll.image();
  }
  PlayerResultSummaryItem.votes(this.message, {this.positive = true}) {
    icon = (positive ? imgs.correct : imgs.cross).image();
  }
  PlayerResultSummaryItem.time(this.message, {this.positive = true}) {
    icon = imgs.fastest.image();
  }
  PlayerResultSummaryItem.minority(this.message, {this.positive = true}) {
    icon = imgs.minority.image();
  }
  PlayerResultSummaryItem.saboteur(this.message, {this.positive = true}) {
    icon = imgs.saboteur.image();
  }

  final bool positive;
  final List<TextSpan> message;

  //int score;
  late Image icon;
  late Color vibe;
}
