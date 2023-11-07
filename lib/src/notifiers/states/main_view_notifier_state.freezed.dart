// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_view_notifier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MainViewNotifierState {
  Player get signedInPlayer => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MainViewNotifierStateCopyWith<MainViewNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainViewNotifierStateCopyWith<$Res> {
  factory $MainViewNotifierStateCopyWith(MainViewNotifierState value,
          $Res Function(MainViewNotifierState) then) =
      _$MainViewNotifierStateCopyWithImpl<$Res, MainViewNotifierState>;
  @useResult
  $Res call({Player signedInPlayer});

  $PlayerCopyWith<$Res> get signedInPlayer;
}

/// @nodoc
class _$MainViewNotifierStateCopyWithImpl<$Res,
        $Val extends MainViewNotifierState>
    implements $MainViewNotifierStateCopyWith<$Res> {
  _$MainViewNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedInPlayer = null,
  }) {
    return _then(_value.copyWith(
      signedInPlayer: null == signedInPlayer
          ? _value.signedInPlayer
          : signedInPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get signedInPlayer {
    return $PlayerCopyWith<$Res>(_value.signedInPlayer, (value) {
      return _then(_value.copyWith(signedInPlayer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MainViewNotifierStateImplCopyWith<$Res>
    implements $MainViewNotifierStateCopyWith<$Res> {
  factory _$$MainViewNotifierStateImplCopyWith(
          _$MainViewNotifierStateImpl value,
          $Res Function(_$MainViewNotifierStateImpl) then) =
      __$$MainViewNotifierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Player signedInPlayer});

  @override
  $PlayerCopyWith<$Res> get signedInPlayer;
}

/// @nodoc
class __$$MainViewNotifierStateImplCopyWithImpl<$Res>
    extends _$MainViewNotifierStateCopyWithImpl<$Res,
        _$MainViewNotifierStateImpl>
    implements _$$MainViewNotifierStateImplCopyWith<$Res> {
  __$$MainViewNotifierStateImplCopyWithImpl(_$MainViewNotifierStateImpl _value,
      $Res Function(_$MainViewNotifierStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedInPlayer = null,
  }) {
    return _then(_$MainViewNotifierStateImpl(
      signedInPlayer: null == signedInPlayer
          ? _value.signedInPlayer
          : signedInPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
    ));
  }
}

/// @nodoc

class _$MainViewNotifierStateImpl implements _MainViewNotifierState {
  _$MainViewNotifierStateImpl({required this.signedInPlayer});

  @override
  final Player signedInPlayer;

  @override
  String toString() {
    return 'MainViewNotifierState(signedInPlayer: $signedInPlayer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainViewNotifierStateImpl &&
            (identical(other.signedInPlayer, signedInPlayer) ||
                other.signedInPlayer == signedInPlayer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signedInPlayer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainViewNotifierStateImplCopyWith<_$MainViewNotifierStateImpl>
      get copyWith => __$$MainViewNotifierStateImplCopyWithImpl<
          _$MainViewNotifierStateImpl>(this, _$identity);
}

abstract class _MainViewNotifierState implements MainViewNotifierState {
  factory _MainViewNotifierState({required final Player signedInPlayer}) =
      _$MainViewNotifierStateImpl;

  @override
  Player get signedInPlayer;
  @override
  @JsonKey(ignore: true)
  _$$MainViewNotifierStateImplCopyWith<_$MainViewNotifierStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
