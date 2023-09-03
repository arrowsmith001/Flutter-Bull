// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reveal_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$revealViewNotifierHash() =>
    r'bd304c41e6c15fac083da0fe4bea50bf34b15843';

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

abstract class _$RevealViewNotifier
    extends BuildlessStreamNotifier<RevealViewModel> {
  late final String roomId;
  late final String userId;
  late final String whoseTurnId;

  Stream<RevealViewModel> build(
    String roomId,
    String userId,
    String whoseTurnId,
  );
}

/// See also [RevealViewNotifier].
@ProviderFor(RevealViewNotifier)
const revealViewNotifierProvider = RevealViewNotifierFamily();

/// See also [RevealViewNotifier].
class RevealViewNotifierFamily extends Family<AsyncValue<RevealViewModel>> {
  /// See also [RevealViewNotifier].
  const RevealViewNotifierFamily();

  /// See also [RevealViewNotifier].
  RevealViewNotifierProvider call(
    String roomId,
    String userId,
    String whoseTurnId,
  ) {
    return RevealViewNotifierProvider(
      roomId,
      userId,
      whoseTurnId,
    );
  }

  @override
  RevealViewNotifierProvider getProviderOverride(
    covariant RevealViewNotifierProvider provider,
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
  String? get name => r'revealViewNotifierProvider';
}

/// See also [RevealViewNotifier].
class RevealViewNotifierProvider
    extends StreamNotifierProviderImpl<RevealViewNotifier, RevealViewModel> {
  /// See also [RevealViewNotifier].
  RevealViewNotifierProvider(
    this.roomId,
    this.userId,
    this.whoseTurnId,
  ) : super.internal(
          () => RevealViewNotifier()
            ..roomId = roomId
            ..userId = userId
            ..whoseTurnId = whoseTurnId,
          from: revealViewNotifierProvider,
          name: r'revealViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$revealViewNotifierHash,
          dependencies: RevealViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              RevealViewNotifierFamily._allTransitiveDependencies,
        );

  final String roomId;
  final String userId;
  final String whoseTurnId;

  @override
  bool operator ==(Object other) {
    return other is RevealViewNotifierProvider &&
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
  Stream<RevealViewModel> runNotifierBuild(
    covariant RevealViewNotifier notifier,
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
