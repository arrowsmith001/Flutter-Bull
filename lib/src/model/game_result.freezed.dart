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
  List<RoundResult> get result => throw _privateConstructorUsedError;

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
  $Res call({String? id, int timeCreatedUTC, List<RoundResult> result});
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
    Object? result = null,
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
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<RoundResult>,
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
  $Res call({String? id, int timeCreatedUTC, List<RoundResult> result});
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
    Object? result = null,
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
      result: null == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as List<RoundResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameResult implements _GameResult {
  _$_GameResult(
      {this.id,
      required this.timeCreatedUTC,
      required final List<RoundResult> result})
      : _result = result;

  factory _$_GameResult.fromJson(Map<String, dynamic> json) =>
      _$$_GameResultFromJson(json);

  @override
  final String? id;
  @override
  final int timeCreatedUTC;
  final List<RoundResult> _result;
  @override
  List<RoundResult> get result {
    if (_result is EqualUnmodifiableListView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_result);
  }

  @override
  String toString() {
    return 'GameResult(id: $id, timeCreatedUTC: $timeCreatedUTC, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameResult &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timeCreatedUTC, timeCreatedUTC) ||
                other.timeCreatedUTC == timeCreatedUTC) &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, timeCreatedUTC,
      const DeepCollectionEquality().hash(_result));

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
      required final List<RoundResult> result}) = _$_GameResult;

  factory _GameResult.fromJson(Map<String, dynamic> json) =
      _$_GameResult.fromJson;

  @override
  String? get id;
  @override
  int get timeCreatedUTC;
  @override
  List<RoundResult> get result;
  @override
  @JsonKey(ignore: true)
  _$$_GameResultCopyWith<_$_GameResult> get copyWith =>
      throw _privateConstructorUsedError;
}

RoundResult _$RoundResultFromJson(Map<String, dynamic> json) {
  return _RoundResult.fromJson(json);
}

/// @nodoc
mixin _$RoundResult {
  Map<String, List<String>> get playersToAchievements =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoundResultCopyWith<RoundResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoundResultCopyWith<$Res> {
  factory $RoundResultCopyWith(
          RoundResult value, $Res Function(RoundResult) then) =
      _$RoundResultCopyWithImpl<$Res, RoundResult>;
  @useResult
  $Res call({Map<String, List<String>> playersToAchievements});
}

/// @nodoc
class _$RoundResultCopyWithImpl<$Res, $Val extends RoundResult>
    implements $RoundResultCopyWith<$Res> {
  _$RoundResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playersToAchievements = null,
  }) {
    return _then(_value.copyWith(
      playersToAchievements: null == playersToAchievements
          ? _value.playersToAchievements
          : playersToAchievements // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoundResultCopyWith<$Res>
    implements $RoundResultCopyWith<$Res> {
  factory _$$_RoundResultCopyWith(
          _$_RoundResult value, $Res Function(_$_RoundResult) then) =
      __$$_RoundResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, List<String>> playersToAchievements});
}

/// @nodoc
class __$$_RoundResultCopyWithImpl<$Res>
    extends _$RoundResultCopyWithImpl<$Res, _$_RoundResult>
    implements _$$_RoundResultCopyWith<$Res> {
  __$$_RoundResultCopyWithImpl(
      _$_RoundResult _value, $Res Function(_$_RoundResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playersToAchievements = null,
  }) {
    return _then(_$_RoundResult(
      playersToAchievements: null == playersToAchievements
          ? _value._playersToAchievements
          : playersToAchievements // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RoundResult implements _RoundResult {
  _$_RoundResult(
      {required final Map<String, List<String>> playersToAchievements})
      : _playersToAchievements = playersToAchievements;

  factory _$_RoundResult.fromJson(Map<String, dynamic> json) =>
      _$$_RoundResultFromJson(json);

  final Map<String, List<String>> _playersToAchievements;
  @override
  Map<String, List<String>> get playersToAchievements {
    if (_playersToAchievements is EqualUnmodifiableMapView)
      return _playersToAchievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playersToAchievements);
  }

  @override
  String toString() {
    return 'RoundResult(playersToAchievements: $playersToAchievements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoundResult &&
            const DeepCollectionEquality()
                .equals(other._playersToAchievements, _playersToAchievements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_playersToAchievements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoundResultCopyWith<_$_RoundResult> get copyWith =>
      __$$_RoundResultCopyWithImpl<_$_RoundResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoundResultToJson(
      this,
    );
  }
}

abstract class _RoundResult implements RoundResult {
  factory _RoundResult(
          {required final Map<String, List<String>> playersToAchievements}) =
      _$_RoundResult;

  factory _RoundResult.fromJson(Map<String, dynamic> json) =
      _$_RoundResult.fromJson;

  @override
  Map<String, List<String>> get playersToAchievements;
  @override
  @JsonKey(ignore: true)
  _$$_RoundResultCopyWith<_$_RoundResult> get copyWith =>
      throw _privateConstructorUsedError;
}
