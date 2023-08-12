// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reveal_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$revealViewModelNotifierHash() =>
    r'e8d10a013f7544ad5b14cc5da2aca6f61caccd14';

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

abstract class _$RevealViewModelNotifier
    extends BuildlessAutoDisposeAsyncNotifier<RevealViewModel> {
  late final String roomId;
  late final String userId;
  late final String whoseTurnId;

  Future<RevealViewModel> build(
    String roomId,
    String userId,
    String whoseTurnId,
  );
}

/// See also [RevealViewModelNotifier].
@ProviderFor(RevealViewModelNotifier)
const revealViewModelNotifierProvider = RevealViewModelNotifierFamily();

/// See also [RevealViewModelNotifier].
class RevealViewModelNotifierFamily
    extends Family<AsyncValue<RevealViewModel>> {
  /// See also [RevealViewModelNotifier].
  const RevealViewModelNotifierFamily();

  /// See also [RevealViewModelNotifier].
  RevealViewModelNotifierProvider call(
    String roomId,
    String userId,
    String whoseTurnId,
  ) {
    return RevealViewModelNotifierProvider(
      roomId,
      userId,
      whoseTurnId,
    );
  }

  @override
  RevealViewModelNotifierProvider getProviderOverride(
    covariant RevealViewModelNotifierProvider provider,
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
  String? get name => r'revealViewModelNotifierProvider';
}

/// See also [RevealViewModelNotifier].
class RevealViewModelNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RevealViewModelNotifier,
        RevealViewModel> {
  /// See also [RevealViewModelNotifier].
  RevealViewModelNotifierProvider(
    this.roomId,
    this.userId,
    this.whoseTurnId,
  ) : super.internal(
          () => RevealViewModelNotifier()
            ..roomId = roomId
            ..userId = userId
            ..whoseTurnId = whoseTurnId,
          from: revealViewModelNotifierProvider,
          name: r'revealViewModelNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$revealViewModelNotifierHash,
          dependencies: RevealViewModelNotifierFamily._dependencies,
          allTransitiveDependencies:
              RevealViewModelNotifierFamily._allTransitiveDependencies,
        );

  final String roomId;
  final String userId;
  final String whoseTurnId;

  @override
  bool operator ==(Object other) {
    return other is RevealViewModelNotifierProvider &&
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
  Future<RevealViewModel> runNotifierBuild(
    covariant RevealViewModelNotifier notifier,
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
