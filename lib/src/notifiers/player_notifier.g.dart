// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerNotifierHash() => r'c9c421bd68465f0512b25a200b5ec440d67f08bc';

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

abstract class _$PlayerNotifier extends BuildlessStreamNotifier<Player> {
  late final String? userId;

  Stream<Player> build(
    String? userId,
  );
}

/// See also [PlayerNotifier].
@ProviderFor(PlayerNotifier)
const playerNotifierProvider = PlayerNotifierFamily();

/// See also [PlayerNotifier].
class PlayerNotifierFamily extends Family<AsyncValue<Player>> {
  /// See also [PlayerNotifier].
  const PlayerNotifierFamily();

  /// See also [PlayerNotifier].
  PlayerNotifierProvider call(
    String? userId,
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
    extends StreamNotifierProviderImpl<PlayerNotifier, Player> {
  /// See also [PlayerNotifier].
  PlayerNotifierProvider(
    this.userId,
  ) : super.internal(
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
        );

  final String? userId;

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

  @override
  Stream<Player> runNotifierBuild(
    covariant PlayerNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
