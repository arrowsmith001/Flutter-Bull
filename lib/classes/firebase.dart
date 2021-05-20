import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'firebase.g.dart';

class FirebasePaths {

}


@JsonSerializable()
class Player {
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  Player();

  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PROFILE_ID = 'profileId';
  static const String OCCUPIED_ROOM_CODE = 'occupiedRoomCode';

  String? id;
  String? name;
  String? profileId;
  String? occupiedRoomCode;

  @JsonKey(ignore: true)
  Image? profileImage;
}


@JsonSerializable()
class Profile{
  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  Profile();

  String? name;
  String? imageId;
}

@JsonSerializable()
class Room {

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);

  Room();

  static const String CODE = 'code';

  String? code;
  List<String> playerIds = [];

  @JsonKey(ignore: true)
  List<Player> players = [];
}