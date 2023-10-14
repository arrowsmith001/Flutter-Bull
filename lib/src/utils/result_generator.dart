import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/states/player_breakdown.dart';
import 'package:flutter_bull/src/notifiers/states/round_breakdown.dart';
import 'package:logger/logger.dart';
import 'dart:math' as Math;

class ResultGenerator {
  ResultGenerator(this.game, this.achievements) {
    try {
      _generateRoundBreakdowns();
      _generateScores();
      _generatePlayerBreakdowns();
    } catch (e) {
      Logger().d('ResultGenerator ERROR: $e');
    }
  }

  final GameRoom game;
  final Map<String, Achievement> achievements;

  late final List<RoundBreakdown> roundBreakdowns;

  late final List<Map<String, List<Achievement>>> playerAchievementsByRound;
  late final List<Map<String, int>> playerScoresByRound;
  late final Map<String, int> playerScores;

  late final List<PlayerBreakdown> playerBreakdowns;

  void _generateRoundBreakdowns() {
    final List<RoundBreakdown> roundBreakdowns = [];
    final List<Map<String, List<Achievement>>> playerAchievementsByRound = [];

    for (var roundNum = 0; roundNum < game.playerOrder.length; roundNum++) {
      final Map<String, List<Achievement>> achievementsMap =
          Map.fromIterable(game.playerOrder, value: (_) => []);

      final String whoseTurnId = game.playerOrder[roundNum];
      final bool isTruth = game.truths[whoseTurnId]!;

      final String writerId = game.targets.keys
          .singleWhere((id) => game.targets[id] == whoseTurnId);

      final String? saboteurId = writerId == whoseTurnId ? null : writerId;
      final String? saboteurVote =
          saboteurId == null ? null : game.votes[saboteurId]![roundNum];

      final bool isAccidentalTruth = isTruth && saboteurId != null;
      if(isAccidentalTruth)
      {
          achievementsMap[saboteurId]!
              .add(achievements[AchievementId.lieTurnedOutTrue.name]!);
      }

      final List<String> eligibleVoters = game.playerOrder
          .where((id) => id != whoseTurnId && id != saboteurId)
          .toList();

      final List<String> playersVotedTrue = game.votes.keys
          .where((id) => game.votes[id]![roundNum] == 't')
          .toList();
      final List<String> playersVotedLie = game.votes.keys
          .where((id) => game.votes[id]![roundNum] == 'l')
          .toList();
      final List<String> playersNotVoted = game.votes.keys
          .where((id) => game.votes[id]![roundNum] == 'n')
          .toList();
      final List<String> playersVotedCorrectly =
          List.from(isTruth ? playersVotedTrue : playersVotedLie);

      final double fooledProportionNumeric =
          playersVotedCorrectly.length.toDouble() / eligibleVoters.length;

      final FooledProportion fooledProportion =
          FooledProportion(fooledProportionNumeric);

      switch (fooledProportion.type) {
        case FooledProportionType.none:
          break;
        case FooledProportionType.some:
          achievementsMap[whoseTurnId]!
              .add(achievements[AchievementId.fooledSome.name]!);
          break;
        case FooledProportionType.most:
          achievementsMap[whoseTurnId]!
              .add(achievements[AchievementId.fooledMost.name]!);
          break;
        case FooledProportionType.all:
          achievementsMap[whoseTurnId]!
              .add(achievements[AchievementId.fooledAll.name]!);
      }

      final String? fastestVoterId = playersVotedCorrectly.isEmpty
          ? null
          : (List.from(playersVotedCorrectly)
                ..sort((id1, id2) {
                  int vt1 = game.voteTimes[id1]?[roundNum] ?? 99999;
                  int vt2 = game.voteTimes[id2]?[roundNum] ?? 99999;
                  return vt1.compareTo(vt2);
                }))
              .first;

      final Map<String, Vote> votes =
          Map.fromIterable(game.playerOrder, value: (id) {
        final vote = game.votes[id]![roundNum];

        if (vote == 'p') return Vote(type: VoteType.player);

        final int? voteTime = game.voteTimes[id]?[roundNum];
        final bool isSaboteur = (id == saboteurId);

        if (vote == '-' || vote == 'n') {
          return Vote(
              type: VoteType.didNotVote,
              voteTime: voteTime,
              isSaboteur: isSaboteur);
        }

        final bool isCorrect =
            (isTruth && vote == 't') || (!isTruth && vote == 'l');
        final bool isFastest = (id == fastestVoterId);
        final bool isMinority = isCorrect && (fooledProportion.value < 0.5);

        if (isCorrect) {
          achievementsMap[id]!
              .add(achievements[AchievementId.correctVote.name]!);
        }
        if (isFastest) {
          achievementsMap[id]!
              .add(achievements[AchievementId.fastestVote.name]!);
        }
        if (isMinority) {
          achievementsMap[id]!
              .add(achievements[AchievementId.minorityVote.name]!);
        }

        if (vote == 't') {
          return Vote(
              type: VoteType.truth,
              isCorrect: isTruth,
              voteTime: voteTime,
              isSaboteur: isSaboteur,
              isFastest: isFastest,
              isMinority: isMinority);
        }

        if (vote == 'l') {
          return Vote(
              type: VoteType.lie,
              isCorrect: !isTruth,
              voteTime: voteTime,
              isSaboteur: isSaboteur,
              isFastest: isFastest,
              isMinority: isMinority);
        }

        return Vote(type: VoteType.unknown);
      });

      final breakdown = RoundBreakdown(
          whoseTurnId: whoseTurnId,
          isTruth: isTruth,
          eligibleVoters: eligibleVoters,
          playersVotedTrue: playersVotedTrue,
          playersVotedLie: playersVotedLie,
          playersNotVoted: playersNotVoted,
          saboteurId: saboteurId,
          saboteurVote: saboteurVote,
          fooledProportion: fooledProportion,
          votes: votes);

      roundBreakdowns.add(breakdown);
      playerAchievementsByRound.add(achievementsMap);
    }

    this.roundBreakdowns = List.from(roundBreakdowns);
    this.playerAchievementsByRound = List.from(playerAchievementsByRound);
  }

  void _generateScores() {
    _generateScoresByRound();
    _generateScoresTotal();
  }

  void _generatePlayerBreakdowns() {
    final List<PlayerBreakdown> playerBreakdowns = [];

    for (var i = 0; i < roundBreakdowns.length; i++) {
      final RoundBreakdown round = roundBreakdowns[i];
      final String id = roundBreakdowns[i].whoseTurnId;

      final String target = game.targets[id]!;
      final String? lieTarget = target == id ? null : target;
      final bool? lieTargetPlayedTruth =
          lieTarget == null ? null : game.truths[lieTarget]!;

      final int correctVotes = roundBreakdowns
          .where((rb) => rb.votes[id]?.isCorrect ?? false)
          .length;
      final int fastestVotes = roundBreakdowns
          .where((rb) => rb.votes[id]?.isFastest ?? false)
          .length;
      final int minorityVotes = roundBreakdowns
          .where((rb) => rb.votes[id]?.isMinority ?? false)
          .length;

      final thisPlayerScoresByRound =
          playerScoresByRound.map<int>((round) => round[id] ?? 0);
      final int totalScore = thisPlayerScoresByRound.reduce((v, e) => v + e);

      final playerBreakdown = PlayerBreakdown(
          playerId: id,
          turnNumber: i,
          ownRoundFooledProportion: round.fooledProportion,
          correctVotes: correctVotes,
          fastestCorrectVotes: fastestVotes,
          minorityVotes: minorityVotes,
          lieTarget: lieTarget,
          totalScore: totalScore,
          targetsLieTurnedOutTrue: lieTargetPlayedTruth,
          // TODO: All of below
          saboteursUncovered: 0,
          saboteurfooledProportion: FooledProportion(0));

      playerBreakdowns.add(playerBreakdown);
    }

    playerBreakdowns
        .sort((pb1, pb2) => pb2.totalScore.compareTo(pb1.totalScore));

    this.playerBreakdowns = List.from(playerBreakdowns);
  }

  void _generateScoresByRound() {
    final List<Map<String, int>> scoresByRound = [];

    for (Map<String, List<Achievement>> playerIdToAchievements
        in playerAchievementsByRound) {
      final Map<String, int> scores = {};

      for (String id in playerIdToAchievements.keys) {
        final List<Achievement> achievements = playerIdToAchievements[id]!;
        final int score = achievements.isEmpty
            ? 0
            : achievements.map((e) => e.score).reduce((v, e) => v + e);
        scores.addAll({id: score});
      }

      scoresByRound.add(scores);
    }

    playerScoresByRound = List.from(scoresByRound);
  }

  void _generateScoresTotal() {
    final Map<String, int> scoresTotal = {};
    for (String id in game.playerOrder) {
      final int score = playerScoresByRound
          .map((round) => round[id]!)
          .reduce((v, e) => v + e);
      scoresTotal.addAll({id: score});
    }

    playerScores = Map.from(scoresTotal);
  }
}

class Vote {
  final VoteType type;
  final bool? isSaboteur;
  final bool? isCorrect;
  final bool? isFastest;
  final bool? isMinority;
  final int? voteTime;

  Vote(
      {required this.type,
      this.isCorrect,
      this.voteTime,
      this.isFastest = false,
      this.isSaboteur = false,
      this.isMinority = false});
}

enum VoteType { truth, lie, didNotVote, saboteur, player, unknown }

class FooledProportion {
  FooledProportion(this.value) {
    if (value <= 0.0) {
      type = FooledProportionType.none;
    } else if (value <= 0.5)
      type = FooledProportionType.some;
    else if (value < 1.0)
      type = FooledProportionType.most;
    else
      type = FooledProportionType.all;
  }

  final double value;
  late final FooledProportionType type;
}

enum FooledProportionType { none, some, most, all }
