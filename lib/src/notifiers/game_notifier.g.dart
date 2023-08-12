// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameNotifierHash() => r'7557bf30153234caa98c889139cbf5985f164da4';

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

abstract class _$GameNotifier
    extends BuildlessStreamNotifier<GameNotifierState> {
  late final String? gameRoomId;

  Stream<GameNotifierState> build(
    String? gameRoomId,
  );
}

/// See also [GameNotifier].
@ProviderFor(GameNotifier)
const gameNotifierProvider = GameNotifierFamily();

/// See also [GameNotifier].
class GameNotifierFamily extends Family<AsyncValue<GameNotifierState>> {
  /// See also [GameNotifier].
  const GameNotifierFamily();

  /// See also [GameNotifier].
  GameNotifierProvider call(
    String? gameRoomId,
  ) {
    return GameNotifierProvider(
      gameRoomId,
    );
  }

  @override
  GameNotifierProvider getProviderOverride(
    covariant GameNotifierProvider provider,
  ) {
    return call(
      provider.gameRoomId,
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
  String? get name => r'gameNotifierProvider';
}

/// See also [GameNotifier].
class GameNotifierProvider
    extends StreamNotifierProviderImpl<GameNotifier, GameNotifierState> {
  /// See also [GameNotifier].
  GameNotifierProvider(
    this.gameRoomId,
  ) : super.internal(
          () => GameNotifier()..gameRoomId = gameRoomId,
          from: gameNotifierProvider,
          name: r'gameNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameNotifierHash,
          dependencies: GameNotifierFamily._dependencies,
          allTransitiveDependencies:
              GameNotifierFamily._allTransitiveDependencies,
        );

  final String? gameRoomId;

  @override
  bool operator ==(Object other) {
    return other is GameNotifierProvider && other.gameRoomId == gameRoomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, gameRoomId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Stream<GameNotifierState> runNotifierBuild(
    covariant GameNotifier notifier,
  ) {
    return notifier.build(
      gameRoomId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
