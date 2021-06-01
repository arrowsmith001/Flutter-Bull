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
    ..host = json['host'] as String?
    ..settings = Map<String, dynamic>.from(json['settings'] as Map)
    ..page = json['page'] as String?
    ..roundStartUnix = json['roundStartUnix'] as int?
    ..turn = json['turn'] as int?
    ..revealed = json['revealed'] as int?
    ..playerIds =
        (json['playerIds'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..playerScores = (json['playerScores'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as int),
    )
    ..playerOrder = (json['playerOrder'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList()
    ..playerTargets = (json['playerTargets'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as String),
    )
    ..playerTruths = (json['playerTruths'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as bool),
    )
    ..playerTexts = (json['playerTexts'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as String),
    )
    ..playerPhases = (json['playerPhases'] as Map?)?.map(
      (k, e) => MapEntry(k as String, e as String),
    )
    ..playerVotes = (json['playerVotes'] as Map?)?.map(
      (k, e) => MapEntry(
          k as String,
          (e as List<dynamic>)
              .map((e) => Vote.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList()),
    );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'code': instance.code,
      'host': instance.host,
      'settings': instance.settings,
      'page': instance.page,
      'roundStartUnix': instance.roundStartUnix,
      'turn': instance.turn,
      'revealed': instance.revealed,
      'playerIds': instance.playerIds,
      'playerScores': instance.playerScores,
      'playerOrder': instance.playerOrder,
      'playerTargets': instance.playerTargets,
      'playerTruths': instance.playerTruths,
      'playerTexts': instance.playerTexts,
      'playerPhases': instance.playerPhases,
      'playerVotes': instance.playerVotes,
    };

Vote _$VoteFromJson(Map json) {
  return Vote()
    ..type = json['type'] as String?
    ..votedTrue = json['votedTrue'] as bool?
    ..time = json['time'] as int?;
}

Map<String, dynamic> _$VoteToJson(Vote instance) => <String, dynamic>{
      'type': instance.type,
      'votedTrue': instance.votedTrue,
      'time': instance.time,
    };
