// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '1_writing_phase_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WritingPhaseViewModel {
  PlayerWithAvatar get playerWritingFor => throw _privateConstructorUsedError;
  bool get writingTruthOrLie => throw _privateConstructorUsedError;
  String get writingPromptString => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WritingPhaseViewModelCopyWith<WritingPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WritingPhaseViewModelCopyWith<$Res> {
  factory $WritingPhaseViewModelCopyWith(WritingPhaseViewModel value,
          $Res Function(WritingPhaseViewModel) then) =
      _$WritingPhaseViewModelCopyWithImpl<$Res, WritingPhaseViewModel>;
  @useResult
  $Res call(
      {PlayerWithAvatar playerWritingFor,
      bool writingTruthOrLie,
      String writingPromptString});
}

/// @nodoc
class _$WritingPhaseViewModelCopyWithImpl<$Res,
        $Val extends WritingPhaseViewModel>
    implements $WritingPhaseViewModelCopyWith<$Res> {
  _$WritingPhaseViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerWritingFor = null,
    Object? writingTruthOrLie = null,
    Object? writingPromptString = null,
  }) {
    return _then(_value.copyWith(
      playerWritingFor: null == playerWritingFor
          ? _value.playerWritingFor
          : playerWritingFor // ignore: cast_nullable_to_non_nullable
              as PlayerWithAvatar,
      writingTruthOrLie: null == writingTruthOrLie
          ? _value.writingTruthOrLie
          : writingTruthOrLie // ignore: cast_nullable_to_non_nullable
              as bool,
      writingPromptString: null == writingPromptString
          ? _value.writingPromptString
          : writingPromptString // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WritingPhaseViewModelCopyWith<$Res>
    implements $WritingPhaseViewModelCopyWith<$Res> {
  factory _$$_WritingPhaseViewModelCopyWith(_$_WritingPhaseViewModel value,
          $Res Function(_$_WritingPhaseViewModel) then) =
      __$$_WritingPhaseViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PlayerWithAvatar playerWritingFor,
      bool writingTruthOrLie,
      String writingPromptString});
}

/// @nodoc
class __$$_WritingPhaseViewModelCopyWithImpl<$Res>
    extends _$WritingPhaseViewModelCopyWithImpl<$Res, _$_WritingPhaseViewModel>
    implements _$$_WritingPhaseViewModelCopyWith<$Res> {
  __$$_WritingPhaseViewModelCopyWithImpl(_$_WritingPhaseViewModel _value,
      $Res Function(_$_WritingPhaseViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerWritingFor = null,
    Object? writingTruthOrLie = null,
    Object? writingPromptString = null,
  }) {
    return _then(_$_WritingPhaseViewModel(
      playerWritingFor: null == playerWritingFor
          ? _value.playerWritingFor
          : playerWritingFor // ignore: cast_nullable_to_non_nullable
              as PlayerWithAvatar,
      writingTruthOrLie: null == writingTruthOrLie
          ? _value.writingTruthOrLie
          : writingTruthOrLie // ignore: cast_nullable_to_non_nullable
              as bool,
      writingPromptString: null == writingPromptString
          ? _value.writingPromptString
          : writingPromptString // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WritingPhaseViewModel implements _WritingPhaseViewModel {
  _$_WritingPhaseViewModel(
      {required this.playerWritingFor,
      required this.writingTruthOrLie,
      required this.writingPromptString});

  @override
  final PlayerWithAvatar playerWritingFor;
  @override
  final bool writingTruthOrLie;
  @override
  final String writingPromptString;

  @override
  String toString() {
    return 'WritingPhaseViewModel._(playerWritingFor: $playerWritingFor, writingTruthOrLie: $writingTruthOrLie, writingPromptString: $writingPromptString)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WritingPhaseViewModel &&
            (identical(other.playerWritingFor, playerWritingFor) ||
                other.playerWritingFor == playerWritingFor) &&
            (identical(other.writingTruthOrLie, writingTruthOrLie) ||
                other.writingTruthOrLie == writingTruthOrLie) &&
            (identical(other.writingPromptString, writingPromptString) ||
                other.writingPromptString == writingPromptString));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, playerWritingFor, writingTruthOrLie, writingPromptString);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WritingPhaseViewModelCopyWith<_$_WritingPhaseViewModel> get copyWith =>
      __$$_WritingPhaseViewModelCopyWithImpl<_$_WritingPhaseViewModel>(
          this, _$identity);
}

abstract class _WritingPhaseViewModel implements WritingPhaseViewModel {
  factory _WritingPhaseViewModel(
      {required final PlayerWithAvatar playerWritingFor,
      required final bool writingTruthOrLie,
      required final String writingPromptString}) = _$_WritingPhaseViewModel;

  @override
  PlayerWithAvatar get playerWritingFor;
  @override
  bool get writingTruthOrLie;
  @override
  String get writingPromptString;
  @override
  @JsonKey(ignore: true)
  _$$_WritingPhaseViewModelCopyWith<_$_WritingPhaseViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
