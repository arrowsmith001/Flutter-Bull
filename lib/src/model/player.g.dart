// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      json['id'] as String?,
      json['name'] as String,
    )
      ..profilePhotoPath = json['profilePhotoPath'] as String?
      ..occupiedRoomId = json['occupiedRoomId'] as String?;

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profilePhotoPath': instance.profilePhotoPath,
      'occupiedRoomId': instance.occupiedRoomId,
    };
