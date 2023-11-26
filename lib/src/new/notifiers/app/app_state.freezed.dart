// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  AuthBarState? get authBarState => throw _privateConstructorUsedError;
  SignUpPageState? get signUpPageState => throw _privateConstructorUsedError;
  CameraViewState? get cameraViewState => throw _privateConstructorUsedError;
  List<Busy> get busyWith => throw _privateConstructorUsedError;
  Busy? get nowBusy => throw _privateConstructorUsedError;
  Busy? get nowNotBusy => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {AuthBarState? authBarState,
      SignUpPageState? signUpPageState,
      CameraViewState? cameraViewState,
      List<Busy> busyWith,
      Busy? nowBusy,
      Busy? nowNotBusy});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authBarState = freezed,
    Object? signUpPageState = freezed,
    Object? cameraViewState = freezed,
    Object? busyWith = null,
    Object? nowBusy = freezed,
    Object? nowNotBusy = freezed,
  }) {
    return _then(_value.copyWith(
      authBarState: freezed == authBarState
          ? _value.authBarState
          : authBarState // ignore: cast_nullable_to_non_nullable
              as AuthBarState?,
      signUpPageState: freezed == signUpPageState
          ? _value.signUpPageState
          : signUpPageState // ignore: cast_nullable_to_non_nullable
              as SignUpPageState?,
      cameraViewState: freezed == cameraViewState
          ? _value.cameraViewState
          : cameraViewState // ignore: cast_nullable_to_non_nullable
              as CameraViewState?,
      busyWith: null == busyWith
          ? _value.busyWith
          : busyWith // ignore: cast_nullable_to_non_nullable
              as List<Busy>,
      nowBusy: freezed == nowBusy
          ? _value.nowBusy
          : nowBusy // ignore: cast_nullable_to_non_nullable
              as Busy?,
      nowNotBusy: freezed == nowNotBusy
          ? _value.nowNotBusy
          : nowNotBusy // ignore: cast_nullable_to_non_nullable
              as Busy?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthBarState? authBarState,
      SignUpPageState? signUpPageState,
      CameraViewState? cameraViewState,
      List<Busy> busyWith,
      Busy? nowBusy,
      Busy? nowNotBusy});
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authBarState = freezed,
    Object? signUpPageState = freezed,
    Object? cameraViewState = freezed,
    Object? busyWith = null,
    Object? nowBusy = freezed,
    Object? nowNotBusy = freezed,
  }) {
    return _then(_$AppStateImpl(
      authBarState: freezed == authBarState
          ? _value.authBarState
          : authBarState // ignore: cast_nullable_to_non_nullable
              as AuthBarState?,
      signUpPageState: freezed == signUpPageState
          ? _value.signUpPageState
          : signUpPageState // ignore: cast_nullable_to_non_nullable
              as SignUpPageState?,
      cameraViewState: freezed == cameraViewState
          ? _value.cameraViewState
          : cameraViewState // ignore: cast_nullable_to_non_nullable
              as CameraViewState?,
      busyWith: null == busyWith
          ? _value._busyWith
          : busyWith // ignore: cast_nullable_to_non_nullable
              as List<Busy>,
      nowBusy: freezed == nowBusy
          ? _value.nowBusy
          : nowBusy // ignore: cast_nullable_to_non_nullable
              as Busy?,
      nowNotBusy: freezed == nowNotBusy
          ? _value.nowNotBusy
          : nowNotBusy // ignore: cast_nullable_to_non_nullable
              as Busy?,
    ));
  }
}

/// @nodoc

class _$AppStateImpl implements _AppState {
  _$AppStateImpl(
      {this.authBarState,
      this.signUpPageState,
      this.cameraViewState,
      final List<Busy> busyWith = const [],
      this.nowBusy,
      this.nowNotBusy})
      : _busyWith = busyWith;

  @override
  final AuthBarState? authBarState;
  @override
  final SignUpPageState? signUpPageState;
  @override
  final CameraViewState? cameraViewState;
  final List<Busy> _busyWith;
  @override
  @JsonKey()
  List<Busy> get busyWith {
    if (_busyWith is EqualUnmodifiableListView) return _busyWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_busyWith);
  }

  @override
  final Busy? nowBusy;
  @override
  final Busy? nowNotBusy;

  @override
  String toString() {
    return 'AppState(authBarState: $authBarState, signUpPageState: $signUpPageState, cameraViewState: $cameraViewState, busyWith: $busyWith, nowBusy: $nowBusy, nowNotBusy: $nowNotBusy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.authBarState, authBarState) ||
                other.authBarState == authBarState) &&
            (identical(other.signUpPageState, signUpPageState) ||
                other.signUpPageState == signUpPageState) &&
            (identical(other.cameraViewState, cameraViewState) ||
                other.cameraViewState == cameraViewState) &&
            const DeepCollectionEquality().equals(other._busyWith, _busyWith) &&
            (identical(other.nowBusy, nowBusy) || other.nowBusy == nowBusy) &&
            (identical(other.nowNotBusy, nowNotBusy) ||
                other.nowNotBusy == nowNotBusy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      authBarState,
      signUpPageState,
      cameraViewState,
      const DeepCollectionEquality().hash(_busyWith),
      nowBusy,
      nowNotBusy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  factory _AppState(
      {final AuthBarState? authBarState,
      final SignUpPageState? signUpPageState,
      final CameraViewState? cameraViewState,
      final List<Busy> busyWith,
      final Busy? nowBusy,
      final Busy? nowNotBusy}) = _$AppStateImpl;

  @override
  AuthBarState? get authBarState;
  @override
  SignUpPageState? get signUpPageState;
  @override
  CameraViewState? get cameraViewState;
  @override
  List<Busy> get busyWith;
  @override
  Busy? get nowBusy;
  @override
  Busy? get nowNotBusy;
  @override
  @JsonKey(ignore: true)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
