// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_round_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameRoundViewNotifierHash() =>
    r'85e577cc6ab4934aca7fc42f5780fba788d2b4d8';

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

abstract class _$GameRoundViewNotifier
    extends BuildlessStreamNotifier<GameRoundViewModel> {
  late final String userId;
  late final String roomId;
  late final String whoseTurnId;

  Stream<GameRoundViewModel> build(
    String userId,
    String roomId,
    String whoseTurnId,
  );
}

/// See also [GameRoundViewNotifier].
@ProviderFor(GameRoundViewNotifier)
const gameRoundViewNotifierProvider = GameRoundViewNotifierFamily();

/// See also [GameRoundViewNotifier].
class GameRoundViewNotifierFamily
    extends Family<AsyncValue<GameRoundViewModel>> {
  /// See also [GameRoundViewNotifier].
  const GameRoundViewNotifierFamily();

  /// See also [GameRoundViewNotifier].
  GameRoundViewNotifierProvider call(
    String userId,
    String roomId,
    String whoseTurnId,
  ) {
    return GameRoundViewNotifierProvider(
      userId,
      roomId,
      whoseTurnId,
    );
  }

  @override
  GameRoundViewNotifierProvider getProviderOverride(
    covariant GameRoundViewNotifierProvider provider,
  ) {
    return call(
      provider.userId,
      provider.roomId,
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
  String? get name => r'gameRoundViewNotifierProvider';
}

/// See also [GameRoundViewNotifier].
class GameRoundViewNotifierProvider extends StreamNotifierProviderImpl<
    GameRoundViewNotifier, GameRoundViewModel> {
  /// See also [GameRoundViewNotifier].
  GameRoundViewNotifierProvider(
    this.userId,
    this.roomId,
    this.whoseTurnId,
  ) : super.internal(
          () => GameRoundViewNotifier()
            ..userId = userId
            ..roomId = roomId
            ..whoseTurnId = whoseTurnId,
          from: gameRoundViewNotifierProvider,
          name: r'gameRoundViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameRoundViewNotifierHash,
          dependencies: GameRoundViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              GameRoundViewNotifierFamily._allTransitiveDependencies,
        );

  final String userId;
  final String roomId;
  final String whoseTurnId;

  @override
  bool operator ==(Object other) {
    return other is GameRoundViewNotifierProvider &&
        other.userId == userId &&
        other.roomId == roomId &&
        other.whoseTurnId == whoseTurnId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);
    hash = _SystemHash.combine(hash, whoseTurnId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Stream<GameRoundViewModel> runNotifierBuild(
    covariant GameRoundViewNotifier notifier,
  ) {
    return notifier.build(
      userId,
      roomId,
      whoseTurnId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
