// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Player _$$_PlayerFromJson(Map<String, dynamic> json) => _$_Player(
      id: json['id'] as String?,
      name: json['name'] as String?,
      profilePhotoPath: json['profilePhotoPath'] as String?,
      occupiedRoomId: json['occupiedRoomId'] as String?,
    );

Map<String, dynamic> _$$_PlayerToJson(_$_Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profilePhotoPath': instance.profilePhotoPath,
      'occupiedRoomId': instance.occupiedRoomId,
    };
