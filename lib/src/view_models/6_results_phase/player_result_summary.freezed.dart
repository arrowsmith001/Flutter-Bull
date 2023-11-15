// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_result_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlayerResultSummary {
  String get playerId => throw _privateConstructorUsedError;
  List<PlayerResultSummaryItem> get items => throw _privateConstructorUsedError;
  int get roundScore => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerResultSummaryCopyWith<PlayerResultSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerResultSummaryCopyWith<$Res> {
  factory $PlayerResultSummaryCopyWith(
          PlayerResultSummary value, $Res Function(PlayerResultSummary) then) =
      _$PlayerResultSummaryCopyWithImpl<$Res, PlayerResultSummary>;
  @useResult
  $Res call(
      {String playerId, List<PlayerResultSummaryItem> items, int roundScore});
}

/// @nodoc
class _$PlayerResultSummaryCopyWithImpl<$Res, $Val extends PlayerResultSummary>
    implements $PlayerResultSummaryCopyWith<$Res> {
  _$PlayerResultSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? items = null,
    Object? roundScore = null,
  }) {
    return _then(_value.copyWith(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PlayerResultSummaryItem>,
      roundScore: null == roundScore
          ? _value.roundScore
          : roundScore // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerResultSummaryCopyWith<$Res>
    implements $PlayerResultSummaryCopyWith<$Res> {
  factory _$$_PlayerResultSummaryCopyWith(_$_PlayerResultSummary value,
          $Res Function(_$_PlayerResultSummary) then) =
      __$$_PlayerResultSummaryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String playerId, List<PlayerResultSummaryItem> items, int roundScore});
}

/// @nodoc
class __$$_PlayerResultSummaryCopyWithImpl<$Res>
    extends _$PlayerResultSummaryCopyWithImpl<$Res, _$_PlayerResultSummary>
    implements _$$_PlayerResultSummaryCopyWith<$Res> {
  __$$_PlayerResultSummaryCopyWithImpl(_$_PlayerResultSummary _value,
      $Res Function(_$_PlayerResultSummary) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? items = null,
    Object? roundScore = null,
  }) {
    return _then(_$_PlayerResultSummary(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PlayerResultSummaryItem>,
      roundScore: null == roundScore
          ? _value.roundScore
          : roundScore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_PlayerResultSummary implements _PlayerResultSummary {
  _$_PlayerResultSummary(
      {required this.playerId,
      required final List<PlayerResultSummaryItem> items,
      required this.roundScore})
      : _items = items;

  @override
  final String playerId;
  final List<PlayerResultSummaryItem> _items;
  @override
  List<PlayerResultSummaryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int roundScore;

  @override
  String toString() {
    return 'PlayerResultSummary(playerId: $playerId, items: $items, roundScore: $roundScore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerResultSummary &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.roundScore, roundScore) ||
                other.roundScore == roundScore));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerId,
      const DeepCollectionEquality().hash(_items), roundScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerResultSummaryCopyWith<_$_PlayerResultSummary> get copyWith =>
      __$$_PlayerResultSummaryCopyWithImpl<_$_PlayerResultSummary>(
          this, _$identity);
}

abstract class _PlayerResultSummary implements PlayerResultSummary {
  factory _PlayerResultSummary(
      {required final String playerId,
      required final List<PlayerResultSummaryItem> items,
      required final int roundScore}) = _$_PlayerResultSummary;

  @override
  String get playerId;
  @override
  List<PlayerResultSummaryItem> get items;
  @override
  int get roundScore;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerResultSummaryCopyWith<_$_PlayerResultSummary> get copyWith =>
      throw _privateConstructorUsedError;
}
