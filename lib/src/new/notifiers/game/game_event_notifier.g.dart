// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_event_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameEventNotifierHash() => r'0bb47ad4346b85b8fbd1bc98a61cbc48d593c970';

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

abstract class _$GameEventNotifier extends BuildlessStreamNotifier<GameEvents> {
  late final String? gameId;

  Stream<GameEvents> build(
    String? gameId,
  );
}

/// See also [GameEventNotifier].
@ProviderFor(GameEventNotifier)
const gameEventNotifierProvider = GameEventNotifierFamily();

/// See also [GameEventNotifier].
class GameEventNotifierFamily extends Family<AsyncValue<GameEvents>> {
  /// See also [GameEventNotifier].
  const GameEventNotifierFamily();

  /// See also [GameEventNotifier].
  GameEventNotifierProvider call(
    String? gameId,
  ) {
    return GameEventNotifierProvider(
      gameId,
    );
  }

  @override
  GameEventNotifierProvider getProviderOverride(
    covariant GameEventNotifierProvider provider,
  ) {
    return call(
      provider.gameId,
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
  String? get name => r'gameEventNotifierProvider';
}

/// See also [GameEventNotifier].
class GameEventNotifierProvider
    extends StreamNotifierProviderImpl<GameEventNotifier, GameEvents> {
  /// See also [GameEventNotifier].
  GameEventNotifierProvider(
    String? gameId,
  ) : this._internal(
          () => GameEventNotifier()..gameId = gameId,
          from: gameEventNotifierProvider,
          name: r'gameEventNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameEventNotifierHash,
          dependencies: GameEventNotifierFamily._dependencies,
          allTransitiveDependencies:
              GameEventNotifierFamily._allTransitiveDependencies,
          gameId: gameId,
        );

  GameEventNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.gameId,
  }) : super.internal();

  final String? gameId;

  @override
  Stream<GameEvents> runNotifierBuild(
    covariant GameEventNotifier notifier,
  ) {
    return notifier.build(
      gameId,
    );
  }

  @override
  Override overrideWith(GameEventNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameEventNotifierProvider._internal(
        () => create()..gameId = gameId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        gameId: gameId,
      ),
    );
  }

  @override
  StreamNotifierProviderElement<GameEventNotifier, GameEvents> createElement() {
    return _GameEventNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameEventNotifierProvider && other.gameId == gameId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GameEventNotifierRef on StreamNotifierProviderRef<GameEvents> {
  /// The parameter `gameId` of this provider.
  String? get gameId;
}

class _GameEventNotifierProviderElement
    extends StreamNotifierProviderElement<GameEventNotifier, GameEvents>
    with GameEventNotifierRef {
  _GameEventNotifierProviderElement(super.provider);

  @override
  String? get gameId => (origin as GameEventNotifierProvider).gameId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
