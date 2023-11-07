// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameRoom _$GameRoomFromJson(Map<String, dynamic> json) {
  return _GameRoom.fromJson(json);
}

/// @nodoc
mixin _$GameRoom {
  String? get id => throw _privateConstructorUsedError; //String? resultId,
  String get roomCode => throw _privateConstructorUsedError;
  String? get leaderId => throw _privateConstructorUsedError;
  GamePhase get phase => throw _privateConstructorUsedError;
  int get subPhase => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  List<String> get playerIds => throw _privateConstructorUsedError;
  List<String> get playerOrder => throw _privateConstructorUsedError;
  Map<String, PlayerState> get playerStates =>
      throw _privateConstructorUsedError;
  Map<String, String> get targets => throw _privateConstructorUsedError;
  Map<String, bool> get truths => throw _privateConstructorUsedError;
  Map<String, String?> get texts => throw _privateConstructorUsedError;
  Map<String, List<String>> get votes => throw _privateConstructorUsedError;
  Map<String, List<int>> get voteTimes => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  int? get roundEndUTC => throw _privateConstructorUsedError;
  GameRoomSettings get settings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameRoomCopyWith<GameRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRoomCopyWith<$Res> {
  factory $GameRoomCopyWith(GameRoom value, $Res Function(GameRoom) then) =
      _$GameRoomCopyWithImpl<$Res, GameRoom>;
  @useResult
  $Res call(
      {String? id,
      String roomCode,
      String? leaderId,
      GamePhase phase,
      int subPhase,
      String? state,
      List<String> playerIds,
      List<String> playerOrder,
      Map<String, PlayerState> playerStates,
      Map<String, String> targets,
      Map<String, bool> truths,
      Map<String, String?> texts,
      Map<String, List<String>> votes,
      Map<String, List<int>> voteTimes,
      int progress,
      int? roundEndUTC,
      GameRoomSettings settings});

  $GameRoomSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$GameRoomCopyWithImpl<$Res, $Val extends GameRoom>
    implements $GameRoomCopyWith<$Res> {
  _$GameRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? roomCode = null,
    Object? leaderId = freezed,
    Object? phase = null,
    Object? subPhase = null,
    Object? state = freezed,
    Object? playerIds = null,
    Object? playerOrder = null,
    Object? playerStates = null,
    Object? targets = null,
    Object? truths = null,
    Object? texts = null,
    Object? votes = null,
    Object? voteTimes = null,
    Object? progress = null,
    Object? roundEndUTC = freezed,
    Object? settings = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      leaderId: freezed == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as String?,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as GamePhase,
      subPhase: null == subPhase
          ? _value.subPhase
          : subPhase // ignore: cast_nullable_to_non_nullable
              as int,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      playerIds: null == playerIds
          ? _value.playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playerOrder: null == playerOrder
          ? _value.playerOrder
          : playerOrder // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playerStates: null == playerStates
          ? _value.playerStates
          : playerStates // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayerState>,
      targets: null == targets
          ? _value.targets
          : targets // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      truths: null == truths
          ? _value.truths
          : truths // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      texts: null == texts
          ? _value.texts
          : texts // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      voteTimes: null == voteTimes
          ? _value.voteTimes
          : voteTimes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      roundEndUTC: freezed == roundEndUTC
          ? _value.roundEndUTC
          : roundEndUTC // ignore: cast_nullable_to_non_nullable
              as int?,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as GameRoomSettings,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameRoomSettingsCopyWith<$Res> get settings {
    return $GameRoomSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameRoomImplCopyWith<$Res>
    implements $GameRoomCopyWith<$Res> {
  factory _$$GameRoomImplCopyWith(
          _$GameRoomImpl value, $Res Function(_$GameRoomImpl) then) =
      __$$GameRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String roomCode,
      String? leaderId,
      GamePhase phase,
      int subPhase,
      String? state,
      List<String> playerIds,
      List<String> playerOrder,
      Map<String, PlayerState> playerStates,
      Map<String, String> targets,
      Map<String, bool> truths,
      Map<String, String?> texts,
      Map<String, List<String>> votes,
      Map<String, List<int>> voteTimes,
      int progress,
      int? roundEndUTC,
      GameRoomSettings settings});

  @override
  $GameRoomSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$GameRoomImplCopyWithImpl<$Res>
    extends _$GameRoomCopyWithImpl<$Res, _$GameRoomImpl>
    implements _$$GameRoomImplCopyWith<$Res> {
  __$$GameRoomImplCopyWithImpl(
      _$GameRoomImpl _value, $Res Function(_$GameRoomImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? roomCode = null,
    Object? leaderId = freezed,
    Object? phase = null,
    Object? subPhase = null,
    Object? state = freezed,
    Object? playerIds = null,
    Object? playerOrder = null,
    Object? playerStates = null,
    Object? targets = null,
    Object? truths = null,
    Object? texts = null,
    Object? votes = null,
    Object? voteTimes = null,
    Object? progress = null,
    Object? roundEndUTC = freezed,
    Object? settings = null,
  }) {
    return _then(_$GameRoomImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      leaderId: freezed == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as String?,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as GamePhase,
      subPhase: null == subPhase
          ? _value.subPhase
          : subPhase // ignore: cast_nullable_to_non_nullable
              as int,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      playerIds: null == playerIds
          ? _value._playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playerOrder: null == playerOrder
          ? _value._playerOrder
          : playerOrder // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playerStates: null == playerStates
          ? _value._playerStates
          : playerStates // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayerState>,
      targets: null == targets
          ? _value._targets
          : targets // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      truths: null == truths
          ? _value._truths
          : truths // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      texts: null == texts
          ? _value._texts
          : texts // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      votes: null == votes
          ? _value._votes
          : votes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      voteTimes: null == voteTimes
          ? _value._voteTimes
          : voteTimes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      roundEndUTC: freezed == roundEndUTC
          ? _value.roundEndUTC
          : roundEndUTC // ignore: cast_nullable_to_non_nullable
              as int?,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as GameRoomSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameRoomImpl implements _GameRoom {
  _$GameRoomImpl(
      {this.id,
      required this.roomCode,
      this.leaderId,
      this.phase = GamePhase.lobby,
      this.subPhase = 0,
      this.state,
      final List<String> playerIds = const [],
      final List<String> playerOrder = const [],
      final Map<String, PlayerState> playerStates = const {},
      final Map<String, String> targets = const {},
      final Map<String, bool> truths = const {},
      final Map<String, String?> texts = const {},
      final Map<String, List<String>> votes = const {},
      final Map<String, List<int>> voteTimes = const {},
      this.progress = 0,
      this.roundEndUTC,
      this.settings = const GameRoomSettings(roundTimeSeconds: 60 * 3)})
      : _playerIds = playerIds,
        _playerOrder = playerOrder,
        _playerStates = playerStates,
        _targets = targets,
        _truths = truths,
        _texts = texts,
        _votes = votes,
        _voteTimes = voteTimes;

  factory _$GameRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameRoomImplFromJson(json);

  @override
  final String? id;
//String? resultId,
  @override
  final String roomCode;
  @override
  final String? leaderId;
  @override
  @JsonKey()
  final GamePhase phase;
  @override
  @JsonKey()
  final int subPhase;
  @override
  final String? state;
  final List<String> _playerIds;
  @override
  @JsonKey()
  List<String> get playerIds {
    if (_playerIds is EqualUnmodifiableListView) return _playerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerIds);
  }

  final List<String> _playerOrder;
  @override
  @JsonKey()
  List<String> get playerOrder {
    if (_playerOrder is EqualUnmodifiableListView) return _playerOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerOrder);
  }

  final Map<String, PlayerState> _playerStates;
  @override
  @JsonKey()
  Map<String, PlayerState> get playerStates {
    if (_playerStates is EqualUnmodifiableMapView) return _playerStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerStates);
  }

  final Map<String, String> _targets;
  @override
  @JsonKey()
  Map<String, String> get targets {
    if (_targets is EqualUnmodifiableMapView) return _targets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_targets);
  }

  final Map<String, bool> _truths;
  @override
  @JsonKey()
  Map<String, bool> get truths {
    if (_truths is EqualUnmodifiableMapView) return _truths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_truths);
  }

  final Map<String, String?> _texts;
  @override
  @JsonKey()
  Map<String, String?> get texts {
    if (_texts is EqualUnmodifiableMapView) return _texts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_texts);
  }

  final Map<String, List<String>> _votes;
  @override
  @JsonKey()
  Map<String, List<String>> get votes {
    if (_votes is EqualUnmodifiableMapView) return _votes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_votes);
  }

  final Map<String, List<int>> _voteTimes;
  @override
  @JsonKey()
  Map<String, List<int>> get voteTimes {
    if (_voteTimes is EqualUnmodifiableMapView) return _voteTimes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_voteTimes);
  }

  @override
  @JsonKey()
  final int progress;
  @override
  final int? roundEndUTC;
  @override
  @JsonKey()
  final GameRoomSettings settings;

  @override
  String toString() {
    return 'GameRoom(id: $id, roomCode: $roomCode, leaderId: $leaderId, phase: $phase, subPhase: $subPhase, state: $state, playerIds: $playerIds, playerOrder: $playerOrder, playerStates: $playerStates, targets: $targets, truths: $truths, texts: $texts, votes: $votes, voteTimes: $voteTimes, progress: $progress, roundEndUTC: $roundEndUTC, settings: $settings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            (identical(other.leaderId, leaderId) ||
                other.leaderId == leaderId) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.subPhase, subPhase) ||
                other.subPhase == subPhase) &&
            (identical(other.state, state) || other.state == state) &&
            const DeepCollectionEquality()
                .equals(other._playerIds, _playerIds) &&
            const DeepCollectionEquality()
                .equals(other._playerOrder, _playerOrder) &&
            const DeepCollectionEquality()
                .equals(other._playerStates, _playerStates) &&
            const DeepCollectionEquality().equals(other._targets, _targets) &&
            const DeepCollectionEquality().equals(other._truths, _truths) &&
            const DeepCollectionEquality().equals(other._texts, _texts) &&
            const DeepCollectionEquality().equals(other._votes, _votes) &&
            const DeepCollectionEquality()
                .equals(other._voteTimes, _voteTimes) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.roundEndUTC, roundEndUTC) ||
                other.roundEndUTC == roundEndUTC) &&
            (identical(other.settings, settings) ||
                other.settings == settings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      roomCode,
      leaderId,
      phase,
      subPhase,
      state,
      const DeepCollectionEquality().hash(_playerIds),
      const DeepCollectionEquality().hash(_playerOrder),
      const DeepCollectionEquality().hash(_playerStates),
      const DeepCollectionEquality().hash(_targets),
      const DeepCollectionEquality().hash(_truths),
      const DeepCollectionEquality().hash(_texts),
      const DeepCollectionEquality().hash(_votes),
      const DeepCollectionEquality().hash(_voteTimes),
      progress,
      roundEndUTC,
      settings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameRoomImplCopyWith<_$GameRoomImpl> get copyWith =>
      __$$GameRoomImplCopyWithImpl<_$GameRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameRoomImplToJson(
      this,
    );
  }
}

abstract class _GameRoom implements GameRoom {
  factory _GameRoom(
      {final String? id,
      required final String roomCode,
      final String? leaderId,
      final GamePhase phase,
      final int subPhase,
      final String? state,
      final List<String> playerIds,
      final List<String> playerOrder,
      final Map<String, PlayerState> playerStates,
      final Map<String, String> targets,
      final Map<String, bool> truths,
      final Map<String, String?> texts,
      final Map<String, List<String>> votes,
      final Map<String, List<int>> voteTimes,
      final int progress,
      final int? roundEndUTC,
      final GameRoomSettings settings}) = _$GameRoomImpl;

  factory _GameRoom.fromJson(Map<String, dynamic> json) =
      _$GameRoomImpl.fromJson;

  @override
  String? get id;
  @override //String? resultId,
  String get roomCode;
  @override
  String? get leaderId;
  @override
  GamePhase get phase;
  @override
  int get subPhase;
  @override
  String? get state;
  @override
  List<String> get playerIds;
  @override
  List<String> get playerOrder;
  @override
  Map<String, PlayerState> get playerStates;
  @override
  Map<String, String> get targets;
  @override
  Map<String, bool> get truths;
  @override
  Map<String, String?> get texts;
  @override
  Map<String, List<String>> get votes;
  @override
  Map<String, List<int>> get voteTimes;
  @override
  int get progress;
  @override
  int? get roundEndUTC;
  @override
  GameRoomSettings get settings;
  @override
  @JsonKey(ignore: true)
  _$$GameRoomImplCopyWith<_$GameRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameRoomSettings _$GameRoomSettingsFromJson(Map<String, dynamic> json) {
  return _GameRoomSettings.fromJson(json);
}

/// @nodoc
mixin _$GameRoomSettings {
  int get roundTimeSeconds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameRoomSettingsCopyWith<GameRoomSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRoomSettingsCopyWith<$Res> {
  factory $GameRoomSettingsCopyWith(
          GameRoomSettings value, $Res Function(GameRoomSettings) then) =
      _$GameRoomSettingsCopyWithImpl<$Res, GameRoomSettings>;
  @useResult
  $Res call({int roundTimeSeconds});
}

/// @nodoc
class _$GameRoomSettingsCopyWithImpl<$Res, $Val extends GameRoomSettings>
    implements $GameRoomSettingsCopyWith<$Res> {
  _$GameRoomSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundTimeSeconds = null,
  }) {
    return _then(_value.copyWith(
      roundTimeSeconds: null == roundTimeSeconds
          ? _value.roundTimeSeconds
          : roundTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameRoomSettingsImplCopyWith<$Res>
    implements $GameRoomSettingsCopyWith<$Res> {
  factory _$$GameRoomSettingsImplCopyWith(_$GameRoomSettingsImpl value,
          $Res Function(_$GameRoomSettingsImpl) then) =
      __$$GameRoomSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int roundTimeSeconds});
}

/// @nodoc
class __$$GameRoomSettingsImplCopyWithImpl<$Res>
    extends _$GameRoomSettingsCopyWithImpl<$Res, _$GameRoomSettingsImpl>
    implements _$$GameRoomSettingsImplCopyWith<$Res> {
  __$$GameRoomSettingsImplCopyWithImpl(_$GameRoomSettingsImpl _value,
      $Res Function(_$GameRoomSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundTimeSeconds = null,
  }) {
    return _then(_$GameRoomSettingsImpl(
      roundTimeSeconds: null == roundTimeSeconds
          ? _value.roundTimeSeconds
          : roundTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameRoomSettingsImpl implements _GameRoomSettings {
  const _$GameRoomSettingsImpl({required this.roundTimeSeconds});

  factory _$GameRoomSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameRoomSettingsImplFromJson(json);

  @override
  final int roundTimeSeconds;

  @override
  String toString() {
    return 'GameRoomSettings(roundTimeSeconds: $roundTimeSeconds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameRoomSettingsImpl &&
            (identical(other.roundTimeSeconds, roundTimeSeconds) ||
                other.roundTimeSeconds == roundTimeSeconds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, roundTimeSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameRoomSettingsImplCopyWith<_$GameRoomSettingsImpl> get copyWith =>
      __$$GameRoomSettingsImplCopyWithImpl<_$GameRoomSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameRoomSettingsImplToJson(
      this,
    );
  }
}

abstract class _GameRoomSettings implements GameRoomSettings {
  const factory _GameRoomSettings({required final int roundTimeSeconds}) =
      _$GameRoomSettingsImpl;

  factory _GameRoomSettings.fromJson(Map<String, dynamic> json) =
      _$GameRoomSettingsImpl.fromJson;

  @override
  int get roundTimeSeconds;
  @override
  @JsonKey(ignore: true)
  _$$GameRoomSettingsImplCopyWith<_$GameRoomSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
