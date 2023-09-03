// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '4_result_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ResultViewModel {
  List<PlayerBreakdownViewModel> get playerBreakdown =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResultViewModelCopyWith<ResultViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultViewModelCopyWith<$Res> {
  factory $ResultViewModelCopyWith(
          ResultViewModel value, $Res Function(ResultViewModel) then) =
      _$ResultViewModelCopyWithImpl<$Res, ResultViewModel>;
  @useResult
  $Res call({List<PlayerBreakdownViewModel> playerBreakdown});
}

/// @nodoc
class _$ResultViewModelCopyWithImpl<$Res, $Val extends ResultViewModel>
    implements $ResultViewModelCopyWith<$Res> {
  _$ResultViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerBreakdown = null,
  }) {
    return _then(_value.copyWith(
      playerBreakdown: null == playerBreakdown
          ? _value.playerBreakdown
          : playerBreakdown // ignore: cast_nullable_to_non_nullable
              as List<PlayerBreakdownViewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResultViewModelCopyWith<$Res>
    implements $ResultViewModelCopyWith<$Res> {
  factory _$$_ResultViewModelCopyWith(
          _$_ResultViewModel value, $Res Function(_$_ResultViewModel) then) =
      __$$_ResultViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PlayerBreakdownViewModel> playerBreakdown});
}

/// @nodoc
class __$$_ResultViewModelCopyWithImpl<$Res>
    extends _$ResultViewModelCopyWithImpl<$Res, _$_ResultViewModel>
    implements _$$_ResultViewModelCopyWith<$Res> {
  __$$_ResultViewModelCopyWithImpl(
      _$_ResultViewModel _value, $Res Function(_$_ResultViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerBreakdown = null,
  }) {
    return _then(_$_ResultViewModel(
      playerBreakdown: null == playerBreakdown
          ? _value._playerBreakdown
          : playerBreakdown // ignore: cast_nullable_to_non_nullable
              as List<PlayerBreakdownViewModel>,
    ));
  }
}

/// @nodoc

class _$_ResultViewModel implements _ResultViewModel {
  _$_ResultViewModel(
      {required final List<PlayerBreakdownViewModel> playerBreakdown})
      : _playerBreakdown = playerBreakdown;

  final List<PlayerBreakdownViewModel> _playerBreakdown;
  @override
  List<PlayerBreakdownViewModel> get playerBreakdown {
    if (_playerBreakdown is EqualUnmodifiableListView) return _playerBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerBreakdown);
  }

  @override
  String toString() {
    return 'ResultViewModel._(playerBreakdown: $playerBreakdown)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResultViewModel &&
            const DeepCollectionEquality()
                .equals(other._playerBreakdown, _playerBreakdown));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_playerBreakdown));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultViewModelCopyWith<_$_ResultViewModel> get copyWith =>
      __$$_ResultViewModelCopyWithImpl<_$_ResultViewModel>(this, _$identity);
}

abstract class _ResultViewModel implements ResultViewModel {
  factory _ResultViewModel(
          {required final List<PlayerBreakdownViewModel> playerBreakdown}) =
      _$_ResultViewModel;

  @override
  List<PlayerBreakdownViewModel> get playerBreakdown;
  @override
  @JsonKey(ignore: true)
  _$$_ResultViewModelCopyWith<_$_ResultViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayerBreakdownViewModel {
  PlayerWithAvatar get playerWithAvatar => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get previousScore => throw _privateConstructorUsedError;
  int get scoreDifference => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerBreakdownViewModelCopyWith<PlayerBreakdownViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerBreakdownViewModelCopyWith<$Res> {
  factory $PlayerBreakdownViewModelCopyWith(PlayerBreakdownViewModel value,
          $Res Function(PlayerBreakdownViewModel) then) =
      _$PlayerBreakdownViewModelCopyWithImpl<$Res, PlayerBreakdownViewModel>;
  @useResult
  $Res call(
      {PlayerWithAvatar playerWithAvatar,
      int score,
      int previousScore,
      int scoreDifference});
}

/// @nodoc
class _$PlayerBreakdownViewModelCopyWithImpl<$Res,
        $Val extends PlayerBreakdownViewModel>
    implements $PlayerBreakdownViewModelCopyWith<$Res> {
  _$PlayerBreakdownViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerWithAvatar = null,
    Object? score = null,
    Object? previousScore = null,
    Object? scoreDifference = null,
  }) {
    return _then(_value.copyWith(
      playerWithAvatar: null == playerWithAvatar
          ? _value.playerWithAvatar
          : playerWithAvatar // ignore: cast_nullable_to_non_nullable
              as PlayerWithAvatar,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      previousScore: null == previousScore
          ? _value.previousScore
          : previousScore // ignore: cast_nullable_to_non_nullable
              as int,
      scoreDifference: null == scoreDifference
          ? _value.scoreDifference
          : scoreDifference // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerBreakdownViewModelCopyWith<$Res>
    implements $PlayerBreakdownViewModelCopyWith<$Res> {
  factory _$$_PlayerBreakdownViewModelCopyWith(
          _$_PlayerBreakdownViewModel value,
          $Res Function(_$_PlayerBreakdownViewModel) then) =
      __$$_PlayerBreakdownViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PlayerWithAvatar playerWithAvatar,
      int score,
      int previousScore,
      int scoreDifference});
}

/// @nodoc
class __$$_PlayerBreakdownViewModelCopyWithImpl<$Res>
    extends _$PlayerBreakdownViewModelCopyWithImpl<$Res,
        _$_PlayerBreakdownViewModel>
    implements _$$_PlayerBreakdownViewModelCopyWith<$Res> {
  __$$_PlayerBreakdownViewModelCopyWithImpl(_$_PlayerBreakdownViewModel _value,
      $Res Function(_$_PlayerBreakdownViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerWithAvatar = null,
    Object? score = null,
    Object? previousScore = null,
    Object? scoreDifference = null,
  }) {
    return _then(_$_PlayerBreakdownViewModel(
      playerWithAvatar: null == playerWithAvatar
          ? _value.playerWithAvatar
          : playerWithAvatar // ignore: cast_nullable_to_non_nullable
              as PlayerWithAvatar,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      previousScore: null == previousScore
          ? _value.previousScore
          : previousScore // ignore: cast_nullable_to_non_nullable
              as int,
      scoreDifference: null == scoreDifference
          ? _value.scoreDifference
          : scoreDifference // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PlayerBreakdownViewModel implements _PlayerBreakdownViewModel {
  _$_PlayerBreakdownViewModel(
      {required this.playerWithAvatar,
      required this.score,
      required this.previousScore,
      required this.scoreDifference});

  @override
  final PlayerWithAvatar playerWithAvatar;
  @override
  final int score;
  @override
  final int previousScore;
  @override
  final int scoreDifference;

  @override
  String toString() {
    return 'PlayerBreakdownViewModel(playerWithAvatar: $playerWithAvatar, score: $score, previousScore: $previousScore, scoreDifference: $scoreDifference)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerBreakdownViewModel &&
            (identical(other.playerWithAvatar, playerWithAvatar) ||
                other.playerWithAvatar == playerWithAvatar) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.previousScore, previousScore) ||
                other.previousScore == previousScore) &&
            (identical(other.scoreDifference, scoreDifference) ||
                other.scoreDifference == scoreDifference));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, playerWithAvatar, score, previousScore, scoreDifference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerBreakdownViewModelCopyWith<_$_PlayerBreakdownViewModel>
      get copyWith => __$$_PlayerBreakdownViewModelCopyWithImpl<
          _$_PlayerBreakdownViewModel>(this, _$identity);
}

abstract class _PlayerBreakdownViewModel implements PlayerBreakdownViewModel {
  factory _PlayerBreakdownViewModel(
      {required final PlayerWithAvatar playerWithAvatar,
      required final int score,
      required final int previousScore,
      required final int scoreDifference}) = _$_PlayerBreakdownViewModel;

  @override
  PlayerWithAvatar get playerWithAvatar;
  @override
  int get score;
  @override
  int get previousScore;
  @override
  int get scoreDifference;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerBreakdownViewModelCopyWith<_$_PlayerBreakdownViewModel>
      get copyWith => throw _privateConstructorUsedError;
}
