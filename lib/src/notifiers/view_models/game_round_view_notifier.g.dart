// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_round_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameRoundViewNotifierHash() =>
    r'170175e946f09000225036cb7ec37075bd766ec4';

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
    String userId,
    String roomId,
    String whoseTurnId,
  ) : this._internal(
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
          userId: userId,
          roomId: roomId,
          whoseTurnId: whoseTurnId,
        );

  GameRoundViewNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.roomId,
    required this.whoseTurnId,
  }) : super.internal();

  final String userId;
  final String roomId;
  final String whoseTurnId;

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

  @override
  Override overrideWith(GameRoundViewNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GameRoundViewNotifierProvider._internal(
        () => create()
          ..userId = userId
          ..roomId = roomId
          ..whoseTurnId = whoseTurnId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        roomId: roomId,
        whoseTurnId: whoseTurnId,
      ),
    );
  }

  @override
  StreamNotifierProviderElement<GameRoundViewNotifier, GameRoundViewModel>
      createElement() {
    return _GameRoundViewNotifierProviderElement(this);
  }

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
}

mixin GameRoundViewNotifierRef
    on StreamNotifierProviderRef<GameRoundViewModel> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `roomId` of this provider.
  String get roomId;

  /// The parameter `whoseTurnId` of this provider.
  String get whoseTurnId;
}

class _GameRoundViewNotifierProviderElement
    extends StreamNotifierProviderElement<GameRoundViewNotifier,
        GameRoundViewModel> with GameRoundViewNotifierRef {
  _GameRoundViewNotifierProviderElement(super.provider);

  @override
  String get userId => (origin as GameRoundViewNotifierProvider).userId;
  @override
  String get roomId => (origin as GameRoundViewNotifierProvider).roomId;
  @override
  String get whoseTurnId =>
      (origin as GameRoundViewNotifierProvider).whoseTurnId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
