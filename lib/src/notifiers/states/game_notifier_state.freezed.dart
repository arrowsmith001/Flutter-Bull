// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_notifier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameNotifierState {
  Player get signedInPlayer => throw _privateConstructorUsedError;
  GameRoom get gameRoom => throw _privateConstructorUsedError;
  ListState get playerListState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameNotifierStateCopyWith<GameNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameNotifierStateCopyWith<$Res> {
  factory $GameNotifierStateCopyWith(
          GameNotifierState value, $Res Function(GameNotifierState) then) =
      _$GameNotifierStateCopyWithImpl<$Res, GameNotifierState>;
  @useResult
  $Res call(
      {Player signedInPlayer, GameRoom gameRoom, ListState playerListState});

  $PlayerCopyWith<$Res> get signedInPlayer;
  $GameRoomCopyWith<$Res> get gameRoom;
  $ListStateCopyWith<$Res> get playerListState;
}

/// @nodoc
class _$GameNotifierStateCopyWithImpl<$Res, $Val extends GameNotifierState>
    implements $GameNotifierStateCopyWith<$Res> {
  _$GameNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedInPlayer = null,
    Object? gameRoom = null,
    Object? playerListState = null,
  }) {
    return _then(_value.copyWith(
      signedInPlayer: null == signedInPlayer
          ? _value.signedInPlayer
          : signedInPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      gameRoom: null == gameRoom
          ? _value.gameRoom
          : gameRoom // ignore: cast_nullable_to_non_nullable
              as GameRoom,
      playerListState: null == playerListState
          ? _value.playerListState
          : playerListState // ignore: cast_nullable_to_non_nullable
              as ListState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get signedInPlayer {
    return $PlayerCopyWith<$Res>(_value.signedInPlayer, (value) {
      return _then(_value.copyWith(signedInPlayer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GameRoomCopyWith<$Res> get gameRoom {
    return $GameRoomCopyWith<$Res>(_value.gameRoom, (value) {
      return _then(_value.copyWith(gameRoom: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ListStateCopyWith<$Res> get playerListState {
    return $ListStateCopyWith<$Res>(_value.playerListState, (value) {
      return _then(_value.copyWith(playerListState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GameNotifierStateCopyWith<$Res>
    implements $GameNotifierStateCopyWith<$Res> {
  factory _$$_GameNotifierStateCopyWith(_$_GameNotifierState value,
          $Res Function(_$_GameNotifierState) then) =
      __$$_GameNotifierStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Player signedInPlayer, GameRoom gameRoom, ListState playerListState});

  @override
  $PlayerCopyWith<$Res> get signedInPlayer;
  @override
  $GameRoomCopyWith<$Res> get gameRoom;
  @override
  $ListStateCopyWith<$Res> get playerListState;
}

/// @nodoc
class __$$_GameNotifierStateCopyWithImpl<$Res>
    extends _$GameNotifierStateCopyWithImpl<$Res, _$_GameNotifierState>
    implements _$$_GameNotifierStateCopyWith<$Res> {
  __$$_GameNotifierStateCopyWithImpl(
      _$_GameNotifierState _value, $Res Function(_$_GameNotifierState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedInPlayer = null,
    Object? gameRoom = null,
    Object? playerListState = null,
  }) {
    return _then(_$_GameNotifierState(
      signedInPlayer: null == signedInPlayer
          ? _value.signedInPlayer
          : signedInPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      gameRoom: null == gameRoom
          ? _value.gameRoom
          : gameRoom // ignore: cast_nullable_to_non_nullable
              as GameRoom,
      playerListState: null == playerListState
          ? _value.playerListState
          : playerListState // ignore: cast_nullable_to_non_nullable
              as ListState,
    ));
  }
}

/// @nodoc

class _$_GameNotifierState implements _GameNotifierState {
  _$_GameNotifierState(
      {required this.signedInPlayer,
      required this.gameRoom,
      required this.playerListState});

  @override
  final Player signedInPlayer;
  @override
  final GameRoom gameRoom;
  @override
  final ListState playerListState;

  @override
  String toString() {
    return 'GameNotifierState(signedInPlayer: $signedInPlayer, gameRoom: $gameRoom, playerListState: $playerListState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameNotifierState &&
            (identical(other.signedInPlayer, signedInPlayer) ||
                other.signedInPlayer == signedInPlayer) &&
            (identical(other.gameRoom, gameRoom) ||
                other.gameRoom == gameRoom) &&
            (identical(other.playerListState, playerListState) ||
                other.playerListState == playerListState));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, signedInPlayer, gameRoom, playerListState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameNotifierStateCopyWith<_$_GameNotifierState> get copyWith =>
      __$$_GameNotifierStateCopyWithImpl<_$_GameNotifierState>(
          this, _$identity);
}

abstract class _GameNotifierState implements GameNotifierState {
  factory _GameNotifierState(
      {required final Player signedInPlayer,
      required final GameRoom gameRoom,
      required final ListState playerListState}) = _$_GameNotifierState;

  @override
  Player get signedInPlayer;
  @override
  GameRoom get gameRoom;
  @override
  ListState get playerListState;
  @override
  @JsonKey(ignore: true)
  _$$_GameNotifierStateCopyWith<_$_GameNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ListState {
  int get lengthBefore => throw _privateConstructorUsedError;
  int get length => throw _privateConstructorUsedError;
  bool get hasChanged => throw _privateConstructorUsedError;
  ListChangeType get listChangeType => throw _privateConstructorUsedError;
  int? get changeIndex => throw _privateConstructorUsedError;
  String? get changedItemId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListStateCopyWith<ListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListStateCopyWith<$Res> {
  factory $ListStateCopyWith(ListState value, $Res Function(ListState) then) =
      _$ListStateCopyWithImpl<$Res, ListState>;
  @useResult
  $Res call(
      {int lengthBefore,
      int length,
      bool hasChanged,
      ListChangeType listChangeType,
      int? changeIndex,
      String? changedItemId});
}

/// @nodoc
class _$ListStateCopyWithImpl<$Res, $Val extends ListState>
    implements $ListStateCopyWith<$Res> {
  _$ListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lengthBefore = null,
    Object? length = null,
    Object? hasChanged = null,
    Object? listChangeType = null,
    Object? changeIndex = freezed,
    Object? changedItemId = freezed,
  }) {
    return _then(_value.copyWith(
      lengthBefore: null == lengthBefore
          ? _value.lengthBefore
          : lengthBefore // ignore: cast_nullable_to_non_nullable
              as int,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      hasChanged: null == hasChanged
          ? _value.hasChanged
          : hasChanged // ignore: cast_nullable_to_non_nullable
              as bool,
      listChangeType: null == listChangeType
          ? _value.listChangeType
          : listChangeType // ignore: cast_nullable_to_non_nullable
              as ListChangeType,
      changeIndex: freezed == changeIndex
          ? _value.changeIndex
          : changeIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      changedItemId: freezed == changedItemId
          ? _value.changedItemId
          : changedItemId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ListStateCopyWith<$Res> implements $ListStateCopyWith<$Res> {
  factory _$$_ListStateCopyWith(
          _$_ListState value, $Res Function(_$_ListState) then) =
      __$$_ListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int lengthBefore,
      int length,
      bool hasChanged,
      ListChangeType listChangeType,
      int? changeIndex,
      String? changedItemId});
}

/// @nodoc
class __$$_ListStateCopyWithImpl<$Res>
    extends _$ListStateCopyWithImpl<$Res, _$_ListState>
    implements _$$_ListStateCopyWith<$Res> {
  __$$_ListStateCopyWithImpl(
      _$_ListState _value, $Res Function(_$_ListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lengthBefore = null,
    Object? length = null,
    Object? hasChanged = null,
    Object? listChangeType = null,
    Object? changeIndex = freezed,
    Object? changedItemId = freezed,
  }) {
    return _then(_$_ListState(
      lengthBefore: null == lengthBefore
          ? _value.lengthBefore
          : lengthBefore // ignore: cast_nullable_to_non_nullable
              as int,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      hasChanged: null == hasChanged
          ? _value.hasChanged
          : hasChanged // ignore: cast_nullable_to_non_nullable
              as bool,
      listChangeType: null == listChangeType
          ? _value.listChangeType
          : listChangeType // ignore: cast_nullable_to_non_nullable
              as ListChangeType,
      changeIndex: freezed == changeIndex
          ? _value.changeIndex
          : changeIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      changedItemId: freezed == changedItemId
          ? _value.changedItemId
          : changedItemId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ListState implements _ListState {
  _$_ListState(
      {required this.lengthBefore,
      required this.length,
      this.hasChanged = false,
      this.listChangeType = ListChangeType.unchanged,
      this.changeIndex,
      this.changedItemId});

  @override
  final int lengthBefore;
  @override
  final int length;
  @override
  @JsonKey()
  final bool hasChanged;
  @override
  @JsonKey()
  final ListChangeType listChangeType;
  @override
  final int? changeIndex;
  @override
  final String? changedItemId;

  @override
  String toString() {
    return 'ListState(lengthBefore: $lengthBefore, length: $length, hasChanged: $hasChanged, listChangeType: $listChangeType, changeIndex: $changeIndex, changedItemId: $changedItemId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ListState &&
            (identical(other.lengthBefore, lengthBefore) ||
                other.lengthBefore == lengthBefore) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.hasChanged, hasChanged) ||
                other.hasChanged == hasChanged) &&
            (identical(other.listChangeType, listChangeType) ||
                other.listChangeType == listChangeType) &&
            (identical(other.changeIndex, changeIndex) ||
                other.changeIndex == changeIndex) &&
            (identical(other.changedItemId, changedItemId) ||
                other.changedItemId == changedItemId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lengthBefore, length, hasChanged,
      listChangeType, changeIndex, changedItemId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ListStateCopyWith<_$_ListState> get copyWith =>
      __$$_ListStateCopyWithImpl<_$_ListState>(this, _$identity);
}

abstract class _ListState implements ListState {
  factory _ListState(
      {required final int lengthBefore,
      required final int length,
      final bool hasChanged,
      final ListChangeType listChangeType,
      final int? changeIndex,
      final String? changedItemId}) = _$_ListState;

  @override
  int get lengthBefore;
  @override
  int get length;
  @override
  bool get hasChanged;
  @override
  ListChangeType get listChangeType;
  @override
  int? get changeIndex;
  @override
  String? get changedItemId;
  @override
  @JsonKey(ignore: true)
  _$$_ListStateCopyWith<_$_ListState> get copyWith =>
      throw _privateConstructorUsedError;
}