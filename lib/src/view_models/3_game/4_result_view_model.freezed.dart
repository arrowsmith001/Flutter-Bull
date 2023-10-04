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
  Map<String, PlayerWithAvatar> get playerMap =>
      throw _privateConstructorUsedError;
  List<PlayerResultSummary> get playerResultSummaries =>
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
  $Res call(
      {Map<String, PlayerWithAvatar> playerMap,
      List<PlayerResultSummary> playerResultSummaries});
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
    Object? playerMap = null,
    Object? playerResultSummaries = null,
  }) {
    return _then(_value.copyWith(
      playerMap: null == playerMap
          ? _value.playerMap
          : playerMap // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayerWithAvatar>,
      playerResultSummaries: null == playerResultSummaries
          ? _value.playerResultSummaries
          : playerResultSummaries // ignore: cast_nullable_to_non_nullable
              as List<PlayerResultSummary>,
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
  $Res call(
      {Map<String, PlayerWithAvatar> playerMap,
      List<PlayerResultSummary> playerResultSummaries});
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
    Object? playerMap = null,
    Object? playerResultSummaries = null,
  }) {
    return _then(_$_ResultViewModel(
      playerMap: null == playerMap
          ? _value._playerMap
          : playerMap // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayerWithAvatar>,
      playerResultSummaries: null == playerResultSummaries
          ? _value._playerResultSummaries
          : playerResultSummaries // ignore: cast_nullable_to_non_nullable
              as List<PlayerResultSummary>,
    ));
  }
}

/// @nodoc

class _$_ResultViewModel implements _ResultViewModel {
  _$_ResultViewModel(
      {required final Map<String, PlayerWithAvatar> playerMap,
      required final List<PlayerResultSummary> playerResultSummaries})
      : _playerMap = playerMap,
        _playerResultSummaries = playerResultSummaries;

  final Map<String, PlayerWithAvatar> _playerMap;
  @override
  Map<String, PlayerWithAvatar> get playerMap {
    if (_playerMap is EqualUnmodifiableMapView) return _playerMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerMap);
  }

  final List<PlayerResultSummary> _playerResultSummaries;
  @override
  List<PlayerResultSummary> get playerResultSummaries {
    if (_playerResultSummaries is EqualUnmodifiableListView)
      return _playerResultSummaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerResultSummaries);
  }

  @override
  String toString() {
    return 'ResultViewModel._(playerMap: $playerMap, playerResultSummaries: $playerResultSummaries)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResultViewModel &&
            const DeepCollectionEquality()
                .equals(other._playerMap, _playerMap) &&
            const DeepCollectionEquality()
                .equals(other._playerResultSummaries, _playerResultSummaries));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_playerMap),
      const DeepCollectionEquality().hash(_playerResultSummaries));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultViewModelCopyWith<_$_ResultViewModel> get copyWith =>
      __$$_ResultViewModelCopyWithImpl<_$_ResultViewModel>(this, _$identity);
}

abstract class _ResultViewModel implements ResultViewModel {
  factory _ResultViewModel(
          {required final Map<String, PlayerWithAvatar> playerMap,
          required final List<PlayerResultSummary> playerResultSummaries}) =
      _$_ResultViewModel;

  @override
  Map<String, PlayerWithAvatar> get playerMap;
  @override
  List<PlayerResultSummary> get playerResultSummaries;
  @override
  @JsonKey(ignore: true)
  _$$_ResultViewModelCopyWith<_$_ResultViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
