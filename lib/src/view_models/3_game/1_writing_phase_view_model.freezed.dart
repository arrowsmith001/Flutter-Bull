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
  PublicPlayer get playerWritingFor => throw _privateConstructorUsedError;
  bool get writingTruthOrLie => throw _privateConstructorUsedError;
  WritingPrompt get writingPrompt => throw _privateConstructorUsedError;
  bool get hasSubmitted => throw _privateConstructorUsedError;
  int get playersSubmitted => throw _privateConstructorUsedError;
  String get playersSubmittedTextPrompt => throw _privateConstructorUsedError;

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
      {PublicPlayer playerWritingFor,
      bool writingTruthOrLie,
      WritingPrompt writingPrompt,
      bool hasSubmitted,
      int playersSubmitted,
      String playersSubmittedTextPrompt});
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
    Object? writingPrompt = null,
    Object? hasSubmitted = null,
    Object? playersSubmitted = null,
    Object? playersSubmittedTextPrompt = null,
  }) {
    return _then(_value.copyWith(
      playerWritingFor: null == playerWritingFor
          ? _value.playerWritingFor
          : playerWritingFor // ignore: cast_nullable_to_non_nullable
              as PublicPlayer,
      writingTruthOrLie: null == writingTruthOrLie
          ? _value.writingTruthOrLie
          : writingTruthOrLie // ignore: cast_nullable_to_non_nullable
              as bool,
      writingPrompt: null == writingPrompt
          ? _value.writingPrompt
          : writingPrompt // ignore: cast_nullable_to_non_nullable
              as WritingPrompt,
      hasSubmitted: null == hasSubmitted
          ? _value.hasSubmitted
          : hasSubmitted // ignore: cast_nullable_to_non_nullable
              as bool,
      playersSubmitted: null == playersSubmitted
          ? _value.playersSubmitted
          : playersSubmitted // ignore: cast_nullable_to_non_nullable
              as int,
      playersSubmittedTextPrompt: null == playersSubmittedTextPrompt
          ? _value.playersSubmittedTextPrompt
          : playersSubmittedTextPrompt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WritingPhaseViewModelImplCopyWith<$Res>
    implements $WritingPhaseViewModelCopyWith<$Res> {
  factory _$$WritingPhaseViewModelImplCopyWith(
          _$WritingPhaseViewModelImpl value,
          $Res Function(_$WritingPhaseViewModelImpl) then) =
      __$$WritingPhaseViewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PublicPlayer playerWritingFor,
      bool writingTruthOrLie,
      WritingPrompt writingPrompt,
      bool hasSubmitted,
      int playersSubmitted,
      String playersSubmittedTextPrompt});
}

/// @nodoc
class __$$WritingPhaseViewModelImplCopyWithImpl<$Res>
    extends _$WritingPhaseViewModelCopyWithImpl<$Res,
        _$WritingPhaseViewModelImpl>
    implements _$$WritingPhaseViewModelImplCopyWith<$Res> {
  __$$WritingPhaseViewModelImplCopyWithImpl(_$WritingPhaseViewModelImpl _value,
      $Res Function(_$WritingPhaseViewModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerWritingFor = null,
    Object? writingTruthOrLie = null,
    Object? writingPrompt = null,
    Object? hasSubmitted = null,
    Object? playersSubmitted = null,
    Object? playersSubmittedTextPrompt = null,
  }) {
    return _then(_$WritingPhaseViewModelImpl(
      playerWritingFor: null == playerWritingFor
          ? _value.playerWritingFor
          : playerWritingFor // ignore: cast_nullable_to_non_nullable
              as PublicPlayer,
      writingTruthOrLie: null == writingTruthOrLie
          ? _value.writingTruthOrLie
          : writingTruthOrLie // ignore: cast_nullable_to_non_nullable
              as bool,
      writingPrompt: null == writingPrompt
          ? _value.writingPrompt
          : writingPrompt // ignore: cast_nullable_to_non_nullable
              as WritingPrompt,
      hasSubmitted: null == hasSubmitted
          ? _value.hasSubmitted
          : hasSubmitted // ignore: cast_nullable_to_non_nullable
              as bool,
      playersSubmitted: null == playersSubmitted
          ? _value.playersSubmitted
          : playersSubmitted // ignore: cast_nullable_to_non_nullable
              as int,
      playersSubmittedTextPrompt: null == playersSubmittedTextPrompt
          ? _value.playersSubmittedTextPrompt
          : playersSubmittedTextPrompt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WritingPhaseViewModelImpl implements _WritingPhaseViewModel {
  _$WritingPhaseViewModelImpl(
      {required this.playerWritingFor,
      required this.writingTruthOrLie,
      required this.writingPrompt,
      required this.hasSubmitted,
      required this.playersSubmitted,
      required this.playersSubmittedTextPrompt});

  @override
  final PublicPlayer playerWritingFor;
  @override
  final bool writingTruthOrLie;
  @override
  final WritingPrompt writingPrompt;
  @override
  final bool hasSubmitted;
  @override
  final int playersSubmitted;
  @override
  final String playersSubmittedTextPrompt;

  @override
  String toString() {
    return 'WritingPhaseViewModel._(playerWritingFor: $playerWritingFor, writingTruthOrLie: $writingTruthOrLie, writingPrompt: $writingPrompt, hasSubmitted: $hasSubmitted, playersSubmitted: $playersSubmitted, playersSubmittedTextPrompt: $playersSubmittedTextPrompt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WritingPhaseViewModelImpl &&
            (identical(other.playerWritingFor, playerWritingFor) ||
                other.playerWritingFor == playerWritingFor) &&
            (identical(other.writingTruthOrLie, writingTruthOrLie) ||
                other.writingTruthOrLie == writingTruthOrLie) &&
            (identical(other.writingPrompt, writingPrompt) ||
                other.writingPrompt == writingPrompt) &&
            (identical(other.hasSubmitted, hasSubmitted) ||
                other.hasSubmitted == hasSubmitted) &&
            (identical(other.playersSubmitted, playersSubmitted) ||
                other.playersSubmitted == playersSubmitted) &&
            (identical(other.playersSubmittedTextPrompt,
                    playersSubmittedTextPrompt) ||
                other.playersSubmittedTextPrompt ==
                    playersSubmittedTextPrompt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      playerWritingFor,
      writingTruthOrLie,
      writingPrompt,
      hasSubmitted,
      playersSubmitted,
      playersSubmittedTextPrompt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WritingPhaseViewModelImplCopyWith<_$WritingPhaseViewModelImpl>
      get copyWith => __$$WritingPhaseViewModelImplCopyWithImpl<
          _$WritingPhaseViewModelImpl>(this, _$identity);
}

abstract class _WritingPhaseViewModel implements WritingPhaseViewModel {
  factory _WritingPhaseViewModel(
          {required final PublicPlayer playerWritingFor,
          required final bool writingTruthOrLie,
          required final WritingPrompt writingPrompt,
          required final bool hasSubmitted,
          required final int playersSubmitted,
          required final String playersSubmittedTextPrompt}) =
      _$WritingPhaseViewModelImpl;

  @override
  PublicPlayer get playerWritingFor;
  @override
  bool get writingTruthOrLie;
  @override
  WritingPrompt get writingPrompt;
  @override
  bool get hasSubmitted;
  @override
  int get playersSubmitted;
  @override
  String get playersSubmittedTextPrompt;
  @override
  @JsonKey(ignore: true)
  _$$WritingPhaseViewModelImplCopyWith<_$WritingPhaseViewModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
