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
  String? get id => throw _privateConstructorUsedError;
  String get roomCode => throw _privateConstructorUsedError;
  GameRoomPhase? get phase => throw _privateConstructorUsedError;
  List<String> get playerIds => throw _privateConstructorUsedError;
  Map<String, String> get targets => throw _privateConstructorUsedError;
  Map<String, String> get texts => throw _privateConstructorUsedError;
  List<int> get playerOrder => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;

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
      GameRoomPhase? phase,
      List<String> playerIds,
      Map<String, String> targets,
      Map<String, String> texts,
      List<int> playerOrder,
      int progress});
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
    Object? phase = freezed,
    Object? playerIds = null,
    Object? targets = null,
    Object? texts = null,
    Object? playerOrder = null,
    Object? progress = null,
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
      phase: freezed == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as GameRoomPhase?,
      playerIds: null == playerIds
          ? _value.playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      targets: null == targets
          ? _value.targets
          : targets // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      texts: null == texts
          ? _value.texts
          : texts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      playerOrder: null == playerOrder
          ? _value.playerOrder
          : playerOrder // ignore: cast_nullable_to_non_nullable
              as List<int>,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameRoomCopyWith<$Res> implements $GameRoomCopyWith<$Res> {
  factory _$$_GameRoomCopyWith(
          _$_GameRoom value, $Res Function(_$_GameRoom) then) =
      __$$_GameRoomCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String roomCode,
      GameRoomPhase? phase,
      List<String> playerIds,
      Map<String, String> targets,
      Map<String, String> texts,
      List<int> playerOrder,
      int progress});
}

/// @nodoc
class __$$_GameRoomCopyWithImpl<$Res>
    extends _$GameRoomCopyWithImpl<$Res, _$_GameRoom>
    implements _$$_GameRoomCopyWith<$Res> {
  __$$_GameRoomCopyWithImpl(
      _$_GameRoom _value, $Res Function(_$_GameRoom) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? roomCode = null,
    Object? phase = freezed,
    Object? playerIds = null,
    Object? targets = null,
    Object? texts = null,
    Object? playerOrder = null,
    Object? progress = null,
  }) {
    return _then(_$_GameRoom(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      phase: freezed == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as GameRoomPhase?,
      playerIds: null == playerIds
          ? _value._playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      targets: null == targets
          ? _value._targets
          : targets // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      texts: null == texts
          ? _value._texts
          : texts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      playerOrder: null == playerOrder
          ? _value._playerOrder
          : playerOrder // ignore: cast_nullable_to_non_nullable
              as List<int>,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameRoom implements _GameRoom {
  _$_GameRoom(
      {this.id,
      required this.roomCode,
      this.phase = GameRoomPhase.lobby,
      final List<String> playerIds = const [],
      final Map<String, String> targets = const {},
      final Map<String, String> texts = const {},
      final List<int> playerOrder = const [],
      this.progress = 0})
      : _playerIds = playerIds,
        _targets = targets,
        _texts = texts,
        _playerOrder = playerOrder;

  factory _$_GameRoom.fromJson(Map<String, dynamic> json) =>
      _$$_GameRoomFromJson(json);

  @override
  final String? id;
  @override
  final String roomCode;
  @override
  @JsonKey()
  final GameRoomPhase? phase;
  final List<String> _playerIds;
  @override
  @JsonKey()
  List<String> get playerIds {
    if (_playerIds is EqualUnmodifiableListView) return _playerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerIds);
  }

  final Map<String, String> _targets;
  @override
  @JsonKey()
  Map<String, String> get targets {
    if (_targets is EqualUnmodifiableMapView) return _targets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_targets);
  }

  final Map<String, String> _texts;
  @override
  @JsonKey()
  Map<String, String> get texts {
    if (_texts is EqualUnmodifiableMapView) return _texts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_texts);
  }

  final List<int> _playerOrder;
  @override
  @JsonKey()
  List<int> get playerOrder {
    if (_playerOrder is EqualUnmodifiableListView) return _playerOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerOrder);
  }

  @override
  @JsonKey()
  final int progress;

  @override
  String toString() {
    return 'GameRoom(id: $id, roomCode: $roomCode, phase: $phase, playerIds: $playerIds, targets: $targets, texts: $texts, playerOrder: $playerOrder, progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameRoom &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            const DeepCollectionEquality()
                .equals(other._playerIds, _playerIds) &&
            const DeepCollectionEquality().equals(other._targets, _targets) &&
            const DeepCollectionEquality().equals(other._texts, _texts) &&
            const DeepCollectionEquality()
                .equals(other._playerOrder, _playerOrder) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      roomCode,
      phase,
      const DeepCollectionEquality().hash(_playerIds),
      const DeepCollectionEquality().hash(_targets),
      const DeepCollectionEquality().hash(_texts),
      const DeepCollectionEquality().hash(_playerOrder),
      progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameRoomCopyWith<_$_GameRoom> get copyWith =>
      __$$_GameRoomCopyWithImpl<_$_GameRoom>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameRoomToJson(
      this,
    );
  }
}

abstract class _GameRoom implements GameRoom {
  factory _GameRoom(
      {final String? id,
      required final String roomCode,
      final GameRoomPhase? phase,
      final List<String> playerIds,
      final Map<String, String> targets,
      final Map<String, String> texts,
      final List<int> playerOrder,
      final int progress}) = _$_GameRoom;

  factory _GameRoom.fromJson(Map<String, dynamic> json) = _$_GameRoom.fromJson;

  @override
  String? get id;
  @override
  String get roomCode;
  @override
  GameRoomPhase? get phase;
  @override
  List<String> get playerIds;
  @override
  Map<String, String> get targets;
  @override
  Map<String, String> get texts;
  @override
  List<int> get playerOrder;
  @override
  int get progress;
  @override
  @JsonKey(ignore: true)
  _$$_GameRoomCopyWith<_$_GameRoom> get copyWith =>
      throw _privateConstructorUsedError;
}
