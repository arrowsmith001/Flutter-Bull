// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameViewNotifierHash() => r'c9d6c10dfde96013e345e27616785697e3b1820e';

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

abstract class _$GameViewNotifier
    extends BuildlessStreamNotifier<GameViewModel> {
  late final String roomId;
  late final String userId;

  Stream<GameViewModel> build(
    String roomId,
    String userId,
  );
}

/// See also [GameViewNotifier].
@ProviderFor(GameViewNotifier)
const gameViewNotifierProvider = GameViewNotifierFamily();

/// See also [GameViewNotifier].
class GameViewNotifierFamily extends Family<AsyncValue<GameViewModel>> {
  /// See also [GameViewNotifier].
  const GameViewNotifierFamily();

  /// See also [GameViewNotifier].
  GameViewNotifierProvider call(
    String roomId,
    String userId,
  ) {
    return GameViewNotifierProvider(
      roomId,
      userId,
    );
  }

  @override
  GameViewNotifierProvider getProviderOverride(
    covariant GameViewNotifierProvider provider,
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
  String? get name => r'gameViewNotifierProvider';
}

/// See also [GameViewNotifier].
class GameViewNotifierProvider
    extends StreamNotifierProviderImpl<GameViewNotifier, GameViewModel> {
  /// See also [GameViewNotifier].
  GameViewNotifierProvider(
    String roomId,
    String userId,
  ) : this._internal(
          () => GameViewNotifier()
            ..roomId = roomId
            ..userId = userId,
          from: gameViewNotifierProvider,
          name: r'gameViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameViewNotifierHash,
          dependencies: GameViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              GameViewNotifierFamily._allTransitiveDependencies,
          roomId: roomId,
          userId: userId,
        );

  GameViewNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
    required this.userId,
  }) : super.internal();

  final String roomId;
  final String userId;

  @override
  Stream<GameViewModel> runNotifierBuild(
    covariant GameViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
      userId,
    );
  }

  @override
  Override overrideWith(GameViewNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameViewNotifierProvider._internal(
        () => create()
          ..roomId = roomId
          ..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
        userId: userId,
      ),
    );
  }

  @override
  StreamNotifierProviderElement<GameViewNotifier, GameViewModel>
      createElement() {
    return _GameViewNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GameViewNotifierProvider &&
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
}

mixin GameViewNotifierRef on StreamNotifierProviderRef<GameViewModel> {
  /// The parameter `roomId` of this provider.
  String get roomId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _GameViewNotifierProviderElement
    extends StreamNotifierProviderElement<GameViewNotifier, GameViewModel>
    with GameViewNotifierRef {
  _GameViewNotifierProviderElement(super.provider);

  @override
  String get roomId => (origin as GameViewNotifierProvider).roomId;
  @override
  String get userId => (origin as GameViewNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
