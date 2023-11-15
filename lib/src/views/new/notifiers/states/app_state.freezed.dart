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
  AuthBarState get authBarState => throw _privateConstructorUsedError;
  SignUpPageState get signUpPageState => throw _privateConstructorUsedError;
  CameraViewState get cameraViewState => throw _privateConstructorUsedError;
  List<Busies> get busyWith => throw _privateConstructorUsedError;

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
      {AuthBarState authBarState,
      SignUpPageState signUpPageState,
      CameraViewState cameraViewState,
      List<Busies> busyWith});
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
    Object? authBarState = null,
    Object? signUpPageState = null,
    Object? cameraViewState = null,
    Object? busyWith = null,
  }) {
    return _then(_value.copyWith(
      authBarState: null == authBarState
          ? _value.authBarState
          : authBarState // ignore: cast_nullable_to_non_nullable
              as AuthBarState,
      signUpPageState: null == signUpPageState
          ? _value.signUpPageState
          : signUpPageState // ignore: cast_nullable_to_non_nullable
              as SignUpPageState,
      cameraViewState: null == cameraViewState
          ? _value.cameraViewState
          : cameraViewState // ignore: cast_nullable_to_non_nullable
              as CameraViewState,
      busyWith: null == busyWith
          ? _value.busyWith
          : busyWith // ignore: cast_nullable_to_non_nullable
              as List<Busies>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$$_AppStateCopyWith(
          _$_AppState value, $Res Function(_$_AppState) then) =
      __$$_AppStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthBarState authBarState,
      SignUpPageState signUpPageState,
      CameraViewState cameraViewState,
      List<Busies> busyWith});
}

/// @nodoc
class __$$_AppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppState>
    implements _$$_AppStateCopyWith<$Res> {
  __$$_AppStateCopyWithImpl(
      _$_AppState _value, $Res Function(_$_AppState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authBarState = null,
    Object? signUpPageState = null,
    Object? cameraViewState = null,
    Object? busyWith = null,
  }) {
    return _then(_$_AppState(
      authBarState: null == authBarState
          ? _value.authBarState
          : authBarState // ignore: cast_nullable_to_non_nullable
              as AuthBarState,
      signUpPageState: null == signUpPageState
          ? _value.signUpPageState
          : signUpPageState // ignore: cast_nullable_to_non_nullable
              as SignUpPageState,
      cameraViewState: null == cameraViewState
          ? _value.cameraViewState
          : cameraViewState // ignore: cast_nullable_to_non_nullable
              as CameraViewState,
      busyWith: null == busyWith
          ? _value._busyWith
          : busyWith // ignore: cast_nullable_to_non_nullable
              as List<Busies>,
    ));
  }
}

/// @nodoc

class _$_AppState implements _AppState {
  _$_AppState(
      {this.authBarState = AuthBarState.show,
      this.signUpPageState = SignUpPageState.closed,
      this.cameraViewState = CameraViewState.closed,
      final List<Busies> busyWith = const []})
      : _busyWith = busyWith;

  @override
  @JsonKey()
  final AuthBarState authBarState;
  @override
  @JsonKey()
  final SignUpPageState signUpPageState;
  @override
  @JsonKey()
  final CameraViewState cameraViewState;
  final List<Busies> _busyWith;
  @override
  @JsonKey()
  List<Busies> get busyWith {
    if (_busyWith is EqualUnmodifiableListView) return _busyWith;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_busyWith);
  }

  @override
  String toString() {
    return 'AppState(authBarState: $authBarState, signUpPageState: $signUpPageState, cameraViewState: $cameraViewState, busyWith: $busyWith)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppState &&
            (identical(other.authBarState, authBarState) ||
                other.authBarState == authBarState) &&
            (identical(other.signUpPageState, signUpPageState) ||
                other.signUpPageState == signUpPageState) &&
            (identical(other.cameraViewState, cameraViewState) ||
                other.cameraViewState == cameraViewState) &&
            const DeepCollectionEquality().equals(other._busyWith, _busyWith));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authBarState, signUpPageState,
      cameraViewState, const DeepCollectionEquality().hash(_busyWith));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      __$$_AppStateCopyWithImpl<_$_AppState>(this, _$identity);
}

abstract class _AppState implements AppState {
  factory _AppState(
      {final AuthBarState authBarState,
      final SignUpPageState signUpPageState,
      final CameraViewState cameraViewState,
      final List<Busies> busyWith}) = _$_AppState;

  @override
  AuthBarState get authBarState;
  @override
  SignUpPageState get signUpPageState;
  @override
  CameraViewState get cameraViewState;
  @override
  List<Busies> get busyWith;
  @override
  @JsonKey(ignore: true)
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
