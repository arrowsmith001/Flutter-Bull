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
  AuthState? get authState => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get occupiedRoomId => throw _privateConstructorUsedError;
  bool? get profilePhotoExists => throw _privateConstructorUsedError;
  AuthError? get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

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
      {AuthState? authState,
      String? userId,
      String? occupiedRoomId,
      bool? profilePhotoExists,
      AuthError? error,
      String message});
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
    Object? authState = freezed,
    Object? userId = freezed,
    Object? occupiedRoomId = freezed,
    Object? profilePhotoExists = freezed,
    Object? error = freezed,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      authState: freezed == authState
          ? _value.authState
          : authState // ignore: cast_nullable_to_non_nullable
              as AuthState?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      occupiedRoomId: freezed == occupiedRoomId
          ? _value.occupiedRoomId
          : occupiedRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoExists: freezed == profilePhotoExists
          ? _value.profilePhotoExists
          : profilePhotoExists // ignore: cast_nullable_to_non_nullable
              as bool?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AuthError?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthNotifierStateImplCopyWith<$Res>
    implements $AuthNotifierStateCopyWith<$Res> {
  factory _$$AuthNotifierStateImplCopyWith(_$AuthNotifierStateImpl value,
          $Res Function(_$AuthNotifierStateImpl) then) =
      __$$AuthNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthState? authState,
      String? userId,
      String? occupiedRoomId,
      bool? profilePhotoExists,
      AuthError? error,
      String message});
}

/// @nodoc
class __$$AuthNotifierStateImplCopyWithImpl<$Res>
    extends _$AuthNotifierStateCopyWithImpl<$Res, _$AuthNotifierStateImpl>
    implements _$$AuthNotifierStateImplCopyWith<$Res> {
  __$$AuthNotifierStateImplCopyWithImpl(_$AuthNotifierStateImpl _value,
      $Res Function(_$AuthNotifierStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authState = freezed,
    Object? userId = freezed,
    Object? occupiedRoomId = freezed,
    Object? profilePhotoExists = freezed,
    Object? error = freezed,
    Object? message = null,
  }) {
    return _then(_$AuthNotifierStateImpl(
      authState: freezed == authState
          ? _value.authState
          : authState // ignore: cast_nullable_to_non_nullable
              as AuthState?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      occupiedRoomId: freezed == occupiedRoomId
          ? _value.occupiedRoomId
          : occupiedRoomId // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoExists: freezed == profilePhotoExists
          ? _value.profilePhotoExists
          : profilePhotoExists // ignore: cast_nullable_to_non_nullable
              as bool?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AuthError?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthNotifierStateImpl implements _AuthNotifierState {
  _$AuthNotifierStateImpl(
      {this.authState,
      this.userId,
      this.occupiedRoomId,
      this.profilePhotoExists,
      this.error,
      this.message = ''});

  @override
  final AuthState? authState;
  @override
  final String? userId;
  @override
  final String? occupiedRoomId;
  @override
  final bool? profilePhotoExists;
  @override
  final AuthError? error;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'AuthNotifierState(authState: $authState, userId: $userId, occupiedRoomId: $occupiedRoomId, profilePhotoExists: $profilePhotoExists, error: $error, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthNotifierStateImpl &&
            (identical(other.authState, authState) ||
                other.authState == authState) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.occupiedRoomId, occupiedRoomId) ||
                other.occupiedRoomId == occupiedRoomId) &&
            (identical(other.profilePhotoExists, profilePhotoExists) ||
                other.profilePhotoExists == profilePhotoExists) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authState, userId,
      occupiedRoomId, profilePhotoExists, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthNotifierStateImplCopyWith<_$AuthNotifierStateImpl> get copyWith =>
      __$$AuthNotifierStateImplCopyWithImpl<_$AuthNotifierStateImpl>(
          this, _$identity);
}

abstract class _AuthNotifierState implements AuthNotifierState {
  factory _AuthNotifierState(
      {final AuthState? authState,
      final String? userId,
      final String? occupiedRoomId,
      final bool? profilePhotoExists,
      final AuthError? error,
      final String message}) = _$AuthNotifierStateImpl;

  @override
  AuthState? get authState;
  @override
  String? get userId;
  @override
  String? get occupiedRoomId;
  @override
  bool? get profilePhotoExists;
  @override
  AuthError? get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$AuthNotifierStateImplCopyWith<_$AuthNotifierStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
