import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bull/src/custom/data/abstract/storage_service.dart';
import 'package:flutter_bull/src/model/achievement.dart';
import 'package:flutter_bull/src/model/player.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/services/data_layer.dart';
import 'package:flutter_bull/src/services/data_stream_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'achievement_notifier.g.dart';

@Riverpod(keepAlive: true)
class AchievementNotifier extends _$AchievementNotifier {
  
  DataService get _dbService => ref.read(dataServiceProvider);
  ImageStorageService get _imgService => ref.read(imageStorageServiceProvider);

  @override
  Future<AchievementWithIcon> build(String achievementId) async {

    final Achievement achievement = await _dbService.getAchievement(achievementId);
    final Uint8List iconData = await _imgService.downloadImage(achievement.iconPath);

    return AchievementWithIcon(achievement, iconData);
  }

}

class AchievementWithIcon {
  final Achievement achievement;
  final Uint8List? iconData;

  AchievementWithIcon(this.achievement, this.iconData);
}
