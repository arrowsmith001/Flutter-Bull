// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_in_player_status_notifier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignedInPlayerStatusNotifierState {
  Player? get player => throw _privateConstructorUsedError;
  PlayerStatus? get status => throw _privateConstructorUsedError;
  bool get exists => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignedInPlayerStatusNotifierStateCopyWith<SignedInPlayerStatusNotifierState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignedInPlayerStatusNotifierStateCopyWith<$Res> {
  factory $SignedInPlayerStatusNotifierStateCopyWith(
          SignedInPlayerStatusNotifierState value,
          $Res Function(SignedInPlayerStatusNotifierState) then) =
      _$SignedInPlayerStatusNotifierStateCopyWithImpl<$Res,
          SignedInPlayerStatusNotifierState>;
  @useResult
  $Res call({Player? player, PlayerStatus? status, bool exists});

  $PlayerCopyWith<$Res>? get player;
  $PlayerStatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$SignedInPlayerStatusNotifierStateCopyWithImpl<$Res,
        $Val extends SignedInPlayerStatusNotifierState>
    implements $SignedInPlayerStatusNotifierStateCopyWith<$Res> {
  _$SignedInPlayerStatusNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = freezed,
    Object? status = freezed,
    Object? exists = null,
  }) {
    return _then(_value.copyWith(
      player: freezed == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus?,
      exists: null == exists
          ? _value.exists
          : exists // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res>? get player {
    if (_value.player == null) {
      return null;
    }

    return $PlayerCopyWith<$Res>(_value.player!, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerStatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $PlayerStatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignedInPlayerStatusNotifierStateImplCopyWith<$Res>
    implements $SignedInPlayerStatusNotifierStateCopyWith<$Res> {
  factory _$$SignedInPlayerStatusNotifierStateImplCopyWith(
          _$SignedInPlayerStatusNotifierStateImpl value,
          $Res Function(_$SignedInPlayerStatusNotifierStateImpl) then) =
      __$$SignedInPlayerStatusNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Player? player, PlayerStatus? status, bool exists});

  @override
  $PlayerCopyWith<$Res>? get player;
  @override
  $PlayerStatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$$SignedInPlayerStatusNotifierStateImplCopyWithImpl<$Res>
    extends _$SignedInPlayerStatusNotifierStateCopyWithImpl<$Res,
        _$SignedInPlayerStatusNotifierStateImpl>
    implements _$$SignedInPlayerStatusNotifierStateImplCopyWith<$Res> {
  __$$SignedInPlayerStatusNotifierStateImplCopyWithImpl(
      _$SignedInPlayerStatusNotifierStateImpl _value,
      $Res Function(_$SignedInPlayerStatusNotifierStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = freezed,
    Object? status = freezed,
    Object? exists = null,
  }) {
    return _then(_$SignedInPlayerStatusNotifierStateImpl(
      player: freezed == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as Player?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlayerStatus?,
      exists: null == exists
          ? _value.exists
          : exists // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SignedInPlayerStatusNotifierStateImpl
    implements _SignedInPlayerStatusNotifierState {
  _$SignedInPlayerStatusNotifierStateImpl(
      {this.player, this.status, required this.exists});

  @override
  final Player? player;
  @override
  final PlayerStatus? status;
  @override
  final bool exists;

  @override
  String toString() {
    return 'SignedInPlayerStatusNotifierState(player: $player, status: $status, exists: $exists)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedInPlayerStatusNotifierStateImpl &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.exists, exists) || other.exists == exists));
  }

  @override
  int get hashCode => Object.hash(runtimeType, player, status, exists);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignedInPlayerStatusNotifierStateImplCopyWith<
          _$SignedInPlayerStatusNotifierStateImpl>
      get copyWith => __$$SignedInPlayerStatusNotifierStateImplCopyWithImpl<
          _$SignedInPlayerStatusNotifierStateImpl>(this, _$identity);
}

abstract class _SignedInPlayerStatusNotifierState
    implements SignedInPlayerStatusNotifierState {
  factory _SignedInPlayerStatusNotifierState(
      {final Player? player,
      final PlayerStatus? status,
      required final bool exists}) = _$SignedInPlayerStatusNotifierStateImpl;

  @override
  Player? get player;
  @override
  PlayerStatus? get status;
  @override
  bool get exists;
  @override
  @JsonKey(ignore: true)
  _$$SignedInPlayerStatusNotifierStateImplCopyWith<
          _$SignedInPlayerStatusNotifierStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
