// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      profilePhotoPath: json['profilePhotoPath'] as String?,
      occupiedRoomId: json['occupiedRoomId'] as String?,
      statusId: json['statusId'] as String?,
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profilePhotoPath': instance.profilePhotoPath,
      'occupiedRoomId': instance.occupiedRoomId,
      'statusId': instance.statusId,
    };
