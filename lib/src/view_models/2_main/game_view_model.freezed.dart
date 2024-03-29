// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameViewModel {
  GamePath get path => throw _privateConstructorUsedError;
  PlayerState? get playerState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameViewModelCopyWith<GameViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameViewModelCopyWith<$Res> {
  factory $GameViewModelCopyWith(
          GameViewModel value, $Res Function(GameViewModel) then) =
      _$GameViewModelCopyWithImpl<$Res, GameViewModel>;
  @useResult
  $Res call({GamePath path, PlayerState? playerState});
}

/// @nodoc
class _$GameViewModelCopyWithImpl<$Res, $Val extends GameViewModel>
    implements $GameViewModelCopyWith<$Res> {
  _$GameViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? playerState = freezed,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as GamePath,
      playerState: freezed == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerState?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameViewModelCopyWith<$Res>
    implements $GameViewModelCopyWith<$Res> {
  factory _$$_GameViewModelCopyWith(
          _$_GameViewModel value, $Res Function(_$_GameViewModel) then) =
      __$$_GameViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GamePath path, PlayerState? playerState});
}

/// @nodoc
class __$$_GameViewModelCopyWithImpl<$Res>
    extends _$GameViewModelCopyWithImpl<$Res, _$_GameViewModel>
    implements _$$_GameViewModelCopyWith<$Res> {
  __$$_GameViewModelCopyWithImpl(
      _$_GameViewModel _value, $Res Function(_$_GameViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? playerState = freezed,
  }) {
    return _then(_$_GameViewModel(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as GamePath,
      playerState: freezed == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerState?,
    ));
  }
}

/// @nodoc

class _$_GameViewModel implements _GameViewModel {
  _$_GameViewModel({required this.path, required this.playerState});

  @override
  final GamePath path;
  @override
  final PlayerState? playerState;

  @override
  String toString() {
    return 'GameViewModel(path: $path, playerState: $playerState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameViewModel &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.playerState, playerState) ||
                other.playerState == playerState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, path, playerState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameViewModelCopyWith<_$_GameViewModel> get copyWith =>
      __$$_GameViewModelCopyWithImpl<_$_GameViewModel>(this, _$identity);
}

abstract class _GameViewModel implements GameViewModel {
  factory _GameViewModel(
      {required final GamePath path,
      required final PlayerState? playerState}) = _$_GameViewModel;

  @override
  GamePath get path;
  @override
  PlayerState? get playerState;
  @override
  @JsonKey(ignore: true)
  _$$_GameViewModelCopyWith<_$_GameViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
