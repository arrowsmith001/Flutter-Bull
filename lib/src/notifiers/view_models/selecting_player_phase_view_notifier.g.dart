// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selecting_player_phase_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectingPlayerPhaseViewNotifierHash() =>
    r'ce1a260cbca480c41f8879bfd076c2130466dded';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SelectingPlayerPhaseViewNotifier
    extends BuildlessStreamNotifier<SelectingPlayerPhaseViewModel> {
  late final String roomId;
  late final String userId;
  late final String whoseTurnId;

  Stream<SelectingPlayerPhaseViewModel> build(
    String roomId,
    String userId,
    String whoseTurnId,
  );
}

/// See also [SelectingPlayerPhaseViewNotifier].
@ProviderFor(SelectingPlayerPhaseViewNotifier)
const selectingPlayerPhaseViewNotifierProvider =
    SelectingPlayerPhaseViewNotifierFamily();

/// See also [SelectingPlayerPhaseViewNotifier].
class SelectingPlayerPhaseViewNotifierFamily
    extends Family<AsyncValue<SelectingPlayerPhaseViewModel>> {
  /// See also [SelectingPlayerPhaseViewNotifier].
  const SelectingPlayerPhaseViewNotifierFamily();

  /// See also [SelectingPlayerPhaseViewNotifier].
  SelectingPlayerPhaseViewNotifierProvider call(
    String roomId,
    String userId,
    String whoseTurnId,
  ) {
    return SelectingPlayerPhaseViewNotifierProvider(
      roomId,
      userId,
      whoseTurnId,
    );
  }

  @override
  SelectingPlayerPhaseViewNotifierProvider getProviderOverride(
    covariant SelectingPlayerPhaseViewNotifierProvider provider,
  ) {
    return call(
      provider.roomId,
      provider.userId,
      provider.whoseTurnId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectingPlayerPhaseViewNotifierProvider';
}

/// See also [SelectingPlayerPhaseViewNotifier].
class SelectingPlayerPhaseViewNotifierProvider
    extends StreamNotifierProviderImpl<SelectingPlayerPhaseViewNotifier,
        SelectingPlayerPhaseViewModel> {
  /// See also [SelectingPlayerPhaseViewNotifier].
  SelectingPlayerPhaseViewNotifierProvider(
    this.roomId,
    this.userId,
    this.whoseTurnId,
  ) : super.internal(
          () => SelectingPlayerPhaseViewNotifier()
            ..roomId = roomId
            ..userId = userId
            ..whoseTurnId = whoseTurnId,
          from: selectingPlayerPhaseViewNotifierProvider,
          name: r'selectingPlayerPhaseViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectingPlayerPhaseViewNotifierHash,
          dependencies: SelectingPlayerPhaseViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              SelectingPlayerPhaseViewNotifierFamily._allTransitiveDependencies,
        );

  final String roomId;
  final String userId;
  final String whoseTurnId;

  @override
  bool operator ==(Object other) {
    return other is SelectingPlayerPhaseViewNotifierProvider &&
        other.roomId == roomId &&
        other.userId == userId &&
        other.whoseTurnId == whoseTurnId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, whoseTurnId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Stream<SelectingPlayerPhaseViewModel> runNotifierBuild(
    covariant SelectingPlayerPhaseViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
      userId,
      whoseTurnId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
