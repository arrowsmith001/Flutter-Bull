// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameRoom _$$_GameRoomFromJson(Map<String, dynamic> json) => _$_GameRoom(
      id: json['id'] as String?,
      roomCode: json['roomCode'] as String,
      phase: $enumDecodeNullable(_$GamePhaseEnumMap, json['phase']) ??
          GamePhase.lobby,
      subPhase: json['subPhase'] as int? ?? 0,
      playerIds: (json['playerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      targets: (json['targets'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      texts: (json['texts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      votes: (json['votes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      playerOrder: (json['playerOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      progress: json['progress'] as int? ?? 0,
      roundEndUTC: json['roundEndUTC'] as int?,
      settings: json['settings'] == null
          ? const GameRoomSettings(roundTimeSeconds: 60 * 3)
          : GameRoomSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GameRoomToJson(_$_GameRoom instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomCode': instance.roomCode,
      'phase': _$GamePhaseEnumMap[instance.phase]!,
      'subPhase': instance.subPhase,
      'playerIds': instance.playerIds,
      'targets': instance.targets,
      'texts': instance.texts,
      'votes': instance.votes,
      'playerOrder': instance.playerOrder,
      'progress': instance.progress,
      'roundEndUTC': instance.roundEndUTC,
      'settings': instance.settings,
    };

const _$GamePhaseEnumMap = {
  GamePhase.lobby: 0,
  GamePhase.writing: 1,
  GamePhase.round: 2,
  GamePhase.reveals: 3,
  GamePhase.results: 4,
};

_$_GameRoomSettings _$$_GameRoomSettingsFromJson(Map<String, dynamic> json) =>
    _$_GameRoomSettings(
      roundTimeSeconds: json['roundTimeSeconds'] as int,
    );

Map<String, dynamic> _$$_GameRoomSettingsToJson(_$_GameRoomSettings instance) =>
    <String, dynamic>{
      'roundTimeSeconds': instance.roundTimeSeconds,
    };
