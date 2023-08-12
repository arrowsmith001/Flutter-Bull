// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writing_phase_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$writingPhaseViewNotifierHash() =>
    r'0f5992dac7f18a79835e3e7e6445d5c646acd2de';

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

abstract class _$WritingPhaseViewNotifier
    extends BuildlessStreamNotifier<WritingPhaseViewModel> {
  late final String roomId;
  late final String userId;

  Stream<WritingPhaseViewModel> build(
    String roomId,
    String userId,
  );
}

/// See also [WritingPhaseViewNotifier].
@ProviderFor(WritingPhaseViewNotifier)
const writingPhaseViewNotifierProvider = WritingPhaseViewNotifierFamily();

/// See also [WritingPhaseViewNotifier].
class WritingPhaseViewNotifierFamily
    extends Family<AsyncValue<WritingPhaseViewModel>> {
  /// See also [WritingPhaseViewNotifier].
  const WritingPhaseViewNotifierFamily();

  /// See also [WritingPhaseViewNotifier].
  WritingPhaseViewNotifierProvider call(
    String roomId,
    String userId,
  ) {
    return WritingPhaseViewNotifierProvider(
      roomId,
      userId,
    );
  }

  @override
  WritingPhaseViewNotifierProvider getProviderOverride(
    covariant WritingPhaseViewNotifierProvider provider,
  ) {
    return call(
      provider.roomId,
      provider.userId,
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
  String? get name => r'writingPhaseViewNotifierProvider';
}

/// See also [WritingPhaseViewNotifier].
class WritingPhaseViewNotifierProvider extends StreamNotifierProviderImpl<
    WritingPhaseViewNotifier, WritingPhaseViewModel> {
  /// See also [WritingPhaseViewNotifier].
  WritingPhaseViewNotifierProvider(
    this.roomId,
    this.userId,
  ) : super.internal(
          () => WritingPhaseViewNotifier()
            ..roomId = roomId
            ..userId = userId,
          from: writingPhaseViewNotifierProvider,
          name: r'writingPhaseViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$writingPhaseViewNotifierHash,
          dependencies: WritingPhaseViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              WritingPhaseViewNotifierFamily._allTransitiveDependencies,
        );

  final String roomId;
  final String userId;

  @override
  bool operator ==(Object other) {
    return other is WritingPhaseViewNotifierProvider &&
        other.roomId == roomId &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Stream<WritingPhaseViewModel> runNotifierBuild(
    covariant WritingPhaseViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
      userId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
