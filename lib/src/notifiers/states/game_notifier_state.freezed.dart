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
  String get roomId => throw _privateConstructorUsedError;
  String get roomCode => throw _privateConstructorUsedError;
  int? get endTime => throw _privateConstructorUsedError;
  GamePhaseData get phaseData => throw _privateConstructorUsedError;
  ListState get playerListState => throw _privateConstructorUsedError;
  RolesState get rolesState => throw _privateConstructorUsedError;
  RoundsState get roundsState => throw _privateConstructorUsedError;
  List<PlayerWithAvatar> get playerAvatars =>
      throw _privateConstructorUsedError;
  List<String> get allPlayersThisSession => throw _privateConstructorUsedError;

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
      {String roomId,
      String roomCode,
      int? endTime,
      GamePhaseData phaseData,
      ListState playerListState,
      RolesState rolesState,
      RoundsState roundsState,
      List<PlayerWithAvatar> playerAvatars,
      List<String> allPlayersThisSession});

  $GamePhaseDataCopyWith<$Res> get phaseData;
  $ListStateCopyWith<$Res> get playerListState;
  $RolesStateCopyWith<$Res> get rolesState;
  $RoundsStateCopyWith<$Res> get roundsState;
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
    Object? roomId = null,
    Object? roomCode = null,
    Object? endTime = freezed,
    Object? phaseData = null,
    Object? playerListState = null,
    Object? rolesState = null,
    Object? roundsState = null,
    Object? playerAvatars = null,
    Object? allPlayersThisSession = null,
  }) {
    return _then(_value.copyWith(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as int?,
      phaseData: null == phaseData
          ? _value.phaseData
          : phaseData // ignore: cast_nullable_to_non_nullable
              as GamePhaseData,
      playerListState: null == playerListState
          ? _value.playerListState
          : playerListState // ignore: cast_nullable_to_non_nullable
              as ListState,
      rolesState: null == rolesState
          ? _value.rolesState
          : rolesState // ignore: cast_nullable_to_non_nullable
              as RolesState,
      roundsState: null == roundsState
          ? _value.roundsState
          : roundsState // ignore: cast_nullable_to_non_nullable
              as RoundsState,
      playerAvatars: null == playerAvatars
          ? _value.playerAvatars
          : playerAvatars // ignore: cast_nullable_to_non_nullable
              as List<PlayerWithAvatar>,
      allPlayersThisSession: null == allPlayersThisSession
          ? _value.allPlayersThisSession
          : allPlayersThisSession // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GamePhaseDataCopyWith<$Res> get phaseData {
    return $GamePhaseDataCopyWith<$Res>(_value.phaseData, (value) {
      return _then(_value.copyWith(phaseData: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ListStateCopyWith<$Res> get playerListState {
    return $ListStateCopyWith<$Res>(_value.playerListState, (value) {
      return _then(_value.copyWith(playerListState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RolesStateCopyWith<$Res> get rolesState {
    return $RolesStateCopyWith<$Res>(_value.rolesState, (value) {
      return _then(_value.copyWith(rolesState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RoundsStateCopyWith<$Res> get roundsState {
    return $RoundsStateCopyWith<$Res>(_value.roundsState, (value) {
      return _then(_value.copyWith(roundsState: value) as $Val);
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
      {String roomId,
      String roomCode,
      int? endTime,
      GamePhaseData phaseData,
      ListState playerListState,
      RolesState rolesState,
      RoundsState roundsState,
      List<PlayerWithAvatar> playerAvatars,
      List<String> allPlayersThisSession});

  @override
  $GamePhaseDataCopyWith<$Res> get phaseData;
  @override
  $ListStateCopyWith<$Res> get playerListState;
  @override
  $RolesStateCopyWith<$Res> get rolesState;
  @override
  $RoundsStateCopyWith<$Res> get roundsState;
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
    Object? roomId = null,
    Object? roomCode = null,
    Object? endTime = freezed,
    Object? phaseData = null,
    Object? playerListState = null,
    Object? rolesState = null,
    Object? roundsState = null,
    Object? playerAvatars = null,
    Object? allPlayersThisSession = null,
  }) {
    return _then(_$_GameNotifierState(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as int?,
      phaseData: null == phaseData
          ? _value.phaseData
          : phaseData // ignore: cast_nullable_to_non_nullable
              as GamePhaseData,
      playerListState: null == playerListState
          ? _value.playerListState
          : playerListState // ignore: cast_nullable_to_non_nullable
              as ListState,
      rolesState: null == rolesState
          ? _value.rolesState
          : rolesState // ignore: cast_nullable_to_non_nullable
              as RolesState,
      roundsState: null == roundsState
          ? _value.roundsState
          : roundsState // ignore: cast_nullable_to_non_nullable
              as RoundsState,
      playerAvatars: null == playerAvatars
          ? _value._playerAvatars
          : playerAvatars // ignore: cast_nullable_to_non_nullable
              as List<PlayerWithAvatar>,
      allPlayersThisSession: null == allPlayersThisSession
          ? _value._allPlayersThisSession
          : allPlayersThisSession // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_GameNotifierState extends _GameNotifierState {
  _$_GameNotifierState(
      {required this.roomId,
      required this.roomCode,
      required this.endTime,
      required this.phaseData,
      required this.playerListState,
      required this.rolesState,
      required this.roundsState,
      required final List<PlayerWithAvatar> playerAvatars,
      required final List<String> allPlayersThisSession})
      : _playerAvatars = playerAvatars,
        _allPlayersThisSession = allPlayersThisSession,
        super._();

  @override
  final String roomId;
  @override
  final String roomCode;
  @override
  final int? endTime;
  @override
  final GamePhaseData phaseData;
  @override
  final ListState playerListState;
  @override
  final RolesState rolesState;
  @override
  final RoundsState roundsState;
  final List<PlayerWithAvatar> _playerAvatars;
  @override
  List<PlayerWithAvatar> get playerAvatars {
    if (_playerAvatars is EqualUnmodifiableListView) return _playerAvatars;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerAvatars);
  }

  final List<String> _allPlayersThisSession;
  @override
  List<String> get allPlayersThisSession {
    if (_allPlayersThisSession is EqualUnmodifiableListView)
      return _allPlayersThisSession;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPlayersThisSession);
  }

  @override
  String toString() {
    return 'GameNotifierState(roomId: $roomId, roomCode: $roomCode, endTime: $endTime, phaseData: $phaseData, playerListState: $playerListState, rolesState: $rolesState, roundsState: $roundsState, playerAvatars: $playerAvatars, allPlayersThisSession: $allPlayersThisSession)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameNotifierState &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.phaseData, phaseData) ||
                other.phaseData == phaseData) &&
            (identical(other.playerListState, playerListState) ||
                other.playerListState == playerListState) &&
            (identical(other.rolesState, rolesState) ||
                other.rolesState == rolesState) &&
            (identical(other.roundsState, roundsState) ||
                other.roundsState == roundsState) &&
            const DeepCollectionEquality()
                .equals(other._playerAvatars, _playerAvatars) &&
            const DeepCollectionEquality()
                .equals(other._allPlayersThisSession, _allPlayersThisSession));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      roomId,
      roomCode,
      endTime,
      phaseData,
      playerListState,
      rolesState,
      roundsState,
      const DeepCollectionEquality().hash(_playerAvatars),
      const DeepCollectionEquality().hash(_allPlayersThisSession));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameNotifierStateCopyWith<_$_GameNotifierState> get copyWith =>
      __$$_GameNotifierStateCopyWithImpl<_$_GameNotifierState>(
          this, _$identity);
}

abstract class _GameNotifierState extends GameNotifierState {
  factory _GameNotifierState(
          {required final String roomId,
          required final String roomCode,
          required final int? endTime,
          required final GamePhaseData phaseData,
          required final ListState playerListState,
          required final RolesState rolesState,
          required final RoundsState roundsState,
          required final List<PlayerWithAvatar> playerAvatars,
          required final List<String> allPlayersThisSession}) =
      _$_GameNotifierState;
  _GameNotifierState._() : super._();

  @override
  String get roomId;
  @override
  String get roomCode;
  @override
  int? get endTime;
  @override
  GamePhaseData get phaseData;
  @override
  ListState get playerListState;
  @override
  RolesState get rolesState;
  @override
  RoundsState get roundsState;
  @override
  List<PlayerWithAvatar> get playerAvatars;
  @override
  List<String> get allPlayersThisSession;
  @override
  @JsonKey(ignore: true)
  _$$_GameNotifierStateCopyWith<_$_GameNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GamePhaseData {
  GamePhase get gamePhase => throw _privateConstructorUsedError;
  RoundPhase get roundPhase => throw _privateConstructorUsedError;
  Object? get arg => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GamePhaseDataCopyWith<GamePhaseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePhaseDataCopyWith<$Res> {
  factory $GamePhaseDataCopyWith(
          GamePhaseData value, $Res Function(GamePhaseData) then) =
      _$GamePhaseDataCopyWithImpl<$Res, GamePhaseData>;
  @useResult
  $Res call({GamePhase gamePhase, RoundPhase roundPhase, Object? arg});
}

/// @nodoc
class _$GamePhaseDataCopyWithImpl<$Res, $Val extends GamePhaseData>
    implements $GamePhaseDataCopyWith<$Res> {
  _$GamePhaseDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gamePhase = null,
    Object? roundPhase = null,
    Object? arg = freezed,
  }) {
    return _then(_value.copyWith(
      gamePhase: null == gamePhase
          ? _value.gamePhase
          : gamePhase // ignore: cast_nullable_to_non_nullable
              as GamePhase,
      roundPhase: null == roundPhase
          ? _value.roundPhase
          : roundPhase // ignore: cast_nullable_to_non_nullable
              as RoundPhase,
      arg: freezed == arg ? _value.arg : arg,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GamePhaseDataCopyWith<$Res>
    implements $GamePhaseDataCopyWith<$Res> {
  factory _$$_GamePhaseDataCopyWith(
          _$_GamePhaseData value, $Res Function(_$_GamePhaseData) then) =
      __$$_GamePhaseDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GamePhase gamePhase, RoundPhase roundPhase, Object? arg});
}

/// @nodoc
class __$$_GamePhaseDataCopyWithImpl<$Res>
    extends _$GamePhaseDataCopyWithImpl<$Res, _$_GamePhaseData>
    implements _$$_GamePhaseDataCopyWith<$Res> {
  __$$_GamePhaseDataCopyWithImpl(
      _$_GamePhaseData _value, $Res Function(_$_GamePhaseData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gamePhase = null,
    Object? roundPhase = null,
    Object? arg = freezed,
  }) {
    return _then(_$_GamePhaseData(
      gamePhase: null == gamePhase
          ? _value.gamePhase
          : gamePhase // ignore: cast_nullable_to_non_nullable
              as GamePhase,
      roundPhase: null == roundPhase
          ? _value.roundPhase
          : roundPhase // ignore: cast_nullable_to_non_nullable
              as RoundPhase,
      arg: freezed == arg ? _value.arg : arg,
    ));
  }
}

/// @nodoc

class _$_GamePhaseData implements _GamePhaseData {
  _$_GamePhaseData(
      {required this.gamePhase, required this.roundPhase, this.arg = null});

  @override
  final GamePhase gamePhase;
  @override
  final RoundPhase roundPhase;
  @override
  @JsonKey()
  final Object? arg;

  @override
  String toString() {
    return 'GamePhaseData(gamePhase: $gamePhase, roundPhase: $roundPhase, arg: $arg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GamePhaseData &&
            (identical(other.gamePhase, gamePhase) ||
                other.gamePhase == gamePhase) &&
            (identical(other.roundPhase, roundPhase) ||
                other.roundPhase == roundPhase) &&
            const DeepCollectionEquality().equals(other.arg, arg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gamePhase, roundPhase,
      const DeepCollectionEquality().hash(arg));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GamePhaseDataCopyWith<_$_GamePhaseData> get copyWith =>
      __$$_GamePhaseDataCopyWithImpl<_$_GamePhaseData>(this, _$identity);
}

abstract class _GamePhaseData implements GamePhaseData {
  factory _GamePhaseData(
      {required final GamePhase gamePhase,
      required final RoundPhase roundPhase,
      final Object? arg}) = _$_GamePhaseData;

  @override
  GamePhase get gamePhase;
  @override
  RoundPhase get roundPhase;
  @override
  Object? get arg;
  @override
  @JsonKey(ignore: true)
  _$$_GamePhaseDataCopyWith<_$_GamePhaseData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RoundsState {
  List<String> get order => throw _privateConstructorUsedError;
  List<String> get playerIds => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoundsStateCopyWith<RoundsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoundsStateCopyWith<$Res> {
  factory $RoundsStateCopyWith(
          RoundsState value, $Res Function(RoundsState) then) =
      _$RoundsStateCopyWithImpl<$Res, RoundsState>;
  @useResult
  $Res call({List<String> order, List<String> playerIds, int progress});
}

/// @nodoc
class _$RoundsStateCopyWithImpl<$Res, $Val extends RoundsState>
    implements $RoundsStateCopyWith<$Res> {
  _$RoundsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? playerIds = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playerIds: null == playerIds
          ? _value.playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoundsStateCopyWith<$Res>
    implements $RoundsStateCopyWith<$Res> {
  factory _$$_RoundsStateCopyWith(
          _$_RoundsState value, $Res Function(_$_RoundsState) then) =
      __$$_RoundsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> order, List<String> playerIds, int progress});
}

/// @nodoc
class __$$_RoundsStateCopyWithImpl<$Res>
    extends _$RoundsStateCopyWithImpl<$Res, _$_RoundsState>
    implements _$$_RoundsStateCopyWith<$Res> {
  __$$_RoundsStateCopyWithImpl(
      _$_RoundsState _value, $Res Function(_$_RoundsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = null,
    Object? playerIds = null,
    Object? progress = null,
  }) {
    return _then(_$_RoundsState(
      order: null == order
          ? _value._order
          : order // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playerIds: null == playerIds
          ? _value._playerIds
          : playerIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RoundsState extends _RoundsState {
  _$_RoundsState(
      {required final List<String> order,
      required final List<String> playerIds,
      required this.progress})
      : _order = order,
        _playerIds = playerIds,
        super._();

  final List<String> _order;
  @override
  List<String> get order {
    if (_order is EqualUnmodifiableListView) return _order;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_order);
  }

  final List<String> _playerIds;
  @override
  List<String> get playerIds {
    if (_playerIds is EqualUnmodifiableListView) return _playerIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerIds);
  }

  @override
  final int progress;

  @override
  String toString() {
    return 'RoundsState(order: $order, playerIds: $playerIds, progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoundsState &&
            const DeepCollectionEquality().equals(other._order, _order) &&
            const DeepCollectionEquality()
                .equals(other._playerIds, _playerIds) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_order),
      const DeepCollectionEquality().hash(_playerIds),
      progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoundsStateCopyWith<_$_RoundsState> get copyWith =>
      __$$_RoundsStateCopyWithImpl<_$_RoundsState>(this, _$identity);
}

abstract class _RoundsState extends RoundsState {
  factory _RoundsState(
      {required final List<String> order,
      required final List<String> playerIds,
      required final int progress}) = _$_RoundsState;
  _RoundsState._() : super._();

  @override
  List<String> get order;
  @override
  List<String> get playerIds;
  @override
  int get progress;
  @override
  @JsonKey(ignore: true)
  _$$_RoundsStateCopyWith<_$_RoundsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RoundState {
  int? get timeRemaining => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoundStateCopyWith<RoundState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoundStateCopyWith<$Res> {
  factory $RoundStateCopyWith(
          RoundState value, $Res Function(RoundState) then) =
      _$RoundStateCopyWithImpl<$Res, RoundState>;
  @useResult
  $Res call({int? timeRemaining});
}

/// @nodoc
class _$RoundStateCopyWithImpl<$Res, $Val extends RoundState>
    implements $RoundStateCopyWith<$Res> {
  _$RoundStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeRemaining = freezed,
  }) {
    return _then(_value.copyWith(
      timeRemaining: freezed == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RoundStateCopyWith<$Res>
    implements $RoundStateCopyWith<$Res> {
  factory _$$_RoundStateCopyWith(
          _$_RoundState value, $Res Function(_$_RoundState) then) =
      __$$_RoundStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? timeRemaining});
}

/// @nodoc
class __$$_RoundStateCopyWithImpl<$Res>
    extends _$RoundStateCopyWithImpl<$Res, _$_RoundState>
    implements _$$_RoundStateCopyWith<$Res> {
  __$$_RoundStateCopyWithImpl(
      _$_RoundState _value, $Res Function(_$_RoundState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeRemaining = freezed,
  }) {
    return _then(_$_RoundState(
      timeRemaining: freezed == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_RoundState implements _RoundState {
  _$_RoundState({required this.timeRemaining});

  @override
  final int? timeRemaining;

  @override
  String toString() {
    return 'RoundState(timeRemaining: $timeRemaining)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoundState &&
            (identical(other.timeRemaining, timeRemaining) ||
                other.timeRemaining == timeRemaining));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timeRemaining);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RoundStateCopyWith<_$_RoundState> get copyWith =>
      __$$_RoundStateCopyWithImpl<_$_RoundState>(this, _$identity);
}

abstract class _RoundState implements RoundState {
  factory _RoundState({required final int? timeRemaining}) = _$_RoundState;

  @override
  int? get timeRemaining;
  @override
  @JsonKey(ignore: true)
  _$$_RoundStateCopyWith<_$_RoundState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RolesState {
  Map<String, String> get targets => throw _privateConstructorUsedError;
  Map<String, String> get texts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RolesStateCopyWith<RolesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RolesStateCopyWith<$Res> {
  factory $RolesStateCopyWith(
          RolesState value, $Res Function(RolesState) then) =
      _$RolesStateCopyWithImpl<$Res, RolesState>;
  @useResult
  $Res call({Map<String, String> targets, Map<String, String> texts});
}

/// @nodoc
class _$RolesStateCopyWithImpl<$Res, $Val extends RolesState>
    implements $RolesStateCopyWith<$Res> {
  _$RolesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targets = null,
    Object? texts = null,
  }) {
    return _then(_value.copyWith(
      targets: null == targets
          ? _value.targets
          : targets // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      texts: null == texts
          ? _value.texts
          : texts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RolesStateCopyWith<$Res>
    implements $RolesStateCopyWith<$Res> {
  factory _$$_RolesStateCopyWith(
          _$_RolesState value, $Res Function(_$_RolesState) then) =
      __$$_RolesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, String> targets, Map<String, String> texts});
}

/// @nodoc
class __$$_RolesStateCopyWithImpl<$Res>
    extends _$RolesStateCopyWithImpl<$Res, _$_RolesState>
    implements _$$_RolesStateCopyWith<$Res> {
  __$$_RolesStateCopyWithImpl(
      _$_RolesState _value, $Res Function(_$_RolesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targets = null,
    Object? texts = null,
  }) {
    return _then(_$_RolesState(
      targets: null == targets
          ? _value._targets
          : targets // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      texts: null == texts
          ? _value._texts
          : texts // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
    ));
  }
}

/// @nodoc

class _$_RolesState extends _RolesState {
  _$_RolesState(
      {final Map<String, String> targets = const {},
      final Map<String, String> texts = const {}})
      : _targets = targets,
        _texts = texts,
        super._();

  final Map<String, String> _targets;
  @override
  @JsonKey()
  Map<String, String> get targets {
    if (_targets is EqualUnmodifiableMapView) return _targets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_targets);
  }

  final Map<String, String> _texts;
  @override
  @JsonKey()
  Map<String, String> get texts {
    if (_texts is EqualUnmodifiableMapView) return _texts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_texts);
  }

  @override
  String toString() {
    return 'RolesState(targets: $targets, texts: $texts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RolesState &&
            const DeepCollectionEquality().equals(other._targets, _targets) &&
            const DeepCollectionEquality().equals(other._texts, _texts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_targets),
      const DeepCollectionEquality().hash(_texts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RolesStateCopyWith<_$_RolesState> get copyWith =>
      __$$_RolesStateCopyWithImpl<_$_RolesState>(this, _$identity);
}

abstract class _RolesState extends RolesState {
  factory _RolesState(
      {final Map<String, String> targets,
      final Map<String, String> texts}) = _$_RolesState;
  _RolesState._() : super._();

  @override
  Map<String, String> get targets;
  @override
  Map<String, String> get texts;
  @override
  @JsonKey(ignore: true)
  _$$_RolesStateCopyWith<_$_RolesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ListState {
  List<String> get list => throw _privateConstructorUsedError;
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
      {List<String> list,
      int lengthBefore,
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
    Object? list = null,
    Object? lengthBefore = null,
    Object? length = null,
    Object? hasChanged = null,
    Object? listChangeType = null,
    Object? changeIndex = freezed,
    Object? changedItemId = freezed,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      {List<String> list,
      int lengthBefore,
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
    Object? list = null,
    Object? lengthBefore = null,
    Object? length = null,
    Object? hasChanged = null,
    Object? listChangeType = null,
    Object? changeIndex = freezed,
    Object? changedItemId = freezed,
  }) {
    return _then(_$_ListState(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      {required final List<String> list,
      required this.lengthBefore,
      required this.length,
      this.hasChanged = false,
      this.listChangeType = ListChangeType.unchanged,
      this.changeIndex,
      this.changedItemId})
      : _list = list;

  final List<String> _list;
  @override
  List<String> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

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
    return 'ListState(list: $list, lengthBefore: $lengthBefore, length: $length, hasChanged: $hasChanged, listChangeType: $listChangeType, changeIndex: $changeIndex, changedItemId: $changedItemId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ListState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
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
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      lengthBefore,
      length,
      hasChanged,
      listChangeType,
      changeIndex,
      changedItemId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ListStateCopyWith<_$_ListState> get copyWith =>
      __$$_ListStateCopyWithImpl<_$_ListState>(this, _$identity);
}

abstract class _ListState implements ListState {
  factory _ListState(
      {required final List<String> list,
      required final int lengthBefore,
      required final int length,
      final bool hasChanged,
      final ListChangeType listChangeType,
      final int? changeIndex,
      final String? changedItemId}) = _$_ListState;

  @override
  List<String> get list;
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
