// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_notifier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NotificationNotifierState {
  List<Notification> get notifs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationNotifierStateCopyWith<NotificationNotifierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationNotifierStateCopyWith<$Res> {
  factory $NotificationNotifierStateCopyWith(NotificationNotifierState value,
          $Res Function(NotificationNotifierState) then) =
      _$NotificationNotifierStateCopyWithImpl<$Res, NotificationNotifierState>;
  @useResult
  $Res call({List<Notification> notifs});
}

/// @nodoc
class _$NotificationNotifierStateCopyWithImpl<$Res,
        $Val extends NotificationNotifierState>
    implements $NotificationNotifierStateCopyWith<$Res> {
  _$NotificationNotifierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifs = null,
  }) {
    return _then(_value.copyWith(
      notifs: null == notifs
          ? _value.notifs
          : notifs // ignore: cast_nullable_to_non_nullable
              as List<Notification>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NotificationNotifierStateCopyWith<$Res>
    implements $NotificationNotifierStateCopyWith<$Res> {
  factory _$$_NotificationNotifierStateCopyWith(
          _$_NotificationNotifierState value,
          $Res Function(_$_NotificationNotifierState) then) =
      __$$_NotificationNotifierStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Notification> notifs});
}

/// @nodoc
class __$$_NotificationNotifierStateCopyWithImpl<$Res>
    extends _$NotificationNotifierStateCopyWithImpl<$Res,
        _$_NotificationNotifierState>
    implements _$$_NotificationNotifierStateCopyWith<$Res> {
  __$$_NotificationNotifierStateCopyWithImpl(
      _$_NotificationNotifierState _value,
      $Res Function(_$_NotificationNotifierState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifs = null,
  }) {
    return _then(_$_NotificationNotifierState(
      notifs: null == notifs
          ? _value._notifs
          : notifs // ignore: cast_nullable_to_non_nullable
              as List<Notification>,
    ));
  }
}

/// @nodoc

class _$_NotificationNotifierState implements _NotificationNotifierState {
  _$_NotificationNotifierState({final List<Notification> notifs = const []})
      : _notifs = notifs;

  final List<Notification> _notifs;
  @override
  @JsonKey()
  List<Notification> get notifs {
    if (_notifs is EqualUnmodifiableListView) return _notifs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifs);
  }

  @override
  String toString() {
    return 'NotificationNotifierState(notifs: $notifs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationNotifierState &&
            const DeepCollectionEquality().equals(other._notifs, _notifs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notifs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotificationNotifierStateCopyWith<_$_NotificationNotifierState>
      get copyWith => __$$_NotificationNotifierStateCopyWithImpl<
          _$_NotificationNotifierState>(this, _$identity);
}

abstract class _NotificationNotifierState implements NotificationNotifierState {
  factory _NotificationNotifierState({final List<Notification> notifs}) =
      _$_NotificationNotifierState;

  @override
  List<Notification> get notifs;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationNotifierStateCopyWith<_$_NotificationNotifierState>
      get copyWith => throw _privateConstructorUsedError;
}
