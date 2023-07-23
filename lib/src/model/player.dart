import 'package:flutter_bull/src/custom/data/abstract/entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'player.g.dart';

@JsonSerializable()
class Player extends Entity {
  Player(super.id, this.name);
  String name;
  String? profilePhotoPath;
  String? occupiedRoomId;

  @override
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  factory Player.fromJson(Map<String, dynamic> map) => _$PlayerFromJson(map);

  @override
  Player clone() {
    return Player.fromJson(toJson());
  }

  @override
  Entity cloneWithId(String newId) {
    // TODO: implement cloneWithId
    throw UnimplementedError();
  }

  @override
  Player cloneWithUpdates(Map<String, dynamic> map) {
    return Player.fromJson(
        toJson()..updateAll((key, value) => map[key] ?? value));
  }
}
