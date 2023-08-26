// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '4_reveal_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RevealViewModel {
  String get path => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RevealViewModelCopyWith<RevealViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevealViewModelCopyWith<$Res> {
  factory $RevealViewModelCopyWith(
          RevealViewModel value, $Res Function(RevealViewModel) then) =
      _$RevealViewModelCopyWithImpl<$Res, RevealViewModel>;
  @useResult
  $Res call({String path});
}

/// @nodoc
class _$RevealViewModelCopyWithImpl<$Res, $Val extends RevealViewModel>
    implements $RevealViewModelCopyWith<$Res> {
  _$RevealViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RevealsPhaseViewModelCopyWith<$Res>
    implements $RevealViewModelCopyWith<$Res> {
  factory _$$_RevealsPhaseViewModelCopyWith(_$_RevealsPhaseViewModel value,
          $Res Function(_$_RevealsPhaseViewModel) then) =
      __$$_RevealsPhaseViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path});
}

/// @nodoc
class __$$_RevealsPhaseViewModelCopyWithImpl<$Res>
    extends _$RevealViewModelCopyWithImpl<$Res, _$_RevealsPhaseViewModel>
    implements _$$_RevealsPhaseViewModelCopyWith<$Res> {
  __$$_RevealsPhaseViewModelCopyWithImpl(_$_RevealsPhaseViewModel _value,
      $Res Function(_$_RevealsPhaseViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
  }) {
    return _then(_$_RevealsPhaseViewModel(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RevealsPhaseViewModel implements _RevealsPhaseViewModel {
  _$_RevealsPhaseViewModel({required this.path});

  @override
  final String path;

  @override
  String toString() {
    return 'RevealViewModel(path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RevealsPhaseViewModel &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RevealsPhaseViewModelCopyWith<_$_RevealsPhaseViewModel> get copyWith =>
      __$$_RevealsPhaseViewModelCopyWithImpl<_$_RevealsPhaseViewModel>(
          this, _$identity);
}

abstract class _RevealsPhaseViewModel implements RevealViewModel {
  factory _RevealsPhaseViewModel({required final String path}) =
      _$_RevealsPhaseViewModel;

  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$_RevealsPhaseViewModelCopyWith<_$_RevealsPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
