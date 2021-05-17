// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map json) {
  return Player()
    ..id = json['id'] as String?
    ..name = json['name'] as String?
    ..profileId = json['profileId'] as String?
    ..occupiedRoomCode = json['occupiedRoomCode'] as String?;
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileId': instance.profileId,
      'occupiedRoomCode': instance.occupiedRoomCode,
    };

Profile _$ProfileFromJson(Map json) {
  return Profile()
    ..name = json['name'] as String?
    ..imageId = json['imageId'] as String?;
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'imageId': instance.imageId,
    };

Room _$RoomFromJson(Map json) {
  return Room()
    ..code = json['code'] as String?
    ..playerIds =
        (json['playerIds'] as List<dynamic>).map((e) => e as String).toList();
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'code': instance.code,
      'playerIds': instance.playerIds,
    };
