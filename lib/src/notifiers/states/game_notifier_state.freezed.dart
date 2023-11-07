// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_notifier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameNotifierState {
  GameRoom get gameRoom => throw _privateConstructorUsedError;
  Map<String, PublicPlayer> get players => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameNotifierStateCopyWith<GameNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameNotifierStateCopyWith<$Res> {
  factory $GameNotifierStateCopyWith(
          GameNotifierState value, $Res Function(GameNotifierState) then) =
      _$GameNotifierStateCopyWithImpl<$Res, GameNotifierState>;
  @useResult
  $Res call({GameRoom gameRoom, Map<String, PublicPlayer> players});

  $GameRoomCopyWith<$Res> get gameRoom;
}

/// @nodoc
class _$GameNotifierStateCopyWithImpl<$Res, $Val extends GameNotifierState>
    implements $GameNotifierStateCopyWith<$Res> {
  _$GameNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameRoom = null,
    Object? players = null,
  }) {
    return _then(_value.copyWith(
      gameRoom: null == gameRoom
          ? _value.gameRoom
          : gameRoom // ignore: cast_nullable_to_non_nullable
              as GameRoom,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as Map<String, PublicPlayer>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameRoomCopyWith<$Res> get gameRoom {
    return $GameRoomCopyWith<$Res>(_value.gameRoom, (value) {
      return _then(_value.copyWith(gameRoom: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameNotifierStateImplCopyWith<$Res>
    implements $GameNotifierStateCopyWith<$Res> {
  factory _$$GameNotifierStateImplCopyWith(_$GameNotifierStateImpl value,
          $Res Function(_$GameNotifierStateImpl) then) =
      __$$GameNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GameRoom gameRoom, Map<String, PublicPlayer> players});

  @override
  $GameRoomCopyWith<$Res> get gameRoom;
}

/// @nodoc
class __$$GameNotifierStateImplCopyWithImpl<$Res>
    extends _$GameNotifierStateCopyWithImpl<$Res, _$GameNotifierStateImpl>
    implements _$$GameNotifierStateImplCopyWith<$Res> {
  __$$GameNotifierStateImplCopyWithImpl(_$GameNotifierStateImpl _value,
      $Res Function(_$GameNotifierStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameRoom = null,
    Object? players = null,
  }) {
    return _then(_$GameNotifierStateImpl(
      gameRoom: null == gameRoom
          ? _value.gameRoom
          : gameRoom // ignore: cast_nullable_to_non_nullable
              as GameRoom,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as Map<String, PublicPlayer>,
    ));
  }
}

/// @nodoc

class _$GameNotifierStateImpl extends _GameNotifierState {
  _$GameNotifierStateImpl(
      {required this.gameRoom,
      required final Map<String, PublicPlayer> players})
      : _players = players,
        super._();

  @override
  final GameRoom gameRoom;
  final Map<String, PublicPlayer> _players;
  @override
  Map<String, PublicPlayer> get players {
    if (_players is EqualUnmodifiableMapView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_players);
  }

  @override
  String toString() {
    return 'GameNotifierState(gameRoom: $gameRoom, players: $players)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameNotifierStateImpl &&
            (identical(other.gameRoom, gameRoom) ||
                other.gameRoom == gameRoom) &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, gameRoom, const DeepCollectionEquality().hash(_players));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameNotifierStateImplCopyWith<_$GameNotifierStateImpl> get copyWith =>
      __$$GameNotifierStateImplCopyWithImpl<_$GameNotifierStateImpl>(
          this, _$identity);
}

abstract class _GameNotifierState extends GameNotifierState {
  factory _GameNotifierState(
          {required final GameRoom gameRoom,
          required final Map<String, PublicPlayer> players}) =
      _$GameNotifierStateImpl;
  _GameNotifierState._() : super._();

  @override
  GameRoom get gameRoom;
  @override
  Map<String, PublicPlayer> get players;
  @override
  @JsonKey(ignore: true)
  _$$GameNotifierStateImplCopyWith<_$GameNotifierStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
