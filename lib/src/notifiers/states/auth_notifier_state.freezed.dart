// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_notifier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthNotifierState {
  String? get userId => throw _privateConstructorUsedError;
  String? get route => throw _privateConstructorUsedError;
  bool? get playerProfileExists => throw _privateConstructorUsedError;
  bool? get isSigningUp => throw _privateConstructorUsedError;
  bool? get isValidatingSigningUp => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthNotifierStateCopyWith<AuthNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthNotifierStateCopyWith<$Res> {
  factory $AuthNotifierStateCopyWith(
          AuthNotifierState value, $Res Function(AuthNotifierState) then) =
      _$AuthNotifierStateCopyWithImpl<$Res, AuthNotifierState>;
  @useResult
  $Res call(
      {String? userId,
      String? route,
      bool? playerProfileExists,
      bool? isSigningUp,
      bool? isValidatingSigningUp,
      String message,
      String? errorMessage});
}

/// @nodoc
class _$AuthNotifierStateCopyWithImpl<$Res, $Val extends AuthNotifierState>
    implements $AuthNotifierStateCopyWith<$Res> {
  _$AuthNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? route = freezed,
    Object? playerProfileExists = freezed,
    Object? isSigningUp = freezed,
    Object? isValidatingSigningUp = freezed,
    Object? message = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      playerProfileExists: freezed == playerProfileExists
          ? _value.playerProfileExists
          : playerProfileExists // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSigningUp: freezed == isSigningUp
          ? _value.isSigningUp
          : isSigningUp // ignore: cast_nullable_to_non_nullable
              as bool?,
      isValidatingSigningUp: freezed == isValidatingSigningUp
          ? _value.isValidatingSigningUp
          : isValidatingSigningUp // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthNotifierStateCopyWith<$Res>
    implements $AuthNotifierStateCopyWith<$Res> {
  factory _$$_AuthNotifierStateCopyWith(_$_AuthNotifierState value,
          $Res Function(_$_AuthNotifierState) then) =
      __$$_AuthNotifierStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      String? route,
      bool? playerProfileExists,
      bool? isSigningUp,
      bool? isValidatingSigningUp,
      String message,
      String? errorMessage});
}

/// @nodoc
class __$$_AuthNotifierStateCopyWithImpl<$Res>
    extends _$AuthNotifierStateCopyWithImpl<$Res, _$_AuthNotifierState>
    implements _$$_AuthNotifierStateCopyWith<$Res> {
  __$$_AuthNotifierStateCopyWithImpl(
      _$_AuthNotifierState _value, $Res Function(_$_AuthNotifierState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? route = freezed,
    Object? playerProfileExists = freezed,
    Object? isSigningUp = freezed,
    Object? isValidatingSigningUp = freezed,
    Object? message = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_AuthNotifierState(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      route: freezed == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as String?,
      playerProfileExists: freezed == playerProfileExists
          ? _value.playerProfileExists
          : playerProfileExists // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSigningUp: freezed == isSigningUp
          ? _value.isSigningUp
          : isSigningUp // ignore: cast_nullable_to_non_nullable
              as bool?,
      isValidatingSigningUp: freezed == isValidatingSigningUp
          ? _value.isValidatingSigningUp
          : isValidatingSigningUp // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthNotifierState implements _AuthNotifierState {
  _$_AuthNotifierState(
      {this.userId,
      this.route,
      this.playerProfileExists,
      this.isSigningUp,
      this.isValidatingSigningUp,
      this.message = '',
      this.errorMessage});

  @override
  final String? userId;
  @override
  final String? route;
  @override
  final bool? playerProfileExists;
  @override
  final bool? isSigningUp;
  @override
  final bool? isValidatingSigningUp;
  @override
  @JsonKey()
  final String message;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthNotifierState(userId: $userId, route: $route, playerProfileExists: $playerProfileExists, isSigningUp: $isSigningUp, isValidatingSigningUp: $isValidatingSigningUp, message: $message, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthNotifierState &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.playerProfileExists, playerProfileExists) ||
                other.playerProfileExists == playerProfileExists) &&
            (identical(other.isSigningUp, isSigningUp) ||
                other.isSigningUp == isSigningUp) &&
            (identical(other.isValidatingSigningUp, isValidatingSigningUp) ||
                other.isValidatingSigningUp == isValidatingSigningUp) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      route,
      playerProfileExists,
      isSigningUp,
      isValidatingSigningUp,
      message,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthNotifierStateCopyWith<_$_AuthNotifierState> get copyWith =>
      __$$_AuthNotifierStateCopyWithImpl<_$_AuthNotifierState>(
          this, _$identity);
}

abstract class _AuthNotifierState implements AuthNotifierState {
  factory _AuthNotifierState(
      {final String? userId,
      final String? route,
      final bool? playerProfileExists,
      final bool? isSigningUp,
      final bool? isValidatingSigningUp,
      final String message,
      final String? errorMessage}) = _$_AuthNotifierState;

  @override
  String? get userId;
  @override
  String? get route;
  @override
  bool? get playerProfileExists;
  @override
  bool? get isSigningUp;
  @override
  bool? get isValidatingSigningUp;
  @override
  String get message;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_AuthNotifierStateCopyWith<_$_AuthNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}
