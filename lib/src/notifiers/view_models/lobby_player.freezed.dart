// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lobby_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LobbyPlayer {
  PublicPlayer get player => throw _privateConstructorUsedError;
  bool get isLeader => throw _privateConstructorUsedError;
  bool get isReady => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LobbyPlayerCopyWith<LobbyPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LobbyPlayerCopyWith<$Res> {
  factory $LobbyPlayerCopyWith(
          LobbyPlayer value, $Res Function(LobbyPlayer) then) =
      _$LobbyPlayerCopyWithImpl<$Res, LobbyPlayer>;
  @useResult
  $Res call({PublicPlayer player, bool isLeader, bool isReady});
}

/// @nodoc
class _$LobbyPlayerCopyWithImpl<$Res, $Val extends LobbyPlayer>
    implements $LobbyPlayerCopyWith<$Res> {
  _$LobbyPlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? isLeader = null,
    Object? isReady = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PublicPlayer,
      isLeader: null == isLeader
          ? _value.isLeader
          : isLeader // ignore: cast_nullable_to_non_nullable
              as bool,
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LobbyPlayerCopyWith<$Res>
    implements $LobbyPlayerCopyWith<$Res> {
  factory _$$_LobbyPlayerCopyWith(
          _$_LobbyPlayer value, $Res Function(_$_LobbyPlayer) then) =
      __$$_LobbyPlayerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PublicPlayer player, bool isLeader, bool isReady});
}

/// @nodoc
class __$$_LobbyPlayerCopyWithImpl<$Res>
    extends _$LobbyPlayerCopyWithImpl<$Res, _$_LobbyPlayer>
    implements _$$_LobbyPlayerCopyWith<$Res> {
  __$$_LobbyPlayerCopyWithImpl(
      _$_LobbyPlayer _value, $Res Function(_$_LobbyPlayer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? isLeader = null,
    Object? isReady = null,
  }) {
    return _then(_$_LobbyPlayer(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PublicPlayer,
      isLeader: null == isLeader
          ? _value.isLeader
          : isLeader // ignore: cast_nullable_to_non_nullable
              as bool,
      isReady: null == isReady
          ? _value.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LobbyPlayer implements _LobbyPlayer {
  _$_LobbyPlayer(
      {required this.player, required this.isLeader, required this.isReady});

  @override
  final PublicPlayer player;
  @override
  final bool isLeader;
  @override
  final bool isReady;

  @override
  String toString() {
    return 'LobbyPlayer(player: $player, isLeader: $isLeader, isReady: $isReady)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LobbyPlayer &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.isLeader, isLeader) ||
                other.isLeader == isLeader) &&
            (identical(other.isReady, isReady) || other.isReady == isReady));
  }

  @override
  int get hashCode => Object.hash(runtimeType, player, isLeader, isReady);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LobbyPlayerCopyWith<_$_LobbyPlayer> get copyWith =>
      __$$_LobbyPlayerCopyWithImpl<_$_LobbyPlayer>(this, _$identity);
}

abstract class _LobbyPlayer implements LobbyPlayer {
  factory _LobbyPlayer(
      {required final PublicPlayer player,
      required final bool isLeader,
      required final bool isReady}) = _$_LobbyPlayer;

  @override
  PublicPlayer get player;
  @override
  bool get isLeader;
  @override
  bool get isReady;
  @override
  @JsonKey(ignore: true)
  _$$_LobbyPlayerCopyWith<_$_LobbyPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}
