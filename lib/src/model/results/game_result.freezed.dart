// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameResult _$GameResultFromJson(Map<String, dynamic> json) {
  return _GameResult.fromJson(json);
}

/// @nodoc
mixin _$GameResult {
  String? get id => throw _privateConstructorUsedError;
  int get timeCreatedUTC => throw _privateConstructorUsedError;
  List<PlayerResult> get rankedPlayerResults =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameResultCopyWith<GameResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameResultCopyWith<$Res> {
  factory $GameResultCopyWith(
          GameResult value, $Res Function(GameResult) then) =
      _$GameResultCopyWithImpl<$Res, GameResult>;
  @useResult
  $Res call(
      {String? id, int timeCreatedUTC, List<PlayerResult> rankedPlayerResults});
}

/// @nodoc
class _$GameResultCopyWithImpl<$Res, $Val extends GameResult>
    implements $GameResultCopyWith<$Res> {
  _$GameResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? timeCreatedUTC = null,
    Object? rankedPlayerResults = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      timeCreatedUTC: null == timeCreatedUTC
          ? _value.timeCreatedUTC
          : timeCreatedUTC // ignore: cast_nullable_to_non_nullable
              as int,
      rankedPlayerResults: null == rankedPlayerResults
          ? _value.rankedPlayerResults
          : rankedPlayerResults // ignore: cast_nullable_to_non_nullable
              as List<PlayerResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameResultCopyWith<$Res>
    implements $GameResultCopyWith<$Res> {
  factory _$$_GameResultCopyWith(
          _$_GameResult value, $Res Function(_$_GameResult) then) =
      __$$_GameResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, int timeCreatedUTC, List<PlayerResult> rankedPlayerResults});
}

/// @nodoc
class __$$_GameResultCopyWithImpl<$Res>
    extends _$GameResultCopyWithImpl<$Res, _$_GameResult>
    implements _$$_GameResultCopyWith<$Res> {
  __$$_GameResultCopyWithImpl(
      _$_GameResult _value, $Res Function(_$_GameResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? timeCreatedUTC = null,
    Object? rankedPlayerResults = null,
  }) {
    return _then(_$_GameResult(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      timeCreatedUTC: null == timeCreatedUTC
          ? _value.timeCreatedUTC
          : timeCreatedUTC // ignore: cast_nullable_to_non_nullable
              as int,
      rankedPlayerResults: null == rankedPlayerResults
          ? _value._rankedPlayerResults
          : rankedPlayerResults // ignore: cast_nullable_to_non_nullable
              as List<PlayerResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameResult implements _GameResult {
  _$_GameResult(
      {this.id,
      required this.timeCreatedUTC,
      required final List<PlayerResult> rankedPlayerResults})
      : _rankedPlayerResults = rankedPlayerResults;

  factory _$_GameResult.fromJson(Map<String, dynamic> json) =>
      _$$_GameResultFromJson(json);

  @override
  final String? id;
  @override
  final int timeCreatedUTC;
  final List<PlayerResult> _rankedPlayerResults;
  @override
  List<PlayerResult> get rankedPlayerResults {
    if (_rankedPlayerResults is EqualUnmodifiableListView)
      return _rankedPlayerResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rankedPlayerResults);
  }

  @override
  String toString() {
    return 'GameResult(id: $id, timeCreatedUTC: $timeCreatedUTC, rankedPlayerResults: $rankedPlayerResults)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameResult &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timeCreatedUTC, timeCreatedUTC) ||
                other.timeCreatedUTC == timeCreatedUTC) &&
            const DeepCollectionEquality()
                .equals(other._rankedPlayerResults, _rankedPlayerResults));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, timeCreatedUTC,
      const DeepCollectionEquality().hash(_rankedPlayerResults));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameResultCopyWith<_$_GameResult> get copyWith =>
      __$$_GameResultCopyWithImpl<_$_GameResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameResultToJson(
      this,
    );
  }
}

abstract class _GameResult implements GameResult {
  factory _GameResult(
      {final String? id,
      required final int timeCreatedUTC,
      required final List<PlayerResult> rankedPlayerResults}) = _$_GameResult;

  factory _GameResult.fromJson(Map<String, dynamic> json) =
      _$_GameResult.fromJson;

  @override
  String? get id;
  @override
  int get timeCreatedUTC;
  @override
  List<PlayerResult> get rankedPlayerResults;
  @override
  @JsonKey(ignore: true)
  _$$_GameResultCopyWith<_$_GameResult> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerResult _$PlayerResultFromJson(Map<String, dynamic> json) {
  return _PlayerResult.fromJson(json);
}

/// @nodoc
mixin _$PlayerResult {
  List<PlayerRoundResult> get roundResults =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerResultCopyWith<PlayerResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerResultCopyWith<$Res> {
  factory $PlayerResultCopyWith(
          PlayerResult value, $Res Function(PlayerResult) then) =
      _$PlayerResultCopyWithImpl<$Res, PlayerResult>;
  @useResult
  $Res call({List<PlayerRoundResult> roundResults});
}

/// @nodoc
class _$PlayerResultCopyWithImpl<$Res, $Val extends PlayerResult>
    implements $PlayerResultCopyWith<$Res> {
  _$PlayerResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundResults = null,
  }) {
    return _then(_value.copyWith(
      roundResults: null == roundResults
          ? _value.roundResults
          : roundResults // ignore: cast_nullable_to_non_nullable
              as List<PlayerRoundResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerResultCopyWith<$Res>
    implements $PlayerResultCopyWith<$Res> {
  factory _$$_PlayerResultCopyWith(
          _$_PlayerResult value, $Res Function(_$_PlayerResult) then) =
      __$$_PlayerResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PlayerRoundResult> roundResults});
}

/// @nodoc
class __$$_PlayerResultCopyWithImpl<$Res>
    extends _$PlayerResultCopyWithImpl<$Res, _$_PlayerResult>
    implements _$$_PlayerResultCopyWith<$Res> {
  __$$_PlayerResultCopyWithImpl(
      _$_PlayerResult _value, $Res Function(_$_PlayerResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundResults = null,
  }) {
    return _then(_$_PlayerResult(
      roundResults: null == roundResults
          ? _value._roundResults
          : roundResults // ignore: cast_nullable_to_non_nullable
              as List<PlayerRoundResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayerResult implements _PlayerResult {
  _$_PlayerResult({required final List<PlayerRoundResult> roundResults})
      : _roundResults = roundResults;

  factory _$_PlayerResult.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerResultFromJson(json);

  final List<PlayerRoundResult> _roundResults;
  @override
  List<PlayerRoundResult> get roundResults {
    if (_roundResults is EqualUnmodifiableListView) return _roundResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roundResults);
  }

  @override
  String toString() {
    return 'PlayerResult(roundResults: $roundResults)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerResult &&
            const DeepCollectionEquality()
                .equals(other._roundResults, _roundResults));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_roundResults));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerResultCopyWith<_$_PlayerResult> get copyWith =>
      __$$_PlayerResultCopyWithImpl<_$_PlayerResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerResultToJson(
      this,
    );
  }
}

abstract class _PlayerResult implements PlayerResult {
  factory _PlayerResult({required final List<PlayerRoundResult> roundResults}) =
      _$_PlayerResult;

  factory _PlayerResult.fromJson(Map<String, dynamic> json) =
      _$_PlayerResult.fromJson;

  @override
  List<PlayerRoundResult> get roundResults;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerResultCopyWith<_$_PlayerResult> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerRoundResult _$PlayerRoundResultFromJson(Map<String, dynamic> json) {
  return _PlayerRoundResult.fromJson(json);
}

/// @nodoc
mixin _$PlayerRoundResult {
  int get score => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerRoundResultCopyWith<PlayerRoundResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerRoundResultCopyWith<$Res> {
  factory $PlayerRoundResultCopyWith(
          PlayerRoundResult value, $Res Function(PlayerRoundResult) then) =
      _$PlayerRoundResultCopyWithImpl<$Res, PlayerRoundResult>;
  @useResult
  $Res call({int score});
}

/// @nodoc
class _$PlayerRoundResultCopyWithImpl<$Res, $Val extends PlayerRoundResult>
    implements $PlayerRoundResultCopyWith<$Res> {
  _$PlayerRoundResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlayerRoundResultCopyWith<$Res>
    implements $PlayerRoundResultCopyWith<$Res> {
  factory _$$_PlayerRoundResultCopyWith(_$_PlayerRoundResult value,
          $Res Function(_$_PlayerRoundResult) then) =
      __$$_PlayerRoundResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int score});
}

/// @nodoc
class __$$_PlayerRoundResultCopyWithImpl<$Res>
    extends _$PlayerRoundResultCopyWithImpl<$Res, _$_PlayerRoundResult>
    implements _$$_PlayerRoundResultCopyWith<$Res> {
  __$$_PlayerRoundResultCopyWithImpl(
      _$_PlayerRoundResult _value, $Res Function(_$_PlayerRoundResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
  }) {
    return _then(_$_PlayerRoundResult(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayerRoundResult implements _PlayerRoundResult {
  _$_PlayerRoundResult({this.score = 0});

  factory _$_PlayerRoundResult.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerRoundResultFromJson(json);

  @override
  @JsonKey()
  final int score;

  @override
  String toString() {
    return 'PlayerRoundResult(score: $score)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlayerRoundResult &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlayerRoundResultCopyWith<_$_PlayerRoundResult> get copyWith =>
      __$$_PlayerRoundResultCopyWithImpl<_$_PlayerRoundResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerRoundResultToJson(
      this,
    );
  }
}

abstract class _PlayerRoundResult implements PlayerRoundResult {
  factory _PlayerRoundResult({final int score}) = _$_PlayerRoundResult;

  factory _PlayerRoundResult.fromJson(Map<String, dynamic> json) =
      _$_PlayerRoundResult.fromJson;

  @override
  int get score;
  @override
  @JsonKey(ignore: true)
  _$$_PlayerRoundResultCopyWith<_$_PlayerRoundResult> get copyWith =>
      throw _privateConstructorUsedError;
}
