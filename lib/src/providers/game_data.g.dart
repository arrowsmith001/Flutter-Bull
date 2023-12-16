// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamGameHash() => r'af7b85d8b3a5b9fefca3e0ce50cef3b7c88906ea';

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

/// See also [streamGame].
@ProviderFor(streamGame)
const streamGameProvider = StreamGameFamily();

/// See also [streamGame].
class StreamGameFamily extends Family<AsyncValue<GameRoom>> {
  /// See also [streamGame].
  const StreamGameFamily();

  /// See also [streamGame].
  StreamGameProvider call(
    String? id,
  ) {
    return StreamGameProvider(
      id,
    );
  }

  @override
  StreamGameProvider getProviderOverride(
    covariant StreamGameProvider provider,
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
  String? get name => r'streamGameProvider';
}

/// See also [streamGame].
class StreamGameProvider extends StreamProvider<GameRoom> {
  /// See also [streamGame].
  StreamGameProvider(
    String? id,
  ) : this._internal(
          (ref) => streamGame(
            ref as StreamGameRef,
            id,
          ),
          from: streamGameProvider,
          name: r'streamGameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamGameHash,
          dependencies: StreamGameFamily._dependencies,
          allTransitiveDependencies:
              StreamGameFamily._allTransitiveDependencies,
          id: id,
        );

  StreamGameProvider._internal(
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
    Stream<GameRoom> Function(StreamGameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamGameProvider._internal(
        (ref) => create(ref as StreamGameRef),
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
  StreamProviderElement<GameRoom> createElement() {
    return _StreamGameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamGameProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamGameRef on StreamProviderRef<GameRoom> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _StreamGameProviderElement extends StreamProviderElement<GameRoom>
    with StreamGameRef {
  _StreamGameProviderElement(super.provider);

  @override
  String? get id => (origin as StreamGameProvider).id;
}

String _$streamPlayerHash() => r'07f6ee28ebf6761bff2b1cef8a3cb746dfeaaf1f';

/// See also [streamPlayer].
@ProviderFor(streamPlayer)
const streamPlayerProvider = StreamPlayerFamily();

/// See also [streamPlayer].
class StreamPlayerFamily extends Family<AsyncValue<PublicPlayer>> {
  /// See also [streamPlayer].
  const StreamPlayerFamily();

  /// See also [streamPlayer].
  StreamPlayerProvider call(
    String? id,
  ) {
    return StreamPlayerProvider(
      id,
    );
  }

  @override
  StreamPlayerProvider getProviderOverride(
    covariant StreamPlayerProvider provider,
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
  String? get name => r'streamPlayerProvider';
}

/// See also [streamPlayer].
class StreamPlayerProvider extends StreamProvider<PublicPlayer> {
  /// See also [streamPlayer].
  StreamPlayerProvider(
    String? id,
  ) : this._internal(
          (ref) => streamPlayer(
            ref as StreamPlayerRef,
            id,
          ),
          from: streamPlayerProvider,
          name: r'streamPlayerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamPlayerHash,
          dependencies: StreamPlayerFamily._dependencies,
          allTransitiveDependencies:
              StreamPlayerFamily._allTransitiveDependencies,
          id: id,
        );

  StreamPlayerProvider._internal(
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
    Stream<PublicPlayer> Function(StreamPlayerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamPlayerProvider._internal(
        (ref) => create(ref as StreamPlayerRef),
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
  StreamProviderElement<PublicPlayer> createElement() {
    return _StreamPlayerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamPlayerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamPlayerRef on StreamProviderRef<PublicPlayer> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _StreamPlayerProviderElement extends StreamProviderElement<PublicPlayer>
    with StreamPlayerRef {
  _StreamPlayerProviderElement(super.provider);

  @override
  String? get id => (origin as StreamPlayerProvider).id;
}

String _$getGameHash() => r'344a6f65de674f3ae010fd4e856bbca9c9d5461c';

/// See also [getGame].
@ProviderFor(getGame)
final getGameProvider = Provider<GameRoom?>.internal(
  getGame,
  name: r'getGameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getGameHash,
  dependencies: <ProviderOrFamily>[
    getCurrentGameRoomIdProvider,
    streamGameProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getCurrentGameRoomIdProvider,
    ...?getCurrentGameRoomIdProvider.allTransitiveDependencies,
    streamGameProvider,
    ...?streamGameProvider.allTransitiveDependencies
  },
);

typedef GetGameRef = ProviderRef<GameRoom?>;
String _$getPlayersHash() => r'10a2ff5241181046dea32ecf5577f8800426a282';

/// See also [getPlayers].
@ProviderFor(getPlayers)
final getPlayersProvider = Provider<Map<String, PublicPlayer>?>.internal(
  getPlayers,
  name: r'getPlayersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPlayersHash,
  dependencies: <ProviderOrFamily>[getCurrentGameRoomIdProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getCurrentGameRoomIdProvider,
    ...?getCurrentGameRoomIdProvider.allTransitiveDependencies
  },
);

typedef GetPlayersRef = ProviderRef<Map<String, PublicPlayer>?>;
String _$getGameCodeHash() => r'79c7f39c64124658ec37789ace4f950109379079';

/// See also [getGameCode].
@ProviderFor(getGameCode)
final getGameCodeProvider = Provider<String?>.internal(
  getGameCode,
  name: r'getGameCodeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getGameCodeHash,
  dependencies: <ProviderOrFamily>[getCurrentGameRoomIdProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getCurrentGameRoomIdProvider,
    ...?getCurrentGameRoomIdProvider.allTransitiveDependencies
  },
);

typedef GetGameCodeRef = ProviderRef<String?>;
String _$getPhaseHash() => r'bb6b4bed3ed3913b884a44852a4412d40ed94f1e';

/// See also [getPhase].
@ProviderFor(getPhase)
final getPhaseProvider = Provider<GamePhase?>.internal(
  getPhase,
  name: r'getPhaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPhaseHash,
  dependencies: <ProviderOrFamily>[getGameProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  },
);

typedef GetPhaseRef = ProviderRef<GamePhase?>;
String _$getSubphaseHash() => r'3d04e10000cee262ecb418b3a3bf68791db63ead';

/// See also [getSubphase].
@ProviderFor(getSubphase)
final getSubphaseProvider = Provider<int?>.internal(
  getSubphase,
  name: r'getSubphaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getSubphaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetSubphaseRef = ProviderRef<int?>;
String _$getLeaderIdHash() => r'016635dac79e3313559ea84e98e8d871f258d685';

/// See also [getLeaderId].
@ProviderFor(getLeaderId)
final getLeaderIdProvider = Provider<String?>.internal(
  getLeaderId,
  name: r'getLeaderIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getLeaderIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLeaderIdRef = ProviderRef<String?>;
String _$getPseudoShuffledIdsHash() =>
    r'5583fb3fc147b6f537eee119aef7aba6eebdfb49';

/// See also [getPseudoShuffledIds].
@ProviderFor(getPseudoShuffledIds)
final getPseudoShuffledIdsProvider = Provider<List<String>>.internal(
  getPseudoShuffledIds,
  name: r'getPseudoShuffledIdsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPseudoShuffledIdsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetPseudoShuffledIdsRef = ProviderRef<List<String>>;
String _$getIsUserLeaderHash() => r'73b4ea50abebfd3d80ceb836b3bfbf4045634058';

/// See also [getIsUserLeader].
@ProviderFor(getIsUserLeader)
final getIsUserLeaderProvider = AutoDisposeProvider<bool>.internal(
  getIsUserLeader,
  name: r'getIsUserLeaderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getIsUserLeaderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetIsUserLeaderRef = AutoDisposeProviderRef<bool>;
String _$getIsUserReadyHash() => r'42e4497d50891372c6909373a2572d48678a9662';

/// See also [getIsUserReady].
@ProviderFor(getIsUserReady)
final getIsUserReadyProvider = AutoDisposeProvider<bool>.internal(
  getIsUserReady,
  name: r'getIsUserReadyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getIsUserReadyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetIsUserReadyRef = AutoDisposeProviderRef<bool>;
String _$getPlayerStateHash() => r'2cb77db56e70d9bc11b2738d8cc5f433b50a5b04';

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
class GetPlayerStateProvider extends Provider<PlayerState?> {
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
  ProviderElement<PlayerState?> createElement() {
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

mixin GetPlayerStateRef on ProviderRef<PlayerState?> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetPlayerStateProviderElement extends ProviderElement<PlayerState?>
    with GetPlayerStateRef {
  _GetPlayerStateProviderElement(super.provider);

  @override
  String? get id => (origin as GetPlayerStateProvider).id;
}

String _$getNumberOfPlayersHash() =>
    r'99dfc345155777099552e7313eb32352a05eda85';

/// See also [getNumberOfPlayers].
@ProviderFor(getNumberOfPlayers)
final getNumberOfPlayersProvider = Provider<int>.internal(
  getNumberOfPlayers,
  name: r'getNumberOfPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getNumberOfPlayersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetNumberOfPlayersRef = ProviderRef<int>;
String _$getHasEnoughPlayersHash() =>
    r'0e2e659aec2cc48ebd2369f16c142a355d7a96ae';

/// See also [getHasEnoughPlayers].
@ProviderFor(getHasEnoughPlayers)
final getHasEnoughPlayersProvider = AutoDisposeProvider<bool>.internal(
  getHasEnoughPlayers,
  name: r'getHasEnoughPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getHasEnoughPlayersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetHasEnoughPlayersRef = AutoDisposeProviderRef<bool>;
String _$lobbyListInitialDataHash() =>
    r'c308173ac26beafd875b32664a92a6a5cbd27b1d';

/// See also [lobbyListInitialData].
@ProviderFor(lobbyListInitialData)
final lobbyListInitialDataProvider = Provider<List<LobbyPlayer>>.internal(
  lobbyListInitialData,
  name: r'lobbyListInitialDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lobbyListInitialDataHash,
  dependencies: <ProviderOrFamily>[
    getCurrentGameRoomIdProvider,
    getGameProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getCurrentGameRoomIdProvider,
    ...?getCurrentGameRoomIdProvider.allTransitiveDependencies,
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  },
);

typedef LobbyListInitialDataRef = ProviderRef<List<LobbyPlayer>>;
String _$userHash() => r'cec602eb70f3700966796fcaa4026dc719f42433';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeProvider<PublicPlayer?>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = AutoDisposeProviderRef<PublicPlayer?>;
String _$canStartGameHash() => r'f3bb95d41c62a104f01a2c8fbdaf04755421ef10';

/// See also [canStartGame].
@ProviderFor(canStartGame)
final canStartGameProvider = AutoDisposeProvider<bool>.internal(
  canStartGame,
  name: r'canStartGameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$canStartGameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CanStartGameRef = AutoDisposeProviderRef<bool>;
String _$isMidGameHash() => r'bc226e8669678061d9d70bc33e60e9db908999d2';

/// See also [isMidGame].
@ProviderFor(isMidGame)
final isMidGameProvider = AutoDisposeProvider<bool>.internal(
  isMidGame,
  name: r'isMidGameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isMidGameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsMidGameRef = AutoDisposeProviderRef<bool>;
String _$isPlayerReadyHash() => r'6d5d593e0e5a181059fdd4330db0cf8b571ac8ce';

/// See also [isPlayerReady].
@ProviderFor(isPlayerReady)
const isPlayerReadyProvider = IsPlayerReadyFamily();

/// See also [isPlayerReady].
class IsPlayerReadyFamily extends Family<bool> {
  /// See also [isPlayerReady].
  const IsPlayerReadyFamily();

  /// See also [isPlayerReady].
  IsPlayerReadyProvider call(
    String? id,
  ) {
    return IsPlayerReadyProvider(
      id,
    );
  }

  @override
  IsPlayerReadyProvider getProviderOverride(
    covariant IsPlayerReadyProvider provider,
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
  String? get name => r'isPlayerReadyProvider';
}

/// See also [isPlayerReady].
class IsPlayerReadyProvider extends AutoDisposeProvider<bool> {
  /// See also [isPlayerReady].
  IsPlayerReadyProvider(
    String? id,
  ) : this._internal(
          (ref) => isPlayerReady(
            ref as IsPlayerReadyRef,
            id,
          ),
          from: isPlayerReadyProvider,
          name: r'isPlayerReadyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isPlayerReadyHash,
          dependencies: IsPlayerReadyFamily._dependencies,
          allTransitiveDependencies:
              IsPlayerReadyFamily._allTransitiveDependencies,
          id: id,
        );

  IsPlayerReadyProvider._internal(
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
    bool Function(IsPlayerReadyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsPlayerReadyProvider._internal(
        (ref) => create(ref as IsPlayerReadyRef),
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
  AutoDisposeProviderElement<bool> createElement() {
    return _IsPlayerReadyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsPlayerReadyProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsPlayerReadyRef on AutoDisposeProviderRef<bool> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _IsPlayerReadyProviderElement extends AutoDisposeProviderElement<bool>
    with IsPlayerReadyRef {
  _IsPlayerReadyProviderElement(super.provider);

  @override
  String? get id => (origin as IsPlayerReadyProvider).id;
}

String _$isPlayerLeaderHash() => r'fd003b216b69edaff3dc58f97b9a04821da5a7e4';

/// See also [isPlayerLeader].
@ProviderFor(isPlayerLeader)
const isPlayerLeaderProvider = IsPlayerLeaderFamily();

/// See also [isPlayerLeader].
class IsPlayerLeaderFamily extends Family<bool> {
  /// See also [isPlayerLeader].
  const IsPlayerLeaderFamily();

  /// See also [isPlayerLeader].
  IsPlayerLeaderProvider call(
    String? id,
  ) {
    return IsPlayerLeaderProvider(
      id,
    );
  }

  @override
  IsPlayerLeaderProvider getProviderOverride(
    covariant IsPlayerLeaderProvider provider,
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
  String? get name => r'isPlayerLeaderProvider';
}

/// See also [isPlayerLeader].
class IsPlayerLeaderProvider extends AutoDisposeProvider<bool> {
  /// See also [isPlayerLeader].
  IsPlayerLeaderProvider(
    String? id,
  ) : this._internal(
          (ref) => isPlayerLeader(
            ref as IsPlayerLeaderRef,
            id,
          ),
          from: isPlayerLeaderProvider,
          name: r'isPlayerLeaderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isPlayerLeaderHash,
          dependencies: IsPlayerLeaderFamily._dependencies,
          allTransitiveDependencies:
              IsPlayerLeaderFamily._allTransitiveDependencies,
          id: id,
        );

  IsPlayerLeaderProvider._internal(
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
    bool Function(IsPlayerLeaderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsPlayerLeaderProvider._internal(
        (ref) => create(ref as IsPlayerLeaderRef),
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
  AutoDisposeProviderElement<bool> createElement() {
    return _IsPlayerLeaderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsPlayerLeaderProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsPlayerLeaderRef on AutoDisposeProviderRef<bool> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _IsPlayerLeaderProviderElement extends AutoDisposeProviderElement<bool>
    with IsPlayerLeaderRef {
  _IsPlayerLeaderProviderElement(super.provider);

  @override
  String? get id => (origin as IsPlayerLeaderProvider).id;
}

String _$numberOfPlayersSubmittedTextHash() =>
    r'b30855157f81bff4eb51431bea87e67347c1eae7';

/// See also [numberOfPlayersSubmittedText].
@ProviderFor(numberOfPlayersSubmittedText)
final numberOfPlayersSubmittedTextProvider = AutoDisposeProvider<int>.internal(
  numberOfPlayersSubmittedText,
  name: r'numberOfPlayersSubmittedTextProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$numberOfPlayersSubmittedTextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NumberOfPlayersSubmittedTextRef = AutoDisposeProviderRef<int>;
String _$isPlayerTruthOrLieHash() =>
    r'b887ec87ef87166ae94ee01dc7fb21435972c066';

/// See also [isPlayerTruthOrLie].
@ProviderFor(isPlayerTruthOrLie)
const isPlayerTruthOrLieProvider = IsPlayerTruthOrLieFamily();

/// See also [isPlayerTruthOrLie].
class IsPlayerTruthOrLieFamily extends Family<bool> {
  /// See also [isPlayerTruthOrLie].
  const IsPlayerTruthOrLieFamily();

  /// See also [isPlayerTruthOrLie].
  IsPlayerTruthOrLieProvider call(
    String? id,
  ) {
    return IsPlayerTruthOrLieProvider(
      id,
    );
  }

  @override
  IsPlayerTruthOrLieProvider getProviderOverride(
    covariant IsPlayerTruthOrLieProvider provider,
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
  String? get name => r'isPlayerTruthOrLieProvider';
}

/// See also [isPlayerTruthOrLie].
class IsPlayerTruthOrLieProvider extends Provider<bool> {
  /// See also [isPlayerTruthOrLie].
  IsPlayerTruthOrLieProvider(
    String? id,
  ) : this._internal(
          (ref) => isPlayerTruthOrLie(
            ref as IsPlayerTruthOrLieRef,
            id,
          ),
          from: isPlayerTruthOrLieProvider,
          name: r'isPlayerTruthOrLieProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isPlayerTruthOrLieHash,
          dependencies: IsPlayerTruthOrLieFamily._dependencies,
          allTransitiveDependencies:
              IsPlayerTruthOrLieFamily._allTransitiveDependencies,
          id: id,
        );

  IsPlayerTruthOrLieProvider._internal(
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
    bool Function(IsPlayerTruthOrLieRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsPlayerTruthOrLieProvider._internal(
        (ref) => create(ref as IsPlayerTruthOrLieRef),
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
  ProviderElement<bool> createElement() {
    return _IsPlayerTruthOrLieProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsPlayerTruthOrLieProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsPlayerTruthOrLieRef on ProviderRef<bool> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _IsPlayerTruthOrLieProviderElement extends ProviderElement<bool>
    with IsPlayerTruthOrLieRef {
  _IsPlayerTruthOrLieProviderElement(super.provider);

  @override
  String? get id => (origin as IsPlayerTruthOrLieProvider).id;
}

String _$userWritingPromptHash() => r'65aa932a744a70d06503ec8de25f6aff45716fa0';

/// See also [userWritingPrompt].
@ProviderFor(userWritingPrompt)
final userWritingPromptProvider = AutoDisposeProvider<WritingPrompt>.internal(
  userWritingPrompt,
  name: r'userWritingPromptProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userWritingPromptHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserWritingPromptRef = AutoDisposeProviderRef<WritingPrompt>;
String _$playerWritingForHash() => r'6645e9f166eee819952f7d01dd772d2fee1bd949';

/// See also [playerWritingFor].
@ProviderFor(playerWritingFor)
final playerWritingForProvider = AutoDisposeProvider<PublicPlayer?>.internal(
  playerWritingFor,
  name: r'playerWritingForProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playerWritingForHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayerWritingForRef = AutoDisposeProviderRef<PublicPlayer?>;
String _$hasSubmittedTextHash() => r'5c1707236b7cd5ffbfcdc07f19ceb936e072c8aa';

/// See also [hasSubmittedText].
@ProviderFor(hasSubmittedText)
final hasSubmittedTextProvider = AutoDisposeProvider<bool?>.internal(
  hasSubmittedText,
  name: r'hasSubmittedTextProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasSubmittedTextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HasSubmittedTextRef = AutoDisposeProviderRef<bool?>;
String _$isFinalRoundHash() => r'8ae16f5f27ab533402061181dd1d6136874e1bc5';

/// See also [isFinalRound].
@ProviderFor(isFinalRound)
final isFinalRoundProvider = AutoDisposeProvider<bool>.internal(
  isFinalRound,
  name: r'isFinalRoundProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isFinalRoundHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsFinalRoundRef = AutoDisposeProviderRef<bool>;
String _$presentPlayersHash() => r'a08abd7dc23134d340867a59653302f84ec9c97c';

/// See also [presentPlayers].
@ProviderFor(presentPlayers)
final presentPlayersProvider = AutoDisposeProvider<List<PublicPlayer>>.internal(
  presentPlayers,
  name: r'presentPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$presentPlayersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PresentPlayersRef = AutoDisposeProviderRef<List<PublicPlayer>>;
String _$readyRosterHash() => r'7ace1269f9ad01a74c75be962d1c278aefb97a0d';

/// See also [readyRoster].
@ProviderFor(readyRoster)
final readyRosterProvider = AutoDisposeProvider<List<String>>.internal(
  readyRoster,
  name: r'readyRosterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$readyRosterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReadyRosterRef = AutoDisposeProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
