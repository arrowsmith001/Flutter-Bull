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
  Object? get phaseArgs => throw _privateConstructorUsedError;
  GameRoomStatePhase? get phase => throw _privateConstructorUsedError;
  List<String> get playerIds => throw _privateConstructorUsedError;

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
      Object? phaseArgs,
      GameRoomStatePhase? phase,
      List<String> playerIds});
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
    Object? phaseArgs = freezed,
    Object? phase = freezed,
    Object? playerIds = null,
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
      phaseArgs: freezed == phaseArgs ? _value.phaseArgs : phaseArgs,
      phase: freezed == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as GameRoomStatePhase?,
      playerIds: null == playerIds
          ? _value.playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      Object? phaseArgs,
      GameRoomStatePhase? phase,
      List<String> playerIds});
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
    Object? phaseArgs = freezed,
    Object? phase = freezed,
    Object? playerIds = null,
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
      phaseArgs: freezed == phaseArgs ? _value.phaseArgs : phaseArgs,
      phase: freezed == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as GameRoomStatePhase?,
      playerIds: null == playerIds
          ? _value._playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameRoom implements _GameRoom {
  _$_GameRoom(
      {this.id,
      required this.roomCode,
      this.phaseArgs,
      this.phase = GameRoomStatePhase.lobby,
      final List<String> playerIds = const []})
      : _playerIds = playerIds;

  factory _$_GameRoom.fromJson(Map<String, dynamic> json) =>
      _$$_GameRoomFromJson(json);

  @override
  final String? id;
  @override
  final String roomCode;
  @override
  final Object? phaseArgs;
  @override
  @JsonKey()
  final GameRoomStatePhase? phase;
  final List<String> _playerIds;
  @override
  @JsonKey()
  List<String> get playerIds {
    if (_playerIds is EqualUnmodifiableListView) return _playerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerIds);
  }

  @override
  String toString() {
    return 'GameRoom(id: $id, roomCode: $roomCode, phaseArgs: $phaseArgs, phase: $phase, playerIds: $playerIds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameRoom &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            const DeepCollectionEquality().equals(other.phaseArgs, phaseArgs) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            const DeepCollectionEquality()
                .equals(other._playerIds, _playerIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      roomCode,
      const DeepCollectionEquality().hash(phaseArgs),
      phase,
      const DeepCollectionEquality().hash(_playerIds));

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
      final Object? phaseArgs,
      final GameRoomStatePhase? phase,
      final List<String> playerIds}) = _$_GameRoom;

  factory _GameRoom.fromJson(Map<String, dynamic> json) = _$_GameRoom.fromJson;

  @override
  String? get id;
  @override
  String get roomCode;
  @override
  Object? get phaseArgs;
  @override
  GameRoomStatePhase? get phase;
  @override
  List<String> get playerIds;
  @override
  @JsonKey(ignore: true)
  _$$_GameRoomCopyWith<_$_GameRoom> get copyWith =>
      throw _privateConstructorUsedError;
}
