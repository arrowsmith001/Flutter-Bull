import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';


@freezed
class Player extends Entity with _$Player {

   const factory Player({
    String? id,
    String? name,
    String? profilePhotoPath,
    String? occupiedRoomId,
    String? statusId,
  }) = _Player;


  factory Player.fromJson(Map<String, Object?> json)
      => _$PlayerFromJson(json);
}
