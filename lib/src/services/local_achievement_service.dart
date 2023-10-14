import 'package:flutter_bull/gen/assets.gen.dart';
import 'package:flutter_bull/src/custom/data/abstract/database_service.dart';
import 'package:flutter_bull/src/custom/data/abstract/repository.dart';
import 'package:flutter_bull/src/model/achievement.dart';
import 'package:logger/logger.dart';

class LocalAchievementService extends DatabaseService<Achievement> {
  final List<Achievement> achievements = [
    Achievement(
        id: AchievementId.correctVote.name,
        title: 'Correct Vote',
        description: 'description',
        score: 30,
        iconPath: Assets.images.icons.achievements.correct.path),
    Achievement(
        id: AchievementId.fooledAll.name,
        title: 'Fooled All',
        description: '* fooled the whole room',
        score: 30,
        iconPath: Assets.images.icons.achievements.fAll.path),
    Achievement(
        id: AchievementId.fooledMost.name,
        title: 'Fooled Most',
        description: '* fooled most of the room',
        score: 20,
        iconPath: Assets.images.icons.achievements.fMost.path),
    Achievement(
        id: AchievementId.fooledSome.name,
        title: 'Fooled Some',
        description: '* fooled some of the room',
        score: 10,
        iconPath: Assets.images.icons.achievements.fSome.path),
    Achievement(
        id: AchievementId.minorityVote.name,
        title: 'Voted in the Minority',
        description: '* voted correctly in the minority',
        score: 10,
        iconPath: Assets.images.icons.achievements.minority.path),
    Achievement(
        id: AchievementId.fastestVote.name,
        title: 'Quickest Correct Vote',
        description: '* voted correctly in the quickest time',
        score: 20,
        iconPath: Assets.images.icons.achievements.fastest.path),
    Achievement(
        id: AchievementId.lieTurnedOutTrue.name,
        title: 'Accidental Truth',
        description: 'The lie * wrote turned out to be true!',
        score: -30,
        iconPath: Assets.images.icons.achievements.saboteur.path),
  ];

//builder: (context, constraints) =>

  @override
  Future<Achievement> read(String id) async {
    return achievements.singleWhere((a) => a.id == id);
  }

  @override
  Future<int> countWhere(String fieldName, value) {
    throw UnimplementedError();
  }

  @override
  Future<Achievement> create(Achievement item) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String itemId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Achievement>> readMultiple(Iterable<String> ids) async {
    Logger().d('ids: $ids');
    Logger().d('achievements: $achievements');
    return achievements.where((a) => ids.contains(a.id)).toList();
  }

  @override
  Future<List<Achievement>> readWhere(String field, value) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(String itemId, String fieldName, value) {
    throw UnimplementedError();
  }

  List<Achievement> getAll() {
    return List.from(achievements);
  }
}
