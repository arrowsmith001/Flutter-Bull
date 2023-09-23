// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '3_voting_phase_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VotingPhaseViewModel {
  PlayerWithAvatar get playerWhoseTurn => throw _privateConstructorUsedError;
  String get playersWhoseTurnStatement => throw _privateConstructorUsedError;
  Duration get timeRemaining => throw _privateConstructorUsedError;
  String get timeString => throw _privateConstructorUsedError;
  int get numberOfPlayersVoted => throw _privateConstructorUsedError;
  int get numberOfPlayersVoting => throw _privateConstructorUsedError;
  bool get isRoundInProgress => throw _privateConstructorUsedError;
  bool get isSaboteur => throw _privateConstructorUsedError;
  bool get isReading => throw _privateConstructorUsedError;
  bool get hasVoted => throw _privateConstructorUsedError;
  List<String> get playersVotedIds => throw _privateConstructorUsedError;
  List<String> get playersNotVotedIds => throw _privateConstructorUsedError;
  List<String> get eligibleVoterIds => throw _privateConstructorUsedError;
  Map<String, bool> get eligibleVoterStatus =>
      throw _privateConstructorUsedError;
  Map<String, PlayerWithAvatar> get playerMap =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VotingPhaseViewModelCopyWith<VotingPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VotingPhaseViewModelCopyWith<$Res> {
  factory $VotingPhaseViewModelCopyWith(VotingPhaseViewModel value,
          $Res Function(VotingPhaseViewModel) then) =
      _$VotingPhaseViewModelCopyWithImpl<$Res, VotingPhaseViewModel>;
  @useResult
  $Res call(
      {PlayerWithAvatar playerWhoseTurn,
      String playersWhoseTurnStatement,
      Duration timeRemaining,
      String timeString,
      int numberOfPlayersVoted,
      int numberOfPlayersVoting,
      bool isRoundInProgress,
      bool isSaboteur,
      bool isReading,
      bool hasVoted,
      List<String> playersVotedIds,
      List<String> playersNotVotedIds,
      List<String> eligibleVoterIds,
      Map<String, bool> eligibleVoterStatus,
      Map<String, PlayerWithAvatar> playerMap});
}

/// @nodoc
class _$VotingPhaseViewModelCopyWithImpl<$Res,
        $Val extends VotingPhaseViewModel>
    implements $VotingPhaseViewModelCopyWith<$Res> {
  _$VotingPhaseViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerWhoseTurn = null,
    Object? playersWhoseTurnStatement = null,
    Object? timeRemaining = null,
    Object? timeString = null,
    Object? numberOfPlayersVoted = null,
    Object? numberOfPlayersVoting = null,
    Object? isRoundInProgress = null,
    Object? isSaboteur = null,
    Object? isReading = null,
    Object? hasVoted = null,
    Object? playersVotedIds = null,
    Object? playersNotVotedIds = null,
    Object? eligibleVoterIds = null,
    Object? eligibleVoterStatus = null,
    Object? playerMap = null,
  }) {
    return _then(_value.copyWith(
      playerWhoseTurn: null == playerWhoseTurn
          ? _value.playerWhoseTurn
          : playerWhoseTurn // ignore: cast_nullable_to_non_nullable
              as PlayerWithAvatar,
      playersWhoseTurnStatement: null == playersWhoseTurnStatement
          ? _value.playersWhoseTurnStatement
          : playersWhoseTurnStatement // ignore: cast_nullable_to_non_nullable
              as String,
      timeRemaining: null == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as Duration,
      timeString: null == timeString
          ? _value.timeString
          : timeString // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfPlayersVoted: null == numberOfPlayersVoted
          ? _value.numberOfPlayersVoted
          : numberOfPlayersVoted // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfPlayersVoting: null == numberOfPlayersVoting
          ? _value.numberOfPlayersVoting
          : numberOfPlayersVoting // ignore: cast_nullable_to_non_nullable
              as int,
      isRoundInProgress: null == isRoundInProgress
          ? _value.isRoundInProgress
          : isRoundInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaboteur: null == isSaboteur
          ? _value.isSaboteur
          : isSaboteur // ignore: cast_nullable_to_non_nullable
              as bool,
      isReading: null == isReading
          ? _value.isReading
          : isReading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasVoted: null == hasVoted
          ? _value.hasVoted
          : hasVoted // ignore: cast_nullable_to_non_nullable
              as bool,
      playersVotedIds: null == playersVotedIds
          ? _value.playersVotedIds
          : playersVotedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playersNotVotedIds: null == playersNotVotedIds
          ? _value.playersNotVotedIds
          : playersNotVotedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      eligibleVoterIds: null == eligibleVoterIds
          ? _value.eligibleVoterIds
          : eligibleVoterIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      eligibleVoterStatus: null == eligibleVoterStatus
          ? _value.eligibleVoterStatus
          : eligibleVoterStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      playerMap: null == playerMap
          ? _value.playerMap
          : playerMap // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayerWithAvatar>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VotingPhaseViewModelCopyWith<$Res>
    implements $VotingPhaseViewModelCopyWith<$Res> {
  factory _$$_VotingPhaseViewModelCopyWith(_$_VotingPhaseViewModel value,
          $Res Function(_$_VotingPhaseViewModel) then) =
      __$$_VotingPhaseViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PlayerWithAvatar playerWhoseTurn,
      String playersWhoseTurnStatement,
      Duration timeRemaining,
      String timeString,
      int numberOfPlayersVoted,
      int numberOfPlayersVoting,
      bool isRoundInProgress,
      bool isSaboteur,
      bool isReading,
      bool hasVoted,
      List<String> playersVotedIds,
      List<String> playersNotVotedIds,
      List<String> eligibleVoterIds,
      Map<String, bool> eligibleVoterStatus,
      Map<String, PlayerWithAvatar> playerMap});
}

/// @nodoc
class __$$_VotingPhaseViewModelCopyWithImpl<$Res>
    extends _$VotingPhaseViewModelCopyWithImpl<$Res, _$_VotingPhaseViewModel>
    implements _$$_VotingPhaseViewModelCopyWith<$Res> {
  __$$_VotingPhaseViewModelCopyWithImpl(_$_VotingPhaseViewModel _value,
      $Res Function(_$_VotingPhaseViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerWhoseTurn = null,
    Object? playersWhoseTurnStatement = null,
    Object? timeRemaining = null,
    Object? timeString = null,
    Object? numberOfPlayersVoted = null,
    Object? numberOfPlayersVoting = null,
    Object? isRoundInProgress = null,
    Object? isSaboteur = null,
    Object? isReading = null,
    Object? hasVoted = null,
    Object? playersVotedIds = null,
    Object? playersNotVotedIds = null,
    Object? eligibleVoterIds = null,
    Object? eligibleVoterStatus = null,
    Object? playerMap = null,
  }) {
    return _then(_$_VotingPhaseViewModel(
      playerWhoseTurn: null == playerWhoseTurn
          ? _value.playerWhoseTurn
          : playerWhoseTurn // ignore: cast_nullable_to_non_nullable
              as PlayerWithAvatar,
      playersWhoseTurnStatement: null == playersWhoseTurnStatement
          ? _value.playersWhoseTurnStatement
          : playersWhoseTurnStatement // ignore: cast_nullable_to_non_nullable
              as String,
      timeRemaining: null == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as Duration,
      timeString: null == timeString
          ? _value.timeString
          : timeString // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfPlayersVoted: null == numberOfPlayersVoted
          ? _value.numberOfPlayersVoted
          : numberOfPlayersVoted // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfPlayersVoting: null == numberOfPlayersVoting
          ? _value.numberOfPlayersVoting
          : numberOfPlayersVoting // ignore: cast_nullable_to_non_nullable
              as int,
      isRoundInProgress: null == isRoundInProgress
          ? _value.isRoundInProgress
          : isRoundInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaboteur: null == isSaboteur
          ? _value.isSaboteur
          : isSaboteur // ignore: cast_nullable_to_non_nullable
              as bool,
      isReading: null == isReading
          ? _value.isReading
          : isReading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasVoted: null == hasVoted
          ? _value.hasVoted
          : hasVoted // ignore: cast_nullable_to_non_nullable
              as bool,
      playersVotedIds: null == playersVotedIds
          ? _value._playersVotedIds
          : playersVotedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      playersNotVotedIds: null == playersNotVotedIds
          ? _value._playersNotVotedIds
          : playersNotVotedIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      eligibleVoterIds: null == eligibleVoterIds
          ? _value._eligibleVoterIds
          : eligibleVoterIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      eligibleVoterStatus: null == eligibleVoterStatus
          ? _value._eligibleVoterStatus
          : eligibleVoterStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      playerMap: null == playerMap
          ? _value._playerMap
          : playerMap // ignore: cast_nullable_to_non_nullable
              as Map<String, PlayerWithAvatar>,
    ));
  }
}

/// @nodoc

class _$_VotingPhaseViewModel implements _VotingPhaseViewModel {
  const _$_VotingPhaseViewModel(
      {required this.playerWhoseTurn,
      required this.playersWhoseTurnStatement,
      required this.timeRemaining,
      required this.timeString,
      required this.numberOfPlayersVoted,
      required this.numberOfPlayersVoting,
      required this.isRoundInProgress,
      required this.isSaboteur,
      required this.isReading,
      required this.hasVoted,
      required final List<String> playersVotedIds,
      required final List<String> playersNotVotedIds,
      required final List<String> eligibleVoterIds,
      required final Map<String, bool> eligibleVoterStatus,
      required final Map<String, PlayerWithAvatar> playerMap})
      : _playersVotedIds = playersVotedIds,
        _playersNotVotedIds = playersNotVotedIds,
        _eligibleVoterIds = eligibleVoterIds,
        _eligibleVoterStatus = eligibleVoterStatus,
        _playerMap = playerMap;

  @override
  final PlayerWithAvatar playerWhoseTurn;
  @override
  final String playersWhoseTurnStatement;
  @override
  final Duration timeRemaining;
  @override
  final String timeString;
  @override
  final int numberOfPlayersVoted;
  @override
  final int numberOfPlayersVoting;
  @override
  final bool isRoundInProgress;
  @override
  final bool isSaboteur;
  @override
  final bool isReading;
  @override
  final bool hasVoted;
  final List<String> _playersVotedIds;
  @override
  List<String> get playersVotedIds {
    if (_playersVotedIds is EqualUnmodifiableListView) return _playersVotedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playersVotedIds);
  }

  final List<String> _playersNotVotedIds;
  @override
  List<String> get playersNotVotedIds {
    if (_playersNotVotedIds is EqualUnmodifiableListView)
      return _playersNotVotedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playersNotVotedIds);
  }

  final List<String> _eligibleVoterIds;
  @override
  List<String> get eligibleVoterIds {
    if (_eligibleVoterIds is EqualUnmodifiableListView)
      return _eligibleVoterIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eligibleVoterIds);
  }

  final Map<String, bool> _eligibleVoterStatus;
  @override
  Map<String, bool> get eligibleVoterStatus {
    if (_eligibleVoterStatus is EqualUnmodifiableMapView)
      return _eligibleVoterStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_eligibleVoterStatus);
  }

  final Map<String, PlayerWithAvatar> _playerMap;
  @override
  Map<String, PlayerWithAvatar> get playerMap {
    if (_playerMap is EqualUnmodifiableMapView) return _playerMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerMap);
  }

  @override
  String toString() {
    return 'VotingPhaseViewModel._(playerWhoseTurn: $playerWhoseTurn, playersWhoseTurnStatement: $playersWhoseTurnStatement, timeRemaining: $timeRemaining, timeString: $timeString, numberOfPlayersVoted: $numberOfPlayersVoted, numberOfPlayersVoting: $numberOfPlayersVoting, isRoundInProgress: $isRoundInProgress, isSaboteur: $isSaboteur, isReading: $isReading, hasVoted: $hasVoted, playersVotedIds: $playersVotedIds, playersNotVotedIds: $playersNotVotedIds, eligibleVoterIds: $eligibleVoterIds, eligibleVoterStatus: $eligibleVoterStatus, playerMap: $playerMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VotingPhaseViewModel &&
            (identical(other.playerWhoseTurn, playerWhoseTurn) ||
                other.playerWhoseTurn == playerWhoseTurn) &&
            (identical(other.playersWhoseTurnStatement,
                    playersWhoseTurnStatement) ||
                other.playersWhoseTurnStatement == playersWhoseTurnStatement) &&
            (identical(other.timeRemaining, timeRemaining) ||
                other.timeRemaining == timeRemaining) &&
            (identical(other.timeString, timeString) ||
                other.timeString == timeString) &&
            (identical(other.numberOfPlayersVoted, numberOfPlayersVoted) ||
                other.numberOfPlayersVoted == numberOfPlayersVoted) &&
            (identical(other.numberOfPlayersVoting, numberOfPlayersVoting) ||
                other.numberOfPlayersVoting == numberOfPlayersVoting) &&
            (identical(other.isRoundInProgress, isRoundInProgress) ||
                other.isRoundInProgress == isRoundInProgress) &&
            (identical(other.isSaboteur, isSaboteur) ||
                other.isSaboteur == isSaboteur) &&
            (identical(other.isReading, isReading) ||
                other.isReading == isReading) &&
            (identical(other.hasVoted, hasVoted) ||
                other.hasVoted == hasVoted) &&
            const DeepCollectionEquality()
                .equals(other._playersVotedIds, _playersVotedIds) &&
            const DeepCollectionEquality()
                .equals(other._playersNotVotedIds, _playersNotVotedIds) &&
            const DeepCollectionEquality()
                .equals(other._eligibleVoterIds, _eligibleVoterIds) &&
            const DeepCollectionEquality()
                .equals(other._eligibleVoterStatus, _eligibleVoterStatus) &&
            const DeepCollectionEquality()
                .equals(other._playerMap, _playerMap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      playerWhoseTurn,
      playersWhoseTurnStatement,
      timeRemaining,
      timeString,
      numberOfPlayersVoted,
      numberOfPlayersVoting,
      isRoundInProgress,
      isSaboteur,
      isReading,
      hasVoted,
      const DeepCollectionEquality().hash(_playersVotedIds),
      const DeepCollectionEquality().hash(_playersNotVotedIds),
      const DeepCollectionEquality().hash(_eligibleVoterIds),
      const DeepCollectionEquality().hash(_eligibleVoterStatus),
      const DeepCollectionEquality().hash(_playerMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VotingPhaseViewModelCopyWith<_$_VotingPhaseViewModel> get copyWith =>
      __$$_VotingPhaseViewModelCopyWithImpl<_$_VotingPhaseViewModel>(
          this, _$identity);
}

abstract class _VotingPhaseViewModel implements VotingPhaseViewModel {
  const factory _VotingPhaseViewModel(
          {required final PlayerWithAvatar playerWhoseTurn,
          required final String playersWhoseTurnStatement,
          required final Duration timeRemaining,
          required final String timeString,
          required final int numberOfPlayersVoted,
          required final int numberOfPlayersVoting,
          required final bool isRoundInProgress,
          required final bool isSaboteur,
          required final bool isReading,
          required final bool hasVoted,
          required final List<String> playersVotedIds,
          required final List<String> playersNotVotedIds,
          required final List<String> eligibleVoterIds,
          required final Map<String, bool> eligibleVoterStatus,
          required final Map<String, PlayerWithAvatar> playerMap}) =
      _$_VotingPhaseViewModel;

  @override
  PlayerWithAvatar get playerWhoseTurn;
  @override
  String get playersWhoseTurnStatement;
  @override
  Duration get timeRemaining;
  @override
  String get timeString;
  @override
  int get numberOfPlayersVoted;
  @override
  int get numberOfPlayersVoting;
  @override
  bool get isRoundInProgress;
  @override
  bool get isSaboteur;
  @override
  bool get isReading;
  @override
  bool get hasVoted;
  @override
  List<String> get playersVotedIds;
  @override
  List<String> get playersNotVotedIds;
  @override
  List<String> get eligibleVoterIds;
  @override
  Map<String, bool> get eligibleVoterStatus;
  @override
  Map<String, PlayerWithAvatar> get playerMap;
  @override
  @JsonKey(ignore: true)
  _$$_VotingPhaseViewModelCopyWith<_$_VotingPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
