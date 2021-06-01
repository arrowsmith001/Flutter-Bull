import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'classes.dart';
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
  static const String SETTINGS_ALL_TRUTHS_POSSIBLE = 'allTruthsPossible';
  static const String SETTINGS_LEWD_HINTS_ENABLED = 'lewdHintsEnabled';
  static const String SETTINGS_ROUND_TIMER = 'roundTimer';

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);

  Room();

  Room.created(String roomCode, String creatorId){
    this
      ..code = roomCode
      ..playerIds = [ creatorId ]
      ..playerScores = { creatorId : 0 }
      ..settings = GameParams.DEFAULT_GAME_SETTINGS
      ..host = creatorId
      ..page = RoomPages.LOBBY
      ..turn = 0;
  }

  static const String CODE = 'code';
  static const String PAGE = 'page';
  static const String HOST = 'host';
  static const String TURN = 'turn';
  static const String SETTINGS = 'settings';
  static const String ROUND_START_UNIX = 'roundStartUnix';

  static const String PLAYER_IDS = 'playerIds';
  static const String PLAYER_ORDER = 'playerOrder';
  static const String PLAYER_TRUTHS = 'playerTruths';
  static const String PLAYER_TARGETS = 'playerTargets';
  static const String PLAYER_TEXTS = 'playerTexts';
  static const String PLAYER_PHASES = 'playerPhases';
  static const String PLAYER_VOTES = 'playerVotes';

  String? code;
  String? host;
  Map<String, dynamic> settings = GameParams.DEFAULT_GAME_SETTINGS;

  String? page;
  int? roundStartUnix = 0;
  int? turn = 0;
  int? revealed = 0;

  List<String>? playerIds = [];
  Map<String, int>? playerScores = {};

  List<String>? playerOrder;
  Map<String, String>? playerTargets;
  Map<String, bool>? playerTruths;
  Map<String, String>? playerTexts;
  Map<String, String>? playerPhases;
  Map<String, List<Vote>>? playerVotes;

}

// @JsonSerializable()
// class GameSettings {
//   factory GameSettings.fromJson(Map<String, dynamic> json) => _$GameSettingsFromJson(json);
//   Map<String, dynamic> toJson() => _$GameSettingsToJson(this);
//   GameSettings();
//
//   static const int DEFAULT_ROUND_TIMER = 3;
//
//   static const String ROUND_TIMER = 'roundTimer';
//   static const String ALL_TRUTHS_POSSIBLE = 'allTruthsPossible';
//   static const String LEWD_HINTS_ENABLED = 'lewdHintsEnabled';
//
//   int? roundTimer = DEFAULT_ROUND_TIMER;
//   bool? allTruthsPossible = true;
//   bool? lewdHintsEnabled = false;
// }


@JsonSerializable()
class Vote {

  factory Vote.fromJson(Map<String, dynamic> json) => _$VoteFromJson(json);
  Map<String, dynamic> toJson() => _$VoteToJson(this);

  static const String VOTED_TRUE = 'votedTrue';
  static const String TIME = 'time';
  static const String TYPE = 'type';

  static const String VOTE_TYPE_VOTER = 'v';
  static const String VOTE_TYPE_READER = 'r';
  static const String VOTE_TYPE_SABOTEUR = 's';

  Vote();

  String? type;
  bool? votedTrue; // null for Reader
  int? time;

  bool isReader() => votedTrue == null || type == Vote.VOTE_TYPE_READER; // null for Reader
}

class RoomPages {
  static const String LOBBY = 'lobby';
  static const String WRITE = 'write';
  static const String CHOOSE = 'choose';
  static const String PLAY = 'play';
  static const String REVEALS = 'reveals';
}

class PlayerPhases {
  static const String TEXT_ENTRY_CONFIRMED = 'textEntryConfirmed';
  static const String CHOOSE = 'choose';
  static const String PLAY = 'play';

}