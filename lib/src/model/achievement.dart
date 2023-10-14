import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

@freezed
class Achievement extends Entity with _$Achievement
{
  factory Achievement({

    String? id,
    required String title,
    required String description,
    required int score,
    required String iconPath,

  }) = _Achievement;

  
  factory Achievement.fromJson(Map<String, Object?> json) => _$AchievementFromJson(json);

}


enum AchievementId {
  correctVote, fastestVote, fooledSome, fooledMost, fooledAll, minorityVote, lieTurnedOutTrue
}
