// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerNotifierHash() => r'76ab40597b71720fef7c2a102d69d38f02344477';

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

abstract class _$PlayerNotifier extends BuildlessStreamNotifier<PublicPlayer> {
  late final String userId;

  Stream<PublicPlayer> build(
    String userId,
  );
}

/// See also [PlayerNotifier].
@ProviderFor(PlayerNotifier)
const playerNotifierProvider = PlayerNotifierFamily();

/// See also [PlayerNotifier].
class PlayerNotifierFamily extends Family<AsyncValue<PublicPlayer>> {
  /// See also [PlayerNotifier].
  const PlayerNotifierFamily();

  /// See also [PlayerNotifier].
  PlayerNotifierProvider call(
    String userId,
  ) {
    return PlayerNotifierProvider(
      userId,
    );
  }

  @override
  PlayerNotifierProvider getProviderOverride(
    covariant PlayerNotifierProvider provider,
  ) {
    return call(
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
  String? get name => r'playerNotifierProvider';
}

/// See also [PlayerNotifier].
class PlayerNotifierProvider
    extends StreamNotifierProviderImpl<PlayerNotifier, PublicPlayer> {
  /// See also [PlayerNotifier].
  PlayerNotifierProvider(
    String userId,
  ) : this._internal(
          () => PlayerNotifier()..userId = userId,
          from: playerNotifierProvider,
          name: r'playerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playerNotifierHash,
          dependencies: PlayerNotifierFamily._dependencies,
          allTransitiveDependencies:
              PlayerNotifierFamily._allTransitiveDependencies,
          userId: userId,
        );

  PlayerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Stream<PublicPlayer> runNotifierBuild(
    covariant PlayerNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(PlayerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlayerNotifierProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  StreamNotifierProviderElement<PlayerNotifier, PublicPlayer> createElement() {
    return _PlayerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayerNotifierProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlayerNotifierRef on StreamNotifierProviderRef<PublicPlayer> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _PlayerNotifierProviderElement
    extends StreamNotifierProviderElement<PlayerNotifier, PublicPlayer>
    with PlayerNotifierRef {
  _PlayerNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as PlayerNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
