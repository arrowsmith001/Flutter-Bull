// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '3_reveals_phase_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RevealsPhaseViewModel {
  String get path => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RevealsPhaseViewModelCopyWith<RevealsPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevealsPhaseViewModelCopyWith<$Res> {
  factory $RevealsPhaseViewModelCopyWith(RevealsPhaseViewModel value,
          $Res Function(RevealsPhaseViewModel) then) =
      _$RevealsPhaseViewModelCopyWithImpl<$Res, RevealsPhaseViewModel>;
  @useResult
  $Res call({String path, int progress});
}

/// @nodoc
class _$RevealsPhaseViewModelCopyWithImpl<$Res,
        $Val extends RevealsPhaseViewModel>
    implements $RevealsPhaseViewModelCopyWith<$Res> {
  _$RevealsPhaseViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RevealsPhaseViewModelCopyWith<$Res>
    implements $RevealsPhaseViewModelCopyWith<$Res> {
  factory _$$_RevealsPhaseViewModelCopyWith(_$_RevealsPhaseViewModel value,
          $Res Function(_$_RevealsPhaseViewModel) then) =
      __$$_RevealsPhaseViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, int progress});
}

/// @nodoc
class __$$_RevealsPhaseViewModelCopyWithImpl<$Res>
    extends _$RevealsPhaseViewModelCopyWithImpl<$Res, _$_RevealsPhaseViewModel>
    implements _$$_RevealsPhaseViewModelCopyWith<$Res> {
  __$$_RevealsPhaseViewModelCopyWithImpl(_$_RevealsPhaseViewModel _value,
      $Res Function(_$_RevealsPhaseViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? progress = null,
  }) {
    return _then(_$_RevealsPhaseViewModel(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RevealsPhaseViewModel implements _RevealsPhaseViewModel {
  _$_RevealsPhaseViewModel({required this.path, required this.progress});

  @override
  final String path;
  @override
  final int progress;

  @override
  String toString() {
    return 'RevealsPhaseViewModel(path: $path, progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RevealsPhaseViewModel &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RevealsPhaseViewModelCopyWith<_$_RevealsPhaseViewModel> get copyWith =>
      __$$_RevealsPhaseViewModelCopyWithImpl<_$_RevealsPhaseViewModel>(
          this, _$identity);
}

abstract class _RevealsPhaseViewModel implements RevealsPhaseViewModel {
  factory _RevealsPhaseViewModel(
      {required final String path,
      required final int progress}) = _$_RevealsPhaseViewModel;

  @override
  String get path;
  @override
  int get progress;
  @override
  @JsonKey(ignore: true)
  _$$_RevealsPhaseViewModelCopyWith<_$_RevealsPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
