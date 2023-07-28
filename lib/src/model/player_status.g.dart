// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayerStatus _$$_PlayerStatusFromJson(Map<String, dynamic> json) =>
    _$_PlayerStatus(
      id: json['id'] as String?,
      errorMessage: json['errorMessage'] as String?,
      busy: json['busy'] as bool? ?? false,
      messageWhileBusy: json['messageWhileBusy'] as String? ?? '',
    );

Map<String, dynamic> _$$_PlayerStatusToJson(_$_PlayerStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'errorMessage': instance.errorMessage,
      'busy': instance.busy,
      'messageWhileBusy': instance.messageWhileBusy,
    };
