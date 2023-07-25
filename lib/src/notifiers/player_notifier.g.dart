// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerNotifierHash() => r'c81a0555b0c5ef018eb1c1dc3b1ff9bc641fcb12';

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
  late final String? arg;

  Stream<Player> build(
    String? arg,
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
    String? arg,
  ) {
    return PlayerNotifierProvider(
      arg,
    );
  }

  @override
  PlayerNotifierProvider getProviderOverride(
    covariant PlayerNotifierProvider provider,
  ) {
    return call(
      provider.arg,
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
    this.arg,
  ) : super.internal(
          () => PlayerNotifier()..arg = arg,
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

  final String? arg;

  @override
  bool operator ==(Object other) {
    return other is PlayerNotifierProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Stream<Player> runNotifierBuild(
    covariant PlayerNotifier notifier,
  ) {
    return notifier.build(
      arg,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
