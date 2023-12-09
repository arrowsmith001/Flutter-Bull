// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameHash() => r'5ef78f8b19fd4b7981381ffe619d3b1ed77df6f9';

/// See also [game].
@ProviderFor(game)
final gameProvider = AutoDisposeProvider<GameRoom?>.internal(
  game,
  name: r'gameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GameRef = AutoDisposeProviderRef<GameRoom?>;
String _$gameCodeHash() => r'2e80fc2080ab2b59542912f26cd9bba88228a9f8';

/// See also [gameCode].
@ProviderFor(gameCode)
final gameCodeProvider = AutoDisposeProvider<String?>.internal(
  gameCode,
  name: r'gameCodeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameCodeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GameCodeRef = AutoDisposeProviderRef<String?>;
String _$phaseHash() => r'9f3ec35232afc0f10d9ca84012a8abfb97a28e39';

/// See also [phase].
@ProviderFor(phase)
final phaseProvider = AutoDisposeProvider<GamePhase?>.internal(
  phase,
  name: r'phaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$phaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PhaseRef = AutoDisposeProviderRef<GamePhase?>;
String _$subphaseHash() => r'7e8be686d7270964405fe6472f60dd49c4d86145';

/// See also [subphase].
@ProviderFor(subphase)
final subphaseProvider = AutoDisposeProvider<int?>.internal(
  subphase,
  name: r'subphaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$subphaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SubphaseRef = AutoDisposeProviderRef<int?>;
String _$leaderIdHash() => r'73f83379b54d9d2e5edf3d9680c963e93bcf6ea1';

/// See also [leaderId].
@ProviderFor(leaderId)
final leaderIdProvider = Provider<String?>.internal(
  leaderId,
  name: r'leaderIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$leaderIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LeaderIdRef = ProviderRef<String?>;
String _$isLeaderHash() => r'fe2db66dbefb88f416f1d1448d69e15836e0c367';

/// See also [isLeader].
@ProviderFor(isLeader)
final isLeaderProvider = AutoDisposeProvider<bool>.internal(
  isLeader,
  name: r'isLeaderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isLeaderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsLeaderRef = AutoDisposeProviderRef<bool>;
String _$getIsReadyHash() => r'9fa452dfa1785898795eb2f6ab066477fe970df3';

/// See also [getIsReady].
@ProviderFor(getIsReady)
final getIsReadyProvider = AutoDisposeProvider<bool>.internal(
  getIsReady,
  name: r'getIsReadyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getIsReadyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetIsReadyRef = AutoDisposeProviderRef<bool>;
String _$getPlayerStateHash() => r'70fe4e3bd0bdb884b4676b6587d243b296b23145';

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

/// See also [getPlayerState].
@ProviderFor(getPlayerState)
const getPlayerStateProvider = GetPlayerStateFamily();

/// See also [getPlayerState].
class GetPlayerStateFamily extends Family<PlayerState?> {
  /// See also [getPlayerState].
  const GetPlayerStateFamily();

  /// See also [getPlayerState].
  GetPlayerStateProvider call(
    String? id,
  ) {
    return GetPlayerStateProvider(
      id,
    );
  }

  @override
  GetPlayerStateProvider getProviderOverride(
    covariant GetPlayerStateProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'getPlayerStateProvider';
}

/// See also [getPlayerState].
class GetPlayerStateProvider extends AutoDisposeProvider<PlayerState?> {
  /// See also [getPlayerState].
  GetPlayerStateProvider(
    String? id,
  ) : this._internal(
          (ref) => getPlayerState(
            ref as GetPlayerStateRef,
            id,
          ),
          from: getPlayerStateProvider,
          name: r'getPlayerStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPlayerStateHash,
          dependencies: GetPlayerStateFamily._dependencies,
          allTransitiveDependencies:
              GetPlayerStateFamily._allTransitiveDependencies,
          id: id,
        );

  GetPlayerStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  Override overrideWith(
    PlayerState? Function(GetPlayerStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPlayerStateProvider._internal(
        (ref) => create(ref as GetPlayerStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<PlayerState?> createElement() {
    return _GetPlayerStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPlayerStateProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPlayerStateRef on AutoDisposeProviderRef<PlayerState?> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetPlayerStateProviderElement
    extends AutoDisposeProviderElement<PlayerState?> with GetPlayerStateRef {
  _GetPlayerStateProviderElement(super.provider);

  @override
  String? get id => (origin as GetPlayerStateProvider).id;
}

String _$getNumberOfPlayersHash() =>
    r'd66158c1ff0ce6965cd9358337c5ee7cf7f5b3f4';

/// See also [getNumberOfPlayers].
@ProviderFor(getNumberOfPlayers)
final getNumberOfPlayersProvider = AutoDisposeProvider<int>.internal(
  getNumberOfPlayers,
  name: r'getNumberOfPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getNumberOfPlayersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetNumberOfPlayersRef = AutoDisposeProviderRef<int>;
String _$getEnoughPlayersHash() => r'be0d1c790b2e9b49a2cdc8f214722c42baf30e80';

/// See also [getEnoughPlayers].
@ProviderFor(getEnoughPlayers)
final getEnoughPlayersProvider = AutoDisposeProvider<bool>.internal(
  getEnoughPlayers,
  name: r'getEnoughPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEnoughPlayersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetEnoughPlayersRef = AutoDisposeProviderRef<bool>;
String _$getLobbyListInitialDataHash() =>
    r'5e98c5c31a93425558415d8ec92042691b2a870d';

/// See also [getLobbyListInitialData].
@ProviderFor(getLobbyListInitialData)
final getLobbyListInitialDataProvider =
    AutoDisposeProvider<List<LobbyPlayer>>.internal(
  getLobbyListInitialData,
  name: r'getLobbyListInitialDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLobbyListInitialDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLobbyListInitialDataRef = AutoDisposeProviderRef<List<LobbyPlayer>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
