// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameRoomImpl _$$GameRoomImplFromJson(Map<String, dynamic> json) =>
    _$GameRoomImpl(
      id: json['id'] as String?,
      roomCode: json['roomCode'] as String,
      phase: $enumDecodeNullable(_$GamePhaseEnumMap, json['phase']),
      progress: json['progress'] as int? ?? 0,
      subPhase: json['subPhase'] as int? ?? 0,
      leaderId: json['leaderId'] as String?,
      state: json['state'] as String?,
      playerIds: (json['playerIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      playerOrder: (json['playerOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      playerStates: (json['playerStates'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, $enumDecode(_$PlayerStateEnumMap, e)),
          ) ??
          const {},
      targets: (json['targets'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      truths: (json['truths'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      texts: (json['texts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String?),
          ) ??
          const {},
      votes: (json['votes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, (e as List<dynamic>).map((e) => e as String).toList()),
          ) ??
          const {},
      voteTimes: (json['voteTimes'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, (e as List<dynamic>).map((e) => e as int).toList()),
          ) ??
          const {},
      roundEndUTC: json['roundEndUTC'] as int?,
      settings: json['settings'] == null
          ? const GameRoomSettings(roundTimeSeconds: 60 * 3)
          : GameRoomSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GameRoomImplToJson(_$GameRoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomCode': instance.roomCode,
      'phase': _$GamePhaseEnumMap[instance.phase],
      'progress': instance.progress,
      'subPhase': instance.subPhase,
      'leaderId': instance.leaderId,
      'state': instance.state,
      'playerIds': instance.playerIds,
      'playerOrder': instance.playerOrder,
      'playerStates': instance.playerStates
          .map((k, e) => MapEntry(k, _$PlayerStateEnumMap[e]!)),
      'targets': instance.targets,
      'truths': instance.truths,
      'texts': instance.texts,
      'votes': instance.votes,
      'voteTimes': instance.voteTimes,
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

const _$PlayerStateEnumMap = {
  PlayerState.unready: 0,
  PlayerState.ready: 1,
  PlayerState.inGame: 2,
};

_$GameRoomSettingsImpl _$$GameRoomSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$GameRoomSettingsImpl(
      roundTimeSeconds: json['roundTimeSeconds'] as int,
    );

Map<String, dynamic> _$$GameRoomSettingsImplToJson(
        _$GameRoomSettingsImpl instance) =>
    <String, dynamic>{
      'roundTimeSeconds': instance.roundTimeSeconds,
    };
