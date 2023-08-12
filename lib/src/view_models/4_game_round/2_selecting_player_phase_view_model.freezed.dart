// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '2_selecting_player_phase_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectingPlayerPhaseViewModel {
  List<PlayerWithAvatar> get pseudoShuffledPlayerList =>
      throw _privateConstructorUsedError;
  PlayerWithAvatar get playerWhoseTurn => throw _privateConstructorUsedError;
  String get playerWhoseTurnStatement => throw _privateConstructorUsedError;
  String get roleDescriptionString => throw _privateConstructorUsedError;
  bool get isMyTurn => throw _privateConstructorUsedError;
  bool get isSaboteur => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectingPlayerPhaseViewModelCopyWith<SelectingPlayerPhaseViewModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectingPlayerPhaseViewModelCopyWith<$Res> {
  factory $SelectingPlayerPhaseViewModelCopyWith(
          SelectingPlayerPhaseViewModel value,
          $Res Function(SelectingPlayerPhaseViewModel) then) =
      _$SelectingPlayerPhaseViewModelCopyWithImpl<$Res,
          SelectingPlayerPhaseViewModel>;
  @useResult
  $Res call(
      {List<PlayerWithAvatar> pseudoShuffledPlayerList,
      PlayerWithAvatar playerWhoseTurn,
      String playerWhoseTurnStatement,
      String roleDescriptionString,
      bool isMyTurn,
      bool isSaboteur});
}

/// @nodoc
class _$SelectingPlayerPhaseViewModelCopyWithImpl<$Res,
        $Val extends SelectingPlayerPhaseViewModel>
    implements $SelectingPlayerPhaseViewModelCopyWith<$Res> {
  _$SelectingPlayerPhaseViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pseudoShuffledPlayerList = null,
    Object? playerWhoseTurn = null,
    Object? playerWhoseTurnStatement = null,
    Object? roleDescriptionString = null,
    Object? isMyTurn = null,
    Object? isSaboteur = null,
  }) {
    return _then(_value.copyWith(
      pseudoShuffledPlayerList: null == pseudoShuffledPlayerList
          ? _value.pseudoShuffledPlayerList
          : pseudoShuffledPlayerList // ignore: cast_nullable_to_non_nullable
              as List<PlayerWithAvatar>,
      playerWhoseTurn: null == playerWhoseTurn
          ? _value.playerWhoseTurn
          : playerWhoseTurn // ignore: cast_nullable_to_non_nullable
              as PlayerWithAvatar,
      playerWhoseTurnStatement: null == playerWhoseTurnStatement
          ? _value.playerWhoseTurnStatement
          : playerWhoseTurnStatement // ignore: cast_nullable_to_non_nullable
              as String,
      roleDescriptionString: null == roleDescriptionString
          ? _value.roleDescriptionString
          : roleDescriptionString // ignore: cast_nullable_to_non_nullable
              as String,
      isMyTurn: null == isMyTurn
          ? _value.isMyTurn
          : isMyTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaboteur: null == isSaboteur
          ? _value.isSaboteur
          : isSaboteur // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VotingPhaseViewModelCopyWith<$Res>
    implements $SelectingPlayerPhaseViewModelCopyWith<$Res> {
  factory _$$_VotingPhaseViewModelCopyWith(_$_VotingPhaseViewModel value,
          $Res Function(_$_VotingPhaseViewModel) then) =
      __$$_VotingPhaseViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PlayerWithAvatar> pseudoShuffledPlayerList,
      PlayerWithAvatar playerWhoseTurn,
      String playerWhoseTurnStatement,
      String roleDescriptionString,
      bool isMyTurn,
      bool isSaboteur});
}

/// @nodoc
class __$$_VotingPhaseViewModelCopyWithImpl<$Res>
    extends _$SelectingPlayerPhaseViewModelCopyWithImpl<$Res,
        _$_VotingPhaseViewModel>
    implements _$$_VotingPhaseViewModelCopyWith<$Res> {
  __$$_VotingPhaseViewModelCopyWithImpl(_$_VotingPhaseViewModel _value,
      $Res Function(_$_VotingPhaseViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pseudoShuffledPlayerList = null,
    Object? playerWhoseTurn = null,
    Object? playerWhoseTurnStatement = null,
    Object? roleDescriptionString = null,
    Object? isMyTurn = null,
    Object? isSaboteur = null,
  }) {
    return _then(_$_VotingPhaseViewModel(
      pseudoShuffledPlayerList: null == pseudoShuffledPlayerList
          ? _value._pseudoShuffledPlayerList
          : pseudoShuffledPlayerList // ignore: cast_nullable_to_non_nullable
              as List<PlayerWithAvatar>,
      playerWhoseTurn: null == playerWhoseTurn
          ? _value.playerWhoseTurn
          : playerWhoseTurn // ignore: cast_nullable_to_non_nullable
              as PlayerWithAvatar,
      playerWhoseTurnStatement: null == playerWhoseTurnStatement
          ? _value.playerWhoseTurnStatement
          : playerWhoseTurnStatement // ignore: cast_nullable_to_non_nullable
              as String,
      roleDescriptionString: null == roleDescriptionString
          ? _value.roleDescriptionString
          : roleDescriptionString // ignore: cast_nullable_to_non_nullable
              as String,
      isMyTurn: null == isMyTurn
          ? _value.isMyTurn
          : isMyTurn // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaboteur: null == isSaboteur
          ? _value.isSaboteur
          : isSaboteur // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_VotingPhaseViewModel implements _VotingPhaseViewModel {
  const _$_VotingPhaseViewModel(
      {required final List<PlayerWithAvatar> pseudoShuffledPlayerList,
      required this.playerWhoseTurn,
      required this.playerWhoseTurnStatement,
      required this.roleDescriptionString,
      required this.isMyTurn,
      required this.isSaboteur})
      : _pseudoShuffledPlayerList = pseudoShuffledPlayerList;

  final List<PlayerWithAvatar> _pseudoShuffledPlayerList;
  @override
  List<PlayerWithAvatar> get pseudoShuffledPlayerList {
    if (_pseudoShuffledPlayerList is EqualUnmodifiableListView)
      return _pseudoShuffledPlayerList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pseudoShuffledPlayerList);
  }

  @override
  final PlayerWithAvatar playerWhoseTurn;
  @override
  final String playerWhoseTurnStatement;
  @override
  final String roleDescriptionString;
  @override
  final bool isMyTurn;
  @override
  final bool isSaboteur;

  @override
  String toString() {
    return 'SelectingPlayerPhaseViewModel._(pseudoShuffledPlayerList: $pseudoShuffledPlayerList, playerWhoseTurn: $playerWhoseTurn, playerWhoseTurnStatement: $playerWhoseTurnStatement, roleDescriptionString: $roleDescriptionString, isMyTurn: $isMyTurn, isSaboteur: $isSaboteur)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VotingPhaseViewModel &&
            const DeepCollectionEquality().equals(
                other._pseudoShuffledPlayerList, _pseudoShuffledPlayerList) &&
            (identical(other.playerWhoseTurn, playerWhoseTurn) ||
                other.playerWhoseTurn == playerWhoseTurn) &&
            (identical(
                    other.playerWhoseTurnStatement, playerWhoseTurnStatement) ||
                other.playerWhoseTurnStatement == playerWhoseTurnStatement) &&
            (identical(other.roleDescriptionString, roleDescriptionString) ||
                other.roleDescriptionString == roleDescriptionString) &&
            (identical(other.isMyTurn, isMyTurn) ||
                other.isMyTurn == isMyTurn) &&
            (identical(other.isSaboteur, isSaboteur) ||
                other.isSaboteur == isSaboteur));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_pseudoShuffledPlayerList),
      playerWhoseTurn,
      playerWhoseTurnStatement,
      roleDescriptionString,
      isMyTurn,
      isSaboteur);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VotingPhaseViewModelCopyWith<_$_VotingPhaseViewModel> get copyWith =>
      __$$_VotingPhaseViewModelCopyWithImpl<_$_VotingPhaseViewModel>(
          this, _$identity);
}

abstract class _VotingPhaseViewModel implements SelectingPlayerPhaseViewModel {
  const factory _VotingPhaseViewModel(
      {required final List<PlayerWithAvatar> pseudoShuffledPlayerList,
      required final PlayerWithAvatar playerWhoseTurn,
      required final String playerWhoseTurnStatement,
      required final String roleDescriptionString,
      required final bool isMyTurn,
      required final bool isSaboteur}) = _$_VotingPhaseViewModel;

  @override
  List<PlayerWithAvatar> get pseudoShuffledPlayerList;
  @override
  PlayerWithAvatar get playerWhoseTurn;
  @override
  String get playerWhoseTurnStatement;
  @override
  String get roleDescriptionString;
  @override
  bool get isMyTurn;
  @override
  bool get isSaboteur;
  @override
  @JsonKey(ignore: true)
  _$$_VotingPhaseViewModelCopyWith<_$_VotingPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
