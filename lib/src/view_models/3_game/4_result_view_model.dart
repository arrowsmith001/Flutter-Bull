import 'package:flutter/widgets.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/states/player_breakdown.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/utils/result_generator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../6_results_phase/player_result_summary.dart';

part '4_result_view_model.freezed.dart';

@freezed
class ResultViewModel with _$ResultViewModel {
  factory ResultViewModel({
    required GameRoom game,
    required Map<String, PublicPlayer> players,
    required ResultGenerator rg,
    required String userId,
  }) {
    final List<PlayerResultSummary> playerResultSummaries = [];

    // For each player, summarize
    for (var i = 0; i < rg.playerBreakdowns.length; i++) {
      final List<PlayerResultSummaryItem> summaryItems = [];

      final PlayerBreakdown pb = rg.playerBreakdowns[i];
      final String id = pb.playerId;
      final PublicPlayer player = players[id]!;

      // Round
      late TextSpan middleText;
      switch (pb.ownRoundFooledProportion.type) {
        case FooledProportionType.none:
          middleText = TextSpan(
              text: 'NOBODY', style: TextStyle(color: UtterBullGlobal.badVibe));
          break;
        case FooledProportionType.some:
          middleText = TextSpan(
              text: 'SOME', style: TextStyle(color: UtterBullGlobal.okayVibe));
          break;
        case FooledProportionType.most:
          middleText = TextSpan(
              text: 'MOST', style: TextStyle(color: UtterBullGlobal.goodVibe));
          break;
        case FooledProportionType.all:
          middleText = TextSpan(
              text: 'ALL', style: TextStyle(color: UtterBullGlobal.greatVibe));
          break;
      }
      final bool isPositive =
          pb.ownRoundFooledProportion.type != FooledProportionType.none;

      summaryItems.add(PlayerResultSummaryItem.round(
          [
            TextSpan(text: '${player.player.name} fooled '),
            middleText,
            const TextSpan(text: ' during their round...'),
          ],
          positive: isPositive));


      // Saboteur outcome
      if(pb.lieTarget != null)
      {
        if(pb.targetsLieTurnedOutTrue == true)
        {
          final String leading = summaryItems.last.positive ? "BUT" : "AND";
          summaryItems.add(PlayerResultSummaryItem.saboteur(
              [
                TextSpan(text: '$leading the lie they wrote '),
                TextSpan(text: 'turned out to be true...', style: TextStyle(color: UtterBullGlobal.badVibe)),
              ],
              positive: false));
        }
        else
        {
             late TextSpan middleText;
            switch (pb.saboteurfooledProportion!.type) {
              case FooledProportionType.none:
                middleText = TextSpan(
                    text: 'NO', style: TextStyle(color: UtterBullGlobal.badVibe));
                break;
              case FooledProportionType.some:
                middleText = TextSpan(
                    text: 'SOME', style: TextStyle(color: UtterBullGlobal.okayVibe));
                break;
              case FooledProportionType.most:
                middleText = TextSpan(
                    text: 'MOST', style: TextStyle(color: UtterBullGlobal.goodVibe));
                break;
              case FooledProportionType.all:
                middleText = TextSpan(
                    text: 'ALL', style: TextStyle(color: UtterBullGlobal.greatVibe));
                break;
            }
            final bool isPositive =
                pb.saboteurfooledProportion!.type != FooledProportionType.none;

            final String leading = summaryItems.last.positive != isPositive ? "BUT" : "AND";

            summaryItems.add(PlayerResultSummaryItem.round(
                [
                  TextSpan(text: '$leading the lie they wrote fooled '),
                  middleText,
                  const TextSpan(text: ' voters...'),
                ],
                positive: isPositive));
              }
      }
 

      // Votes
      final int correctVotes = pb.correctVotes;
      if (correctVotes == 0) {
        final String leading = summaryItems.last.positive ? "BUT" : "AND";

        summaryItems.add(PlayerResultSummaryItem.votes(
         [
            TextSpan(text: '$leading '), 
            TextSpan(text: 'didn\'t vote correctly', style: TextStyle(color: UtterBullGlobal.badVibe)),
            const TextSpan(text: ' in ANY round...'), 
          ]
            ,
            positive: false));
      } else {
        final String leading = summaryItems.last.positive ? "AND" : "BUT";
        final String s = correctVotes > 1 ? 's' : '';

        summaryItems.add(PlayerResultSummaryItem.votes(
          [
            TextSpan(text: '$leading '), 
            TextSpan(text: 'voted correctly', style: TextStyle(color: UtterBullGlobal.greatVibe)),
            TextSpan(text: ' in $correctVotes round$s...'), 
          ]
            ,
            positive: true));
      }

      final int fastestCorrectVotes = pb.fastestCorrectVotes;
      if (fastestCorrectVotes > 0) {
        final String s = correctVotes > 1 ? 's' : '';
        summaryItems.add(PlayerResultSummaryItem.time(
          [
            const TextSpan(text: 'AND voted correctly '), 
            TextSpan(text: 'the quickest', style: TextStyle(color: UtterBullGlobal.greatVibe)),
            TextSpan(text: ' $fastestCorrectVotes time$s'), 
          ]
            ));
      }

      final int minorityVotes = pb.minorityVotes;
      if (minorityVotes > 0) {
        final String s = minorityVotes > 1 ? 's' : '';
        summaryItems.add(PlayerResultSummaryItem.time(
          [
            const TextSpan(text: 'AND voted '), 
            TextSpan(text: 'in the minority', style: TextStyle(color: UtterBullGlobal.greatVibe)),
            TextSpan(text: ' $minorityVotes time$s'), 
          ])
            );
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
          {required Map<String, PublicPlayer> playerMap,
          required List<PlayerResultSummary> playerResultSummaries}) =
      _ResultViewModel;
}
