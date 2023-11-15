// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voting_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VotingPlayer {
  PublicPlayer get player => throw _privateConstructorUsedError;
  VoteStatus get voteStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VotingPlayerCopyWith<VotingPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VotingPlayerCopyWith<$Res> {
  factory $VotingPlayerCopyWith(
          VotingPlayer value, $Res Function(VotingPlayer) then) =
      _$VotingPlayerCopyWithImpl<$Res, VotingPlayer>;
  @useResult
  $Res call({PublicPlayer player, VoteStatus voteStatus});
}

/// @nodoc
class _$VotingPlayerCopyWithImpl<$Res, $Val extends VotingPlayer>
    implements $VotingPlayerCopyWith<$Res> {
  _$VotingPlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? voteStatus = null,
  }) {
    return _then(_value.copyWith(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PublicPlayer,
      voteStatus: null == voteStatus
          ? _value.voteStatus
          : voteStatus // ignore: cast_nullable_to_non_nullable
              as VoteStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VotingPlayerCopyWith<$Res>
    implements $VotingPlayerCopyWith<$Res> {
  factory _$$_VotingPlayerCopyWith(
          _$_VotingPlayer value, $Res Function(_$_VotingPlayer) then) =
      __$$_VotingPlayerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PublicPlayer player, VoteStatus voteStatus});
}

/// @nodoc
class __$$_VotingPlayerCopyWithImpl<$Res>
    extends _$VotingPlayerCopyWithImpl<$Res, _$_VotingPlayer>
    implements _$$_VotingPlayerCopyWith<$Res> {
  __$$_VotingPlayerCopyWithImpl(
      _$_VotingPlayer _value, $Res Function(_$_VotingPlayer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? voteStatus = null,
  }) {
    return _then(_$_VotingPlayer(
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as PublicPlayer,
      voteStatus: null == voteStatus
          ? _value.voteStatus
          : voteStatus // ignore: cast_nullable_to_non_nullable
              as VoteStatus,
    ));
  }
}

/// @nodoc

class _$_VotingPlayer implements _VotingPlayer {
  _$_VotingPlayer({required this.player, required this.voteStatus});

  @override
  final PublicPlayer player;
  @override
  final VoteStatus voteStatus;

  @override
  String toString() {
    return 'VotingPlayer(player: $player, voteStatus: $voteStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VotingPlayer &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.voteStatus, voteStatus) ||
                other.voteStatus == voteStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, player, voteStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VotingPlayerCopyWith<_$_VotingPlayer> get copyWith =>
      __$$_VotingPlayerCopyWithImpl<_$_VotingPlayer>(this, _$identity);
}

abstract class _VotingPlayer implements VotingPlayer {
  factory _VotingPlayer(
      {required final PublicPlayer player,
      required final VoteStatus voteStatus}) = _$_VotingPlayer;

  @override
  PublicPlayer get player;
  @override
  VoteStatus get voteStatus;
  @override
  @JsonKey(ignore: true)
  _$$_VotingPlayerCopyWith<_$_VotingPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}
