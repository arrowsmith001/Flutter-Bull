// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_notifier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CameraNotifierState {
  CameraState? get cameraState => throw _privateConstructorUsedError;
  CameraController? get controller => throw _privateConstructorUsedError;
  Uint8List? get lastPicture => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CameraNotifierStateCopyWith<CameraNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraNotifierStateCopyWith<$Res> {
  factory $CameraNotifierStateCopyWith(
          CameraNotifierState value, $Res Function(CameraNotifierState) then) =
      _$CameraNotifierStateCopyWithImpl<$Res, CameraNotifierState>;
  @useResult
  $Res call(
      {CameraState? cameraState,
      CameraController? controller,
      Uint8List? lastPicture});
}

/// @nodoc
class _$CameraNotifierStateCopyWithImpl<$Res, $Val extends CameraNotifierState>
    implements $CameraNotifierStateCopyWith<$Res> {
  _$CameraNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraState = freezed,
    Object? controller = freezed,
    Object? lastPicture = freezed,
  }) {
    return _then(_value.copyWith(
      cameraState: freezed == cameraState
          ? _value.cameraState
          : cameraState // ignore: cast_nullable_to_non_nullable
              as CameraState?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as CameraController?,
      lastPicture: freezed == lastPicture
          ? _value.lastPicture
          : lastPicture // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CameraNotifierStateImplCopyWith<$Res>
    implements $CameraNotifierStateCopyWith<$Res> {
  factory _$$CameraNotifierStateImplCopyWith(_$CameraNotifierStateImpl value,
          $Res Function(_$CameraNotifierStateImpl) then) =
      __$$CameraNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CameraState? cameraState,
      CameraController? controller,
      Uint8List? lastPicture});
}

/// @nodoc
class __$$CameraNotifierStateImplCopyWithImpl<$Res>
    extends _$CameraNotifierStateCopyWithImpl<$Res, _$CameraNotifierStateImpl>
    implements _$$CameraNotifierStateImplCopyWith<$Res> {
  __$$CameraNotifierStateImplCopyWithImpl(_$CameraNotifierStateImpl _value,
      $Res Function(_$CameraNotifierStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cameraState = freezed,
    Object? controller = freezed,
    Object? lastPicture = freezed,
  }) {
    return _then(_$CameraNotifierStateImpl(
      cameraState: freezed == cameraState
          ? _value.cameraState
          : cameraState // ignore: cast_nullable_to_non_nullable
              as CameraState?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as CameraController?,
      lastPicture: freezed == lastPicture
          ? _value.lastPicture
          : lastPicture // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$CameraNotifierStateImpl implements _CameraNotifierState {
  _$CameraNotifierStateImpl(
      {this.cameraState, this.controller, this.lastPicture});

  @override
  final CameraState? cameraState;
  @override
  final CameraController? controller;
  @override
  final Uint8List? lastPicture;

  @override
  String toString() {
    return 'CameraNotifierState(cameraState: $cameraState, controller: $controller, lastPicture: $lastPicture)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraNotifierStateImpl &&
            (identical(other.cameraState, cameraState) ||
                other.cameraState == cameraState) &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            const DeepCollectionEquality()
                .equals(other.lastPicture, lastPicture));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cameraState, controller,
      const DeepCollectionEquality().hash(lastPicture));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraNotifierStateImplCopyWith<_$CameraNotifierStateImpl> get copyWith =>
      __$$CameraNotifierStateImplCopyWithImpl<_$CameraNotifierStateImpl>(
          this, _$identity);
}

abstract class _CameraNotifierState implements CameraNotifierState {
  factory _CameraNotifierState(
      {final CameraState? cameraState,
      final CameraController? controller,
      final Uint8List? lastPicture}) = _$CameraNotifierStateImpl;

  @override
  CameraState? get cameraState;
  @override
  CameraController? get controller;
  @override
  Uint8List? get lastPicture;
  @override
  @JsonKey(ignore: true)
  _$$CameraNotifierStateImplCopyWith<_$CameraNotifierStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
