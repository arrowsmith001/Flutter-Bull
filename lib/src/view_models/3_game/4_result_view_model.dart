import 'package:flutter/widgets.dart';
import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/src/model/game_result.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/player_breakdown.dart';
import 'package:flutter_bull/src/notifiers/states/round_breakdown.dart';
import 'package:flutter_bull/src/utils/result_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

import '../6_results_phase/player_result_summary.dart';

part '4_result_view_model.freezed.dart';

@freezed
class ResultViewModel with _$ResultViewModel {
  factory ResultViewModel({
    required GameRoom game,
    required Map<String, PlayerWithAvatar> players,
    required ResultGenerator rg,
    required String userId,
  }) {
    final List<PlayerResultSummary> playerResultSummaries = [];

    // For each player, summarize
    for (var i = 0; i < rg.playerBreakdowns.length; i++) {
      final List<PlayerResultSummaryItem> summaryItems = [];

      final PlayerBreakdown pb = rg.playerBreakdowns[i];
      final String id = rg.playerBreakdowns[i].playerId;
      final PlayerWithAvatar player = players[id]!;

      // Round

      switch (pb.ownRoundFooledProportion.type) {
        case FooledProportionType.none:
          summaryItems.add(PlayerResultSummaryItem.round(
              '${player.player.name} fooled NOBODY during their round...',
              positive: false));
          break;
        case FooledProportionType.some:
          summaryItems.add(PlayerResultSummaryItem.round(
              '${player.player.name} fooled SOME during their round...'));
          break;
        case FooledProportionType.most:
          summaryItems.add(PlayerResultSummaryItem.round(
              '${player.player.name} fooled MOST during their round...'));
          break;
        case FooledProportionType.all:
          summaryItems.add(PlayerResultSummaryItem.round(
              '${player.player.name} fooled EVERYBODY during their round...'));
          break;
      }

      // Votes
      final int correctVotes = pb.correctVotes;
      if (correctVotes == 0) {
        final String leading = summaryItems.last.positive ? "BUT" : "AND";

        summaryItems.add(PlayerResultSummaryItem.votes(
            '$leading didn\'t vote correctly in ANY round...', positive: false));
      } else {
        final String leading = summaryItems.last.positive ? "AND" : "BUT";
        final String s = correctVotes > 1 ? 's' : '';

        summaryItems.add(PlayerResultSummaryItem.votes(
            '$leading voted correctly in $correctVotes round$s...'));
      }

      final int fastestCorrectVotes = pb.fastestCorrectVotes;
      if (fastestCorrectVotes > 0) {
        final String s = correctVotes > 1 ? 's' : '';
        summaryItems.add(PlayerResultSummaryItem.time(
            'AND voted correctly the quickest $fastestCorrectVotes time$s'));
      }

      final int minorityVotes = pb.minorityVotes;
      if (minorityVotes > 0) {
        final String s = minorityVotes > 1 ? 's' : '';
        summaryItems.add(PlayerResultSummaryItem.minority(
            'AND voted in the minority $minorityVotes time$s'));
      }

      final PlayerResultSummary summary = PlayerResultSummary(
          playerId: id,
          items: summaryItems,
          roundScore: rg.playerScores[id] ?? 0);
      playerResultSummaries.add(summary);
    }

    return ResultViewModel._(
        playerMap: players, playerResultSummaries: playerResultSummaries);
  }

  factory ResultViewModel._(
          {required Map<String, PlayerWithAvatar> playerMap,
          required List<PlayerResultSummary> playerResultSummaries}) =
      _ResultViewModel;
}
