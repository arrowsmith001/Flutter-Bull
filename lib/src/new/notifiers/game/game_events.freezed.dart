// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameEvents {
  List<LobbyPlayer>? get newPresentPlayers =>
      throw _privateConstructorUsedError;
  GameRoute? get newGameRoute => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameEventsCopyWith<GameEvents> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventsCopyWith<$Res> {
  factory $GameEventsCopyWith(
          GameEvents value, $Res Function(GameEvents) then) =
      _$GameEventsCopyWithImpl<$Res, GameEvents>;
  @useResult
  $Res call({List<LobbyPlayer>? newPresentPlayers, GameRoute? newGameRoute});
}

/// @nodoc
class _$GameEventsCopyWithImpl<$Res, $Val extends GameEvents>
    implements $GameEventsCopyWith<$Res> {
  _$GameEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPresentPlayers = freezed,
    Object? newGameRoute = freezed,
  }) {
    return _then(_value.copyWith(
      newPresentPlayers: freezed == newPresentPlayers
          ? _value.newPresentPlayers
          : newPresentPlayers // ignore: cast_nullable_to_non_nullable
              as List<LobbyPlayer>?,
      newGameRoute: freezed == newGameRoute
          ? _value.newGameRoute
          : newGameRoute // ignore: cast_nullable_to_non_nullable
              as GameRoute?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameEventsImplCopyWith<$Res>
    implements $GameEventsCopyWith<$Res> {
  factory _$$GameEventsImplCopyWith(
          _$GameEventsImpl value, $Res Function(_$GameEventsImpl) then) =
      __$$GameEventsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LobbyPlayer>? newPresentPlayers, GameRoute? newGameRoute});
}

/// @nodoc
class __$$GameEventsImplCopyWithImpl<$Res>
    extends _$GameEventsCopyWithImpl<$Res, _$GameEventsImpl>
    implements _$$GameEventsImplCopyWith<$Res> {
  __$$GameEventsImplCopyWithImpl(
      _$GameEventsImpl _value, $Res Function(_$GameEventsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPresentPlayers = freezed,
    Object? newGameRoute = freezed,
  }) {
    return _then(_$GameEventsImpl(
      newPresentPlayers: freezed == newPresentPlayers
          ? _value._newPresentPlayers
          : newPresentPlayers // ignore: cast_nullable_to_non_nullable
              as List<LobbyPlayer>?,
      newGameRoute: freezed == newGameRoute
          ? _value.newGameRoute
          : newGameRoute // ignore: cast_nullable_to_non_nullable
              as GameRoute?,
    ));
  }
}

/// @nodoc

class _$GameEventsImpl implements _GameEvents {
  _$GameEventsImpl(
      {final List<LobbyPlayer>? newPresentPlayers, this.newGameRoute})
      : _newPresentPlayers = newPresentPlayers;

  final List<LobbyPlayer>? _newPresentPlayers;
  @override
  List<LobbyPlayer>? get newPresentPlayers {
    final value = _newPresentPlayers;
    if (value == null) return null;
    if (_newPresentPlayers is EqualUnmodifiableListView)
      return _newPresentPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final GameRoute? newGameRoute;

  @override
  String toString() {
    return 'GameEvents(newPresentPlayers: $newPresentPlayers, newGameRoute: $newGameRoute)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEventsImpl &&
            const DeepCollectionEquality()
                .equals(other._newPresentPlayers, _newPresentPlayers) &&
            (identical(other.newGameRoute, newGameRoute) ||
                other.newGameRoute == newGameRoute));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_newPresentPlayers), newGameRoute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEventsImplCopyWith<_$GameEventsImpl> get copyWith =>
      __$$GameEventsImplCopyWithImpl<_$GameEventsImpl>(this, _$identity);
}

abstract class _GameEvents implements GameEvents {
  factory _GameEvents(
      {final List<LobbyPlayer>? newPresentPlayers,
      final GameRoute? newGameRoute}) = _$GameEventsImpl;

  @override
  List<LobbyPlayer>? get newPresentPlayers;
  @override
  GameRoute? get newGameRoute;
  @override
  @JsonKey(ignore: true)
  _$$GameEventsImplCopyWith<_$GameEventsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
