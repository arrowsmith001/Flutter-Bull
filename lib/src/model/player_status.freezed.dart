// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayerStatus _$PlayerStatusFromJson(Map<String, dynamic> json) {
  return _PlayerStatus.fromJson(json);
}

/// @nodoc
mixin _$PlayerStatus {
  String? get id => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get busy => throw _privateConstructorUsedError;
  String get messageWhileBusy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerStatusCopyWith<PlayerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatusCopyWith<$Res> {
  factory $PlayerStatusCopyWith(
          PlayerStatus value, $Res Function(PlayerStatus) then) =
      _$PlayerStatusCopyWithImpl<$Res, PlayerStatus>;
  @useResult
  $Res call(
      {String? id, String? errorMessage, bool busy, String messageWhileBusy});
}

/// @nodoc
class _$PlayerStatusCopyWithImpl<$Res, $Val extends PlayerStatus>
    implements $PlayerStatusCopyWith<$Res> {
  _$PlayerStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? errorMessage = freezed,
    Object? busy = null,
    Object? messageWhileBusy = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      busy: null == busy
          ? _value.busy
          : busy // ignore: cast_nullable_to_non_nullable
              as bool,
      messageWhileBusy: null == messageWhileBusy
          ? _value.messageWhileBusy
          : messageWhileBusy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerStatusImplCopyWith<$Res>
    implements $PlayerStatusCopyWith<$Res> {
  factory _$$PlayerStatusImplCopyWith(
          _$PlayerStatusImpl value, $Res Function(_$PlayerStatusImpl) then) =
      __$$PlayerStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id, String? errorMessage, bool busy, String messageWhileBusy});
}

/// @nodoc
class __$$PlayerStatusImplCopyWithImpl<$Res>
    extends _$PlayerStatusCopyWithImpl<$Res, _$PlayerStatusImpl>
    implements _$$PlayerStatusImplCopyWith<$Res> {
  __$$PlayerStatusImplCopyWithImpl(
      _$PlayerStatusImpl _value, $Res Function(_$PlayerStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? errorMessage = freezed,
    Object? busy = null,
    Object? messageWhileBusy = null,
  }) {
    return _then(_$PlayerStatusImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      busy: null == busy
          ? _value.busy
          : busy // ignore: cast_nullable_to_non_nullable
              as bool,
      messageWhileBusy: null == messageWhileBusy
          ? _value.messageWhileBusy
          : messageWhileBusy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStatusImpl implements _PlayerStatus {
  const _$PlayerStatusImpl(
      {this.id,
      this.errorMessage,
      this.busy = false,
      this.messageWhileBusy = ''});

  factory _$PlayerStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStatusImplFromJson(json);

  @override
  final String? id;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool busy;
  @override
  @JsonKey()
  final String messageWhileBusy;

  @override
  String toString() {
    return 'PlayerStatus(id: $id, errorMessage: $errorMessage, busy: $busy, messageWhileBusy: $messageWhileBusy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.busy, busy) || other.busy == busy) &&
            (identical(other.messageWhileBusy, messageWhileBusy) ||
                other.messageWhileBusy == messageWhileBusy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, errorMessage, busy, messageWhileBusy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatusImplCopyWith<_$PlayerStatusImpl> get copyWith =>
      __$$PlayerStatusImplCopyWithImpl<_$PlayerStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStatusImplToJson(
      this,
    );
  }
}

abstract class _PlayerStatus implements PlayerStatus {
  const factory _PlayerStatus(
      {final String? id,
      final String? errorMessage,
      final bool busy,
      final String messageWhileBusy}) = _$PlayerStatusImpl;

  factory _PlayerStatus.fromJson(Map<String, dynamic> json) =
      _$PlayerStatusImpl.fromJson;

  @override
  String? get id;
  @override
  String? get errorMessage;
  @override
  bool get busy;
  @override
  String get messageWhileBusy;
  @override
  @JsonKey(ignore: true)
  _$$PlayerStatusImplCopyWith<_$PlayerStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
