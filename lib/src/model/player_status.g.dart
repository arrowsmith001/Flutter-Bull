// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerStatusImpl _$$PlayerStatusImplFromJson(Map<String, dynamic> json) =>
    _$PlayerStatusImpl(
      id: json['id'] as String?,
      errorMessage: json['errorMessage'] as String?,
      busy: json['busy'] as bool? ?? false,
      messageWhileBusy: json['messageWhileBusy'] as String? ?? '',
    );

Map<String, dynamic> _$$PlayerStatusImplToJson(_$PlayerStatusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'errorMessage': instance.errorMessage,
      'busy': instance.busy,
      'messageWhileBusy': instance.messageWhileBusy,
    };
