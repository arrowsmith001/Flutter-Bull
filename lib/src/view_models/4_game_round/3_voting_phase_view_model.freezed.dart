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
  PublicPlayer get playerWhoseTurn => throw _privateConstructorUsedError;
  Map<String, VotingPlayer> get votingPlayers =>
      throw _privateConstructorUsedError;
  String get playersWhoseTurnStatement => throw _privateConstructorUsedError;
  TimeData get timeData => throw _privateConstructorUsedError;
  String get waitingForPlayerText => throw _privateConstructorUsedError;
  int get numberOfPlayersVoted => throw _privateConstructorUsedError;
  int get numberOfPlayersVoting => throw _privateConstructorUsedError;
  bool get isThereTimeRemaining => throw _privateConstructorUsedError;
  bool get hasEveryoneVoted => throw _privateConstructorUsedError;
  bool get isSaboteur => throw _privateConstructorUsedError;
  bool get isReading => throw _privateConstructorUsedError;
  bool get hasVoted => throw _privateConstructorUsedError;
  VoteOptionsState get voteOptionsState => throw _privateConstructorUsedError;
  RoundStatus get roundStatus => throw _privateConstructorUsedError;
  int? get timeForReaderToSwitchToTruth => throw _privateConstructorUsedError;
  List<String> get playersVotedIds => throw _privateConstructorUsedError;
  List<String> get playersNotVotedIds => throw _privateConstructorUsedError;
  List<String> get eligibleVoterIds => throw _privateConstructorUsedError;
  Map<String, bool> get eligibleVoterStatus =>
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
      {PublicPlayer playerWhoseTurn,
      Map<String, VotingPlayer> votingPlayers,
      String playersWhoseTurnStatement,
      TimeData timeData,
      String waitingForPlayerText,
      int numberOfPlayersVoted,
      int numberOfPlayersVoting,
      bool isThereTimeRemaining,
      bool hasEveryoneVoted,
      bool isSaboteur,
      bool isReading,
      bool hasVoted,
      VoteOptionsState voteOptionsState,
      RoundStatus roundStatus,
      int? timeForReaderToSwitchToTruth,
      List<String> playersVotedIds,
      List<String> playersNotVotedIds,
      List<String> eligibleVoterIds,
      Map<String, bool> eligibleVoterStatus});
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
    Object? votingPlayers = null,
    Object? playersWhoseTurnStatement = null,
    Object? timeData = null,
    Object? waitingForPlayerText = null,
    Object? numberOfPlayersVoted = null,
    Object? numberOfPlayersVoting = null,
    Object? isThereTimeRemaining = null,
    Object? hasEveryoneVoted = null,
    Object? isSaboteur = null,
    Object? isReading = null,
    Object? hasVoted = null,
    Object? voteOptionsState = null,
    Object? roundStatus = null,
    Object? timeForReaderToSwitchToTruth = freezed,
    Object? playersVotedIds = null,
    Object? playersNotVotedIds = null,
    Object? eligibleVoterIds = null,
    Object? eligibleVoterStatus = null,
  }) {
    return _then(_value.copyWith(
      playerWhoseTurn: null == playerWhoseTurn
          ? _value.playerWhoseTurn
          : playerWhoseTurn // ignore: cast_nullable_to_non_nullable
              as PublicPlayer,
      votingPlayers: null == votingPlayers
          ? _value.votingPlayers
          : votingPlayers // ignore: cast_nullable_to_non_nullable
              as Map<String, VotingPlayer>,
      playersWhoseTurnStatement: null == playersWhoseTurnStatement
          ? _value.playersWhoseTurnStatement
          : playersWhoseTurnStatement // ignore: cast_nullable_to_non_nullable
              as String,
      timeData: null == timeData
          ? _value.timeData
          : timeData // ignore: cast_nullable_to_non_nullable
              as TimeData,
      waitingForPlayerText: null == waitingForPlayerText
          ? _value.waitingForPlayerText
          : waitingForPlayerText // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfPlayersVoted: null == numberOfPlayersVoted
          ? _value.numberOfPlayersVoted
          : numberOfPlayersVoted // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfPlayersVoting: null == numberOfPlayersVoting
          ? _value.numberOfPlayersVoting
          : numberOfPlayersVoting // ignore: cast_nullable_to_non_nullable
              as int,
      isThereTimeRemaining: null == isThereTimeRemaining
          ? _value.isThereTimeRemaining
          : isThereTimeRemaining // ignore: cast_nullable_to_non_nullable
              as bool,
      hasEveryoneVoted: null == hasEveryoneVoted
          ? _value.hasEveryoneVoted
          : hasEveryoneVoted // ignore: cast_nullable_to_non_nullable
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
      voteOptionsState: null == voteOptionsState
          ? _value.voteOptionsState
          : voteOptionsState // ignore: cast_nullable_to_non_nullable
              as VoteOptionsState,
      roundStatus: null == roundStatus
          ? _value.roundStatus
          : roundStatus // ignore: cast_nullable_to_non_nullable
              as RoundStatus,
      timeForReaderToSwitchToTruth: freezed == timeForReaderToSwitchToTruth
          ? _value.timeForReaderToSwitchToTruth
          : timeForReaderToSwitchToTruth // ignore: cast_nullable_to_non_nullable
              as int?,
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
      {PublicPlayer playerWhoseTurn,
      Map<String, VotingPlayer> votingPlayers,
      String playersWhoseTurnStatement,
      TimeData timeData,
      String waitingForPlayerText,
      int numberOfPlayersVoted,
      int numberOfPlayersVoting,
      bool isThereTimeRemaining,
      bool hasEveryoneVoted,
      bool isSaboteur,
      bool isReading,
      bool hasVoted,
      VoteOptionsState voteOptionsState,
      RoundStatus roundStatus,
      int? timeForReaderToSwitchToTruth,
      List<String> playersVotedIds,
      List<String> playersNotVotedIds,
      List<String> eligibleVoterIds,
      Map<String, bool> eligibleVoterStatus});
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
    Object? votingPlayers = null,
    Object? playersWhoseTurnStatement = null,
    Object? timeData = null,
    Object? waitingForPlayerText = null,
    Object? numberOfPlayersVoted = null,
    Object? numberOfPlayersVoting = null,
    Object? isThereTimeRemaining = null,
    Object? hasEveryoneVoted = null,
    Object? isSaboteur = null,
    Object? isReading = null,
    Object? hasVoted = null,
    Object? voteOptionsState = null,
    Object? roundStatus = null,
    Object? timeForReaderToSwitchToTruth = freezed,
    Object? playersVotedIds = null,
    Object? playersNotVotedIds = null,
    Object? eligibleVoterIds = null,
    Object? eligibleVoterStatus = null,
  }) {
    return _then(_$_VotingPhaseViewModel(
      playerWhoseTurn: null == playerWhoseTurn
          ? _value.playerWhoseTurn
          : playerWhoseTurn // ignore: cast_nullable_to_non_nullable
              as PublicPlayer,
      votingPlayers: null == votingPlayers
          ? _value._votingPlayers
          : votingPlayers // ignore: cast_nullable_to_non_nullable
              as Map<String, VotingPlayer>,
      playersWhoseTurnStatement: null == playersWhoseTurnStatement
          ? _value.playersWhoseTurnStatement
          : playersWhoseTurnStatement // ignore: cast_nullable_to_non_nullable
              as String,
      timeData: null == timeData
          ? _value.timeData
          : timeData // ignore: cast_nullable_to_non_nullable
              as TimeData,
      waitingForPlayerText: null == waitingForPlayerText
          ? _value.waitingForPlayerText
          : waitingForPlayerText // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfPlayersVoted: null == numberOfPlayersVoted
          ? _value.numberOfPlayersVoted
          : numberOfPlayersVoted // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfPlayersVoting: null == numberOfPlayersVoting
          ? _value.numberOfPlayersVoting
          : numberOfPlayersVoting // ignore: cast_nullable_to_non_nullable
              as int,
      isThereTimeRemaining: null == isThereTimeRemaining
          ? _value.isThereTimeRemaining
          : isThereTimeRemaining // ignore: cast_nullable_to_non_nullable
              as bool,
      hasEveryoneVoted: null == hasEveryoneVoted
          ? _value.hasEveryoneVoted
          : hasEveryoneVoted // ignore: cast_nullable_to_non_nullable
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
      voteOptionsState: null == voteOptionsState
          ? _value.voteOptionsState
          : voteOptionsState // ignore: cast_nullable_to_non_nullable
              as VoteOptionsState,
      roundStatus: null == roundStatus
          ? _value.roundStatus
          : roundStatus // ignore: cast_nullable_to_non_nullable
              as RoundStatus,
      timeForReaderToSwitchToTruth: freezed == timeForReaderToSwitchToTruth
          ? _value.timeForReaderToSwitchToTruth
          : timeForReaderToSwitchToTruth // ignore: cast_nullable_to_non_nullable
              as int?,
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
    ));
  }
}

/// @nodoc

class _$_VotingPhaseViewModel implements _VotingPhaseViewModel {
  const _$_VotingPhaseViewModel(
      {required this.playerWhoseTurn,
      required final Map<String, VotingPlayer> votingPlayers,
      required this.playersWhoseTurnStatement,
      required this.timeData,
      required this.waitingForPlayerText,
      required this.numberOfPlayersVoted,
      required this.numberOfPlayersVoting,
      required this.isThereTimeRemaining,
      required this.hasEveryoneVoted,
      required this.isSaboteur,
      required this.isReading,
      required this.hasVoted,
      required this.voteOptionsState,
      required this.roundStatus,
      required this.timeForReaderToSwitchToTruth,
      required final List<String> playersVotedIds,
      required final List<String> playersNotVotedIds,
      required final List<String> eligibleVoterIds,
      required final Map<String, bool> eligibleVoterStatus})
      : _votingPlayers = votingPlayers,
        _playersVotedIds = playersVotedIds,
        _playersNotVotedIds = playersNotVotedIds,
        _eligibleVoterIds = eligibleVoterIds,
        _eligibleVoterStatus = eligibleVoterStatus;

  @override
  final PublicPlayer playerWhoseTurn;
  final Map<String, VotingPlayer> _votingPlayers;
  @override
  Map<String, VotingPlayer> get votingPlayers {
    if (_votingPlayers is EqualUnmodifiableMapView) return _votingPlayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_votingPlayers);
  }

  @override
  final String playersWhoseTurnStatement;
  @override
  final TimeData timeData;
  @override
  final String waitingForPlayerText;
  @override
  final int numberOfPlayersVoted;
  @override
  final int numberOfPlayersVoting;
  @override
  final bool isThereTimeRemaining;
  @override
  final bool hasEveryoneVoted;
  @override
  final bool isSaboteur;
  @override
  final bool isReading;
  @override
  final bool hasVoted;
  @override
  final VoteOptionsState voteOptionsState;
  @override
  final RoundStatus roundStatus;
  @override
  final int? timeForReaderToSwitchToTruth;
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

  @override
  String toString() {
    return 'VotingPhaseViewModel._(playerWhoseTurn: $playerWhoseTurn, votingPlayers: $votingPlayers, playersWhoseTurnStatement: $playersWhoseTurnStatement, timeData: $timeData, waitingForPlayerText: $waitingForPlayerText, numberOfPlayersVoted: $numberOfPlayersVoted, numberOfPlayersVoting: $numberOfPlayersVoting, isThereTimeRemaining: $isThereTimeRemaining, hasEveryoneVoted: $hasEveryoneVoted, isSaboteur: $isSaboteur, isReading: $isReading, hasVoted: $hasVoted, voteOptionsState: $voteOptionsState, roundStatus: $roundStatus, timeForReaderToSwitchToTruth: $timeForReaderToSwitchToTruth, playersVotedIds: $playersVotedIds, playersNotVotedIds: $playersNotVotedIds, eligibleVoterIds: $eligibleVoterIds, eligibleVoterStatus: $eligibleVoterStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VotingPhaseViewModel &&
            (identical(other.playerWhoseTurn, playerWhoseTurn) ||
                other.playerWhoseTurn == playerWhoseTurn) &&
            const DeepCollectionEquality()
                .equals(other._votingPlayers, _votingPlayers) &&
            (identical(other.playersWhoseTurnStatement,
                    playersWhoseTurnStatement) ||
                other.playersWhoseTurnStatement == playersWhoseTurnStatement) &&
            (identical(other.timeData, timeData) ||
                other.timeData == timeData) &&
            (identical(other.waitingForPlayerText, waitingForPlayerText) ||
                other.waitingForPlayerText == waitingForPlayerText) &&
            (identical(other.numberOfPlayersVoted, numberOfPlayersVoted) ||
                other.numberOfPlayersVoted == numberOfPlayersVoted) &&
            (identical(other.numberOfPlayersVoting, numberOfPlayersVoting) ||
                other.numberOfPlayersVoting == numberOfPlayersVoting) &&
            (identical(other.isThereTimeRemaining, isThereTimeRemaining) ||
                other.isThereTimeRemaining == isThereTimeRemaining) &&
            (identical(other.hasEveryoneVoted, hasEveryoneVoted) ||
                other.hasEveryoneVoted == hasEveryoneVoted) &&
            (identical(other.isSaboteur, isSaboteur) ||
                other.isSaboteur == isSaboteur) &&
            (identical(other.isReading, isReading) ||
                other.isReading == isReading) &&
            (identical(other.hasVoted, hasVoted) ||
                other.hasVoted == hasVoted) &&
            (identical(other.voteOptionsState, voteOptionsState) ||
                other.voteOptionsState == voteOptionsState) &&
            (identical(other.roundStatus, roundStatus) ||
                other.roundStatus == roundStatus) &&
            (identical(other.timeForReaderToSwitchToTruth,
                    timeForReaderToSwitchToTruth) ||
                other.timeForReaderToSwitchToTruth ==
                    timeForReaderToSwitchToTruth) &&
            const DeepCollectionEquality()
                .equals(other._playersVotedIds, _playersVotedIds) &&
            const DeepCollectionEquality()
                .equals(other._playersNotVotedIds, _playersNotVotedIds) &&
            const DeepCollectionEquality()
                .equals(other._eligibleVoterIds, _eligibleVoterIds) &&
            const DeepCollectionEquality()
                .equals(other._eligibleVoterStatus, _eligibleVoterStatus));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        playerWhoseTurn,
        const DeepCollectionEquality().hash(_votingPlayers),
        playersWhoseTurnStatement,
        timeData,
        waitingForPlayerText,
        numberOfPlayersVoted,
        numberOfPlayersVoting,
        isThereTimeRemaining,
        hasEveryoneVoted,
        isSaboteur,
        isReading,
        hasVoted,
        voteOptionsState,
        roundStatus,
        timeForReaderToSwitchToTruth,
        const DeepCollectionEquality().hash(_playersVotedIds),
        const DeepCollectionEquality().hash(_playersNotVotedIds),
        const DeepCollectionEquality().hash(_eligibleVoterIds),
        const DeepCollectionEquality().hash(_eligibleVoterStatus)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VotingPhaseViewModelCopyWith<_$_VotingPhaseViewModel> get copyWith =>
      __$$_VotingPhaseViewModelCopyWithImpl<_$_VotingPhaseViewModel>(
          this, _$identity);
}

abstract class _VotingPhaseViewModel implements VotingPhaseViewModel {
  const factory _VotingPhaseViewModel(
          {required final PublicPlayer playerWhoseTurn,
          required final Map<String, VotingPlayer> votingPlayers,
          required final String playersWhoseTurnStatement,
          required final TimeData timeData,
          required final String waitingForPlayerText,
          required final int numberOfPlayersVoted,
          required final int numberOfPlayersVoting,
          required final bool isThereTimeRemaining,
          required final bool hasEveryoneVoted,
          required final bool isSaboteur,
          required final bool isReading,
          required final bool hasVoted,
          required final VoteOptionsState voteOptionsState,
          required final RoundStatus roundStatus,
          required final int? timeForReaderToSwitchToTruth,
          required final List<String> playersVotedIds,
          required final List<String> playersNotVotedIds,
          required final List<String> eligibleVoterIds,
          required final Map<String, bool> eligibleVoterStatus}) =
      _$_VotingPhaseViewModel;

  @override
  PublicPlayer get playerWhoseTurn;
  @override
  Map<String, VotingPlayer> get votingPlayers;
  @override
  String get playersWhoseTurnStatement;
  @override
  TimeData get timeData;
  @override
  String get waitingForPlayerText;
  @override
  int get numberOfPlayersVoted;
  @override
  int get numberOfPlayersVoting;
  @override
  bool get isThereTimeRemaining;
  @override
  bool get hasEveryoneVoted;
  @override
  bool get isSaboteur;
  @override
  bool get isReading;
  @override
  bool get hasVoted;
  @override
  VoteOptionsState get voteOptionsState;
  @override
  RoundStatus get roundStatus;
  @override
  int? get timeForReaderToSwitchToTruth;
  @override
  List<String> get playersVotedIds;
  @override
  List<String> get playersNotVotedIds;
  @override
  List<String> get eligibleVoterIds;
  @override
  Map<String, bool> get eligibleVoterStatus;
  @override
  @JsonKey(ignore: true)
  _$$_VotingPhaseViewModelCopyWith<_$_VotingPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
