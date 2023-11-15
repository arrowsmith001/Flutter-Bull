// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_notifier_state_0.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ResultNotifierState0 {
  ResultGenerator get resultGenerator => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResultNotifierState0CopyWith<ResultNotifierState0> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultNotifierState0CopyWith<$Res> {
  factory $ResultNotifierState0CopyWith(ResultNotifierState0 value,
          $Res Function(ResultNotifierState0) then) =
      _$ResultNotifierState0CopyWithImpl<$Res, ResultNotifierState0>;
  @useResult
  $Res call({ResultGenerator resultGenerator});
}

/// @nodoc
class _$ResultNotifierState0CopyWithImpl<$Res,
        $Val extends ResultNotifierState0>
    implements $ResultNotifierState0CopyWith<$Res> {
  _$ResultNotifierState0CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultGenerator = null,
  }) {
    return _then(_value.copyWith(
      resultGenerator: null == resultGenerator
          ? _value.resultGenerator
          : resultGenerator // ignore: cast_nullable_to_non_nullable
              as ResultGenerator,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResultNotifierState0CopyWith<$Res>
    implements $ResultNotifierState0CopyWith<$Res> {
  factory _$$_ResultNotifierState0CopyWith(_$_ResultNotifierState0 value,
          $Res Function(_$_ResultNotifierState0) then) =
      __$$_ResultNotifierState0CopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ResultGenerator resultGenerator});
}

/// @nodoc
class __$$_ResultNotifierState0CopyWithImpl<$Res>
    extends _$ResultNotifierState0CopyWithImpl<$Res, _$_ResultNotifierState0>
    implements _$$_ResultNotifierState0CopyWith<$Res> {
  __$$_ResultNotifierState0CopyWithImpl(_$_ResultNotifierState0 _value,
      $Res Function(_$_ResultNotifierState0) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resultGenerator = null,
  }) {
    return _then(_$_ResultNotifierState0(
      resultGenerator: null == resultGenerator
          ? _value.resultGenerator
          : resultGenerator // ignore: cast_nullable_to_non_nullable
              as ResultGenerator,
    ));
  }
}

/// @nodoc

class _$_ResultNotifierState0 implements _ResultNotifierState0 {
  _$_ResultNotifierState0({required this.resultGenerator});

  @override
  final ResultGenerator resultGenerator;

  @override
  String toString() {
    return 'ResultNotifierState0._(resultGenerator: $resultGenerator)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ResultNotifierState0 &&
            (identical(other.resultGenerator, resultGenerator) ||
                other.resultGenerator == resultGenerator));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resultGenerator);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultNotifierState0CopyWith<_$_ResultNotifierState0> get copyWith =>
      __$$_ResultNotifierState0CopyWithImpl<_$_ResultNotifierState0>(
          this, _$identity);
}

abstract class _ResultNotifierState0 implements ResultNotifierState0 {
  factory _ResultNotifierState0(
          {required final ResultGenerator resultGenerator}) =
      _$_ResultNotifierState0;

  @override
  ResultGenerator get resultGenerator;
  @override
  @JsonKey(ignore: true)
  _$$_ResultNotifierState0CopyWith<_$_ResultNotifierState0> get copyWith =>
      throw _privateConstructorUsedError;
}
