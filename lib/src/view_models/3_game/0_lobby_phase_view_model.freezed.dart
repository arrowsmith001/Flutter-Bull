// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '0_lobby_phase_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LobbyPhaseViewModel {
  String get roomCode => throw _privateConstructorUsedError;
  String get leaderId => throw _privateConstructorUsedError;
  bool get isLeader => throw _privateConstructorUsedError;
  Map<String, LobbyPlayer> get presentPlayers =>
      throw _privateConstructorUsedError;
  Set<PublicPlayer> get absentPlayers => throw _privateConstructorUsedError;
  ListChangeData<LobbyPlayer> get listChangeData =>
      throw _privateConstructorUsedError;
  Map<String, bool> get playerReadies => throw _privateConstructorUsedError;
  String get numberOfPlayersString => throw _privateConstructorUsedError;
  bool get enoughPlayers => throw _privateConstructorUsedError;
  bool get isStartingGame => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LobbyPhaseViewModelCopyWith<LobbyPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LobbyPhaseViewModelCopyWith<$Res> {
  factory $LobbyPhaseViewModelCopyWith(
          LobbyPhaseViewModel value, $Res Function(LobbyPhaseViewModel) then) =
      _$LobbyPhaseViewModelCopyWithImpl<$Res, LobbyPhaseViewModel>;
  @useResult
  $Res call(
      {String roomCode,
      String leaderId,
      bool isLeader,
      Map<String, LobbyPlayer> presentPlayers,
      Set<PublicPlayer> absentPlayers,
      ListChangeData<LobbyPlayer> listChangeData,
      Map<String, bool> playerReadies,
      String numberOfPlayersString,
      bool enoughPlayers,
      bool isStartingGame});
}

/// @nodoc
class _$LobbyPhaseViewModelCopyWithImpl<$Res, $Val extends LobbyPhaseViewModel>
    implements $LobbyPhaseViewModelCopyWith<$Res> {
  _$LobbyPhaseViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomCode = null,
    Object? leaderId = null,
    Object? isLeader = null,
    Object? presentPlayers = null,
    Object? absentPlayers = null,
    Object? listChangeData = null,
    Object? playerReadies = null,
    Object? numberOfPlayersString = null,
    Object? enoughPlayers = null,
    Object? isStartingGame = null,
  }) {
    return _then(_value.copyWith(
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      leaderId: null == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as String,
      isLeader: null == isLeader
          ? _value.isLeader
          : isLeader // ignore: cast_nullable_to_non_nullable
              as bool,
      presentPlayers: null == presentPlayers
          ? _value.presentPlayers
          : presentPlayers // ignore: cast_nullable_to_non_nullable
              as Map<String, LobbyPlayer>,
      absentPlayers: null == absentPlayers
          ? _value.absentPlayers
          : absentPlayers // ignore: cast_nullable_to_non_nullable
              as Set<PublicPlayer>,
      listChangeData: null == listChangeData
          ? _value.listChangeData
          : listChangeData // ignore: cast_nullable_to_non_nullable
              as ListChangeData<LobbyPlayer>,
      playerReadies: null == playerReadies
          ? _value.playerReadies
          : playerReadies // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      numberOfPlayersString: null == numberOfPlayersString
          ? _value.numberOfPlayersString
          : numberOfPlayersString // ignore: cast_nullable_to_non_nullable
              as String,
      enoughPlayers: null == enoughPlayers
          ? _value.enoughPlayers
          : enoughPlayers // ignore: cast_nullable_to_non_nullable
              as bool,
      isStartingGame: null == isStartingGame
          ? _value.isStartingGame
          : isStartingGame // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LobbyPhaseViewModelCopyWith<$Res>
    implements $LobbyPhaseViewModelCopyWith<$Res> {
  factory _$$_LobbyPhaseViewModelCopyWith(_$_LobbyPhaseViewModel value,
          $Res Function(_$_LobbyPhaseViewModel) then) =
      __$$_LobbyPhaseViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String roomCode,
      String leaderId,
      bool isLeader,
      Map<String, LobbyPlayer> presentPlayers,
      Set<PublicPlayer> absentPlayers,
      ListChangeData<LobbyPlayer> listChangeData,
      Map<String, bool> playerReadies,
      String numberOfPlayersString,
      bool enoughPlayers,
      bool isStartingGame});
}

/// @nodoc
class __$$_LobbyPhaseViewModelCopyWithImpl<$Res>
    extends _$LobbyPhaseViewModelCopyWithImpl<$Res, _$_LobbyPhaseViewModel>
    implements _$$_LobbyPhaseViewModelCopyWith<$Res> {
  __$$_LobbyPhaseViewModelCopyWithImpl(_$_LobbyPhaseViewModel _value,
      $Res Function(_$_LobbyPhaseViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomCode = null,
    Object? leaderId = null,
    Object? isLeader = null,
    Object? presentPlayers = null,
    Object? absentPlayers = null,
    Object? listChangeData = null,
    Object? playerReadies = null,
    Object? numberOfPlayersString = null,
    Object? enoughPlayers = null,
    Object? isStartingGame = null,
  }) {
    return _then(_$_LobbyPhaseViewModel(
      roomCode: null == roomCode
          ? _value.roomCode
          : roomCode // ignore: cast_nullable_to_non_nullable
              as String,
      leaderId: null == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as String,
      isLeader: null == isLeader
          ? _value.isLeader
          : isLeader // ignore: cast_nullable_to_non_nullable
              as bool,
      presentPlayers: null == presentPlayers
          ? _value._presentPlayers
          : presentPlayers // ignore: cast_nullable_to_non_nullable
              as Map<String, LobbyPlayer>,
      absentPlayers: null == absentPlayers
          ? _value._absentPlayers
          : absentPlayers // ignore: cast_nullable_to_non_nullable
              as Set<PublicPlayer>,
      listChangeData: null == listChangeData
          ? _value.listChangeData
          : listChangeData // ignore: cast_nullable_to_non_nullable
              as ListChangeData<LobbyPlayer>,
      playerReadies: null == playerReadies
          ? _value._playerReadies
          : playerReadies // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      numberOfPlayersString: null == numberOfPlayersString
          ? _value.numberOfPlayersString
          : numberOfPlayersString // ignore: cast_nullable_to_non_nullable
              as String,
      enoughPlayers: null == enoughPlayers
          ? _value.enoughPlayers
          : enoughPlayers // ignore: cast_nullable_to_non_nullable
              as bool,
      isStartingGame: null == isStartingGame
          ? _value.isStartingGame
          : isStartingGame // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LobbyPhaseViewModel implements _LobbyPhaseViewModel {
  _$_LobbyPhaseViewModel(
      {required this.roomCode,
      required this.leaderId,
      required this.isLeader,
      required final Map<String, LobbyPlayer> presentPlayers,
      required final Set<PublicPlayer> absentPlayers,
      required this.listChangeData,
      required final Map<String, bool> playerReadies,
      required this.numberOfPlayersString,
      required this.enoughPlayers,
      required this.isStartingGame})
      : _presentPlayers = presentPlayers,
        _absentPlayers = absentPlayers,
        _playerReadies = playerReadies;

  @override
  final String roomCode;
  @override
  final String leaderId;
  @override
  final bool isLeader;
  final Map<String, LobbyPlayer> _presentPlayers;
  @override
  Map<String, LobbyPlayer> get presentPlayers {
    if (_presentPlayers is EqualUnmodifiableMapView) return _presentPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_presentPlayers);
  }

  final Set<PublicPlayer> _absentPlayers;
  @override
  Set<PublicPlayer> get absentPlayers {
    if (_absentPlayers is EqualUnmodifiableSetView) return _absentPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_absentPlayers);
  }

  @override
  final ListChangeData<LobbyPlayer> listChangeData;
  final Map<String, bool> _playerReadies;
  @override
  Map<String, bool> get playerReadies {
    if (_playerReadies is EqualUnmodifiableMapView) return _playerReadies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerReadies);
  }

  @override
  final String numberOfPlayersString;
  @override
  final bool enoughPlayers;
  @override
  final bool isStartingGame;

  @override
  String toString() {
    return 'LobbyPhaseViewModel._(roomCode: $roomCode, leaderId: $leaderId, isLeader: $isLeader, presentPlayers: $presentPlayers, absentPlayers: $absentPlayers, listChangeData: $listChangeData, playerReadies: $playerReadies, numberOfPlayersString: $numberOfPlayersString, enoughPlayers: $enoughPlayers, isStartingGame: $isStartingGame)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LobbyPhaseViewModel &&
            (identical(other.roomCode, roomCode) ||
                other.roomCode == roomCode) &&
            (identical(other.leaderId, leaderId) ||
                other.leaderId == leaderId) &&
            (identical(other.isLeader, isLeader) ||
                other.isLeader == isLeader) &&
            const DeepCollectionEquality()
                .equals(other._presentPlayers, _presentPlayers) &&
            const DeepCollectionEquality()
                .equals(other._absentPlayers, _absentPlayers) &&
            (identical(other.listChangeData, listChangeData) ||
                other.listChangeData == listChangeData) &&
            const DeepCollectionEquality()
                .equals(other._playerReadies, _playerReadies) &&
            (identical(other.numberOfPlayersString, numberOfPlayersString) ||
                other.numberOfPlayersString == numberOfPlayersString) &&
            (identical(other.enoughPlayers, enoughPlayers) ||
                other.enoughPlayers == enoughPlayers) &&
            (identical(other.isStartingGame, isStartingGame) ||
                other.isStartingGame == isStartingGame));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      roomCode,
      leaderId,
      isLeader,
      const DeepCollectionEquality().hash(_presentPlayers),
      const DeepCollectionEquality().hash(_absentPlayers),
      listChangeData,
      const DeepCollectionEquality().hash(_playerReadies),
      numberOfPlayersString,
      enoughPlayers,
      isStartingGame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LobbyPhaseViewModelCopyWith<_$_LobbyPhaseViewModel> get copyWith =>
      __$$_LobbyPhaseViewModelCopyWithImpl<_$_LobbyPhaseViewModel>(
          this, _$identity);
}

abstract class _LobbyPhaseViewModel implements LobbyPhaseViewModel {
  factory _LobbyPhaseViewModel(
      {required final String roomCode,
      required final String leaderId,
      required final bool isLeader,
      required final Map<String, LobbyPlayer> presentPlayers,
      required final Set<PublicPlayer> absentPlayers,
      required final ListChangeData<LobbyPlayer> listChangeData,
      required final Map<String, bool> playerReadies,
      required final String numberOfPlayersString,
      required final bool enoughPlayers,
      required final bool isStartingGame}) = _$_LobbyPhaseViewModel;

  @override
  String get roomCode;
  @override
  String get leaderId;
  @override
  bool get isLeader;
  @override
  Map<String, LobbyPlayer> get presentPlayers;
  @override
  Set<PublicPlayer> get absentPlayers;
  @override
  ListChangeData<LobbyPlayer> get listChangeData;
  @override
  Map<String, bool> get playerReadies;
  @override
  String get numberOfPlayersString;
  @override
  bool get enoughPlayers;
  @override
  bool get isStartingGame;
  @override
  @JsonKey(ignore: true)
  _$$_LobbyPhaseViewModelCopyWith<_$_LobbyPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
