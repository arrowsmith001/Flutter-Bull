// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getGameHash() => r'86bce9e47959eda86a7f3d06505661a61bf24577';

/// See also [getGame].
@ProviderFor(getGame)
final getGameProvider = Provider<GameRoom?>.internal(
  getGame,
  name: r'getGameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getGameHash,
  dependencies: <ProviderOrFamily>[getCurrentGameRoomIdProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getCurrentGameRoomIdProvider,
    ...?getCurrentGameRoomIdProvider.allTransitiveDependencies
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
String _$getGameCodeHash() => r'db2db522a23605ceb057447de0fe4eda5b8fa727';

/// See also [getGameCode].
@ProviderFor(getGameCode)
final getGameCodeProvider = Provider<String?>.internal(
  getGameCode,
  name: r'getGameCodeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getGameCodeHash,
  dependencies: <ProviderOrFamily>[getGameProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
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
String _$getSubphaseHash() => r'29807cbdb635cf3899fe1812fc88751c582a3988';

/// See also [getSubphase].
@ProviderFor(getSubphase)
final getSubphaseProvider = Provider<int?>.internal(
  getSubphase,
  name: r'getSubphaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getSubphaseHash,
  dependencies: <ProviderOrFamily>[getGameProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  },
);

typedef GetSubphaseRef = ProviderRef<int?>;
String _$getLeaderIdHash() => r'1c89f03e7fc887b1f06155b84c1517d1dc7eddb5';

/// See also [getLeaderId].
@ProviderFor(getLeaderId)
final getLeaderIdProvider = Provider<String?>.internal(
  getLeaderId,
  name: r'getLeaderIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getLeaderIdHash,
  dependencies: <ProviderOrFamily>[getGameProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  },
);

typedef GetLeaderIdRef = ProviderRef<String?>;
String _$getPseudoShuffledIdsHash() =>
    r'42036bb2582b5d6d49c9f79515cd4612b56b693b';

/// See also [getPseudoShuffledIds].
@ProviderFor(getPseudoShuffledIds)
final getPseudoShuffledIdsProvider = Provider<List<String>>.internal(
  getPseudoShuffledIds,
  name: r'getPseudoShuffledIdsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPseudoShuffledIdsHash,
  dependencies: <ProviderOrFamily>[getGameProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  },
);

typedef GetPseudoShuffledIdsRef = ProviderRef<List<String>>;
String _$getIsUserLeaderHash() => r'40097c703492a252931a2d59ba696b31d46a46ef';

/// See also [getIsUserLeader].
@ProviderFor(getIsUserLeader)
final getIsUserLeaderProvider = Provider<bool?>.internal(
  getIsUserLeader,
  name: r'getIsUserLeaderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getIsUserLeaderHash,
  dependencies: <ProviderOrFamily>[
    isPlayerLeaderProvider,
    getSignedInPlayerIdProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    isPlayerLeaderProvider,
    ...?isPlayerLeaderProvider.allTransitiveDependencies,
    getSignedInPlayerIdProvider,
    ...?getSignedInPlayerIdProvider.allTransitiveDependencies
  },
);

typedef GetIsUserLeaderRef = ProviderRef<bool?>;
String _$getIsUserReadyHash() => r'0257c2a3d4ced8a9cd3561061c5419c2a4fbef08';

/// See also [getIsUserReady].
@ProviderFor(getIsUserReady)
final getIsUserReadyProvider = Provider<bool>.internal(
  getIsUserReady,
  name: r'getIsUserReadyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getIsUserReadyHash,
  dependencies: <ProviderOrFamily>[
    getGameProvider,
    getSignedInPlayerIdProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies,
    getSignedInPlayerIdProvider,
    ...?getSignedInPlayerIdProvider.allTransitiveDependencies
  },
);

typedef GetIsUserReadyRef = ProviderRef<bool>;
String _$getPlayerStateHash() => r'04182490c9a15b90038543bea158c8faaffdc7ff';

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

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    getGameProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  };

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
    r'a91814a7393a8026a451ec542268c03e57acb2cf';

/// See also [getNumberOfPlayers].
@ProviderFor(getNumberOfPlayers)
final getNumberOfPlayersProvider = Provider<int>.internal(
  getNumberOfPlayers,
  name: r'getNumberOfPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getNumberOfPlayersHash,
  dependencies: <ProviderOrFamily>[getGameProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  },
);

typedef GetNumberOfPlayersRef = ProviderRef<int>;
String _$getHasEnoughPlayersHash() =>
    r'912055926f76fa38775f392d665b6501f35c5ac7';

/// See also [getHasEnoughPlayers].
@ProviderFor(getHasEnoughPlayers)
final getHasEnoughPlayersProvider = Provider<bool>.internal(
  getHasEnoughPlayers,
  name: r'getHasEnoughPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getHasEnoughPlayersHash,
  dependencies: <ProviderOrFamily>[getNumberOfPlayersProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getNumberOfPlayersProvider,
    ...?getNumberOfPlayersProvider.allTransitiveDependencies
  },
);

typedef GetHasEnoughPlayersRef = ProviderRef<bool>;
String _$lobbyListInitialDataHash() =>
    r'eaecefc649fcf7193cc434c157cbaf18a3f824de';

/// See also [lobbyListInitialData].
@ProviderFor(lobbyListInitialData)
final lobbyListInitialDataProvider = Provider<List<LobbyPlayer>>.internal(
  lobbyListInitialData,
  name: r'lobbyListInitialDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lobbyListInitialDataHash,
  dependencies: <ProviderOrFamily>{
    getGameProvider,
    getPlayersProvider,
    isPlayerLeaderProvider,
    isPlayerReadyProvider
  },
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies,
    getPlayersProvider,
    ...?getPlayersProvider.allTransitiveDependencies,
    isPlayerLeaderProvider,
    ...?isPlayerLeaderProvider.allTransitiveDependencies,
    isPlayerReadyProvider,
    ...?isPlayerReadyProvider.allTransitiveDependencies
  },
);

typedef LobbyListInitialDataRef = ProviderRef<List<LobbyPlayer>>;
String _$userHash() => r'2a57e71b5362f9a4ed1c3c8904e8dbea0741e73b';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeProvider<PublicPlayer?>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: <ProviderOrFamily>[
    getSignedInPlayerIdProvider,
    getPlayersProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getSignedInPlayerIdProvider,
    ...?getSignedInPlayerIdProvider.allTransitiveDependencies,
    getPlayersProvider,
    ...?getPlayersProvider.allTransitiveDependencies
  },
);

typedef UserRef = AutoDisposeProviderRef<PublicPlayer?>;
String _$canStartGameHash() => r'5cb8cd33f307eb2a1fc4c83a959eddd466eb4037';

/// See also [canStartGame].
@ProviderFor(canStartGame)
final canStartGameProvider = Provider<bool>.internal(
  canStartGame,
  name: r'canStartGameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$canStartGameHash,
  dependencies: <ProviderOrFamily>[
    getGameProvider,
    isPlayerReadyProvider,
    isPlayerLeaderProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies,
    isPlayerReadyProvider,
    ...?isPlayerReadyProvider.allTransitiveDependencies,
    isPlayerLeaderProvider,
    ...?isPlayerLeaderProvider.allTransitiveDependencies
  },
);

typedef CanStartGameRef = ProviderRef<bool>;
String _$isMidGameHash() => r'8aa214e529609ed474441cb77f3562653bf8aa61';

/// See also [isMidGame].
@ProviderFor(isMidGame)
final isMidGameProvider = Provider<bool?>.internal(
  isMidGame,
  name: r'isMidGameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isMidGameHash,
  dependencies: <ProviderOrFamily>[getPhaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getPhaseProvider,
    ...?getPhaseProvider.allTransitiveDependencies
  },
);

typedef IsMidGameRef = ProviderRef<bool?>;
String _$isPlayerReadyHash() => r'522d646f2e99c7f73af4f37e23ac945fcf2d4967';

/// See also [isPlayerReady].
@ProviderFor(isPlayerReady)
const isPlayerReadyProvider = IsPlayerReadyFamily();

/// See also [isPlayerReady].
class IsPlayerReadyFamily extends Family<bool?> {
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

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    getGameProvider,
    getPlayerStateProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies,
    getPlayerStateProvider,
    ...?getPlayerStateProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isPlayerReadyProvider';
}

/// See also [isPlayerReady].
class IsPlayerReadyProvider extends Provider<bool?> {
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
    bool? Function(IsPlayerReadyRef provider) create,
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
  ProviderElement<bool?> createElement() {
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

mixin IsPlayerReadyRef on ProviderRef<bool?> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _IsPlayerReadyProviderElement extends ProviderElement<bool?>
    with IsPlayerReadyRef {
  _IsPlayerReadyProviderElement(super.provider);

  @override
  String? get id => (origin as IsPlayerReadyProvider).id;
}

String _$isPlayerLeaderHash() => r'9d6bdb23977a5cf9870bb1ffabd734f6e863ac95';

/// See also [isPlayerLeader].
@ProviderFor(isPlayerLeader)
const isPlayerLeaderProvider = IsPlayerLeaderFamily();

/// See also [isPlayerLeader].
class IsPlayerLeaderFamily extends Family<bool?> {
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

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    getLeaderIdProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    getLeaderIdProvider,
    ...?getLeaderIdProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isPlayerLeaderProvider';
}

/// See also [isPlayerLeader].
class IsPlayerLeaderProvider extends Provider<bool?> {
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
    bool? Function(IsPlayerLeaderRef provider) create,
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
  ProviderElement<bool?> createElement() {
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

mixin IsPlayerLeaderRef on ProviderRef<bool?> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _IsPlayerLeaderProviderElement extends ProviderElement<bool?>
    with IsPlayerLeaderRef {
  _IsPlayerLeaderProviderElement(super.provider);

  @override
  String? get id => (origin as IsPlayerLeaderProvider).id;
}

String _$numberOfPlayersSubmittedTextHash() =>
    r'2b9e20cf726877d4675372ff46247aa1a58c4aaa';

/// See also [numberOfPlayersSubmittedText].
@ProviderFor(numberOfPlayersSubmittedText)
final numberOfPlayersSubmittedTextProvider = Provider<int?>.internal(
  numberOfPlayersSubmittedText,
  name: r'numberOfPlayersSubmittedTextProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$numberOfPlayersSubmittedTextHash,
  dependencies: <ProviderOrFamily>[getGameProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  },
);

typedef NumberOfPlayersSubmittedTextRef = ProviderRef<int?>;
String _$isPlayerTruthOrLieHash() =>
    r'9e5724b58500a18b905e583c3bdb987ce0088f72';

/// See also [isPlayerTruthOrLie].
@ProviderFor(isPlayerTruthOrLie)
const isPlayerTruthOrLieProvider = IsPlayerTruthOrLieFamily();

/// See also [isPlayerTruthOrLie].
class IsPlayerTruthOrLieFamily extends Family<bool?> {
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

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    getGameProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isPlayerTruthOrLieProvider';
}

/// See also [isPlayerTruthOrLie].
class IsPlayerTruthOrLieProvider extends Provider<bool?> {
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
    bool? Function(IsPlayerTruthOrLieRef provider) create,
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
  ProviderElement<bool?> createElement() {
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

mixin IsPlayerTruthOrLieRef on ProviderRef<bool?> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _IsPlayerTruthOrLieProviderElement extends ProviderElement<bool?>
    with IsPlayerTruthOrLieRef {
  _IsPlayerTruthOrLieProviderElement(super.provider);

  @override
  String? get id => (origin as IsPlayerTruthOrLieProvider).id;
}

String _$userWritingPromptHash() => r'5177d5f66c84e9a62eebf403b291ae17b9439bfe';

/// See also [userWritingPrompt].
@ProviderFor(userWritingPrompt)
final userWritingPromptProvider = Provider<WritingPrompt>.internal(
  userWritingPrompt,
  name: r'userWritingPromptProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userWritingPromptHash,
  dependencies: <ProviderOrFamily>[
    getGameProvider,
    getSignedInPlayerIdProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies,
    getSignedInPlayerIdProvider,
    ...?getSignedInPlayerIdProvider.allTransitiveDependencies
  },
);

typedef UserWritingPromptRef = ProviderRef<WritingPrompt>;
String _$playerWritingForHash() => r'd3372b1f6283a76c5a28c1ae91c1896b749d0407';

/// See also [playerWritingFor].
@ProviderFor(playerWritingFor)
final playerWritingForProvider = AutoDisposeProvider<PublicPlayer?>.internal(
  playerWritingFor,
  name: r'playerWritingForProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playerWritingForHash,
  dependencies: <ProviderOrFamily>[
    getPlayersProvider,
    getSignedInPlayerIdProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getPlayersProvider,
    ...?getPlayersProvider.allTransitiveDependencies,
    getSignedInPlayerIdProvider,
    ...?getSignedInPlayerIdProvider.allTransitiveDependencies
  },
);

typedef PlayerWritingForRef = AutoDisposeProviderRef<PublicPlayer?>;
String _$hasSubmittedTextHash() => r'3dc8b34221dd9f8acab0371bcc989fa5cd764823';

/// See also [hasSubmittedText].
@ProviderFor(hasSubmittedText)
final hasSubmittedTextProvider = Provider<bool?>.internal(
  hasSubmittedText,
  name: r'hasSubmittedTextProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasSubmittedTextHash,
  dependencies: <ProviderOrFamily>[
    getGameProvider,
    getSignedInPlayerIdProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies,
    getSignedInPlayerIdProvider,
    ...?getSignedInPlayerIdProvider.allTransitiveDependencies
  },
);

typedef HasSubmittedTextRef = ProviderRef<bool?>;
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
String _$presentPlayersHash() => r'f72baef2d097a0ad58172011d31e7b5d1f1159d3';

/// See also [presentPlayers].
@ProviderFor(presentPlayers)
final presentPlayersProvider = AutoDisposeProvider<List<PublicPlayer>>.internal(
  presentPlayers,
  name: r'presentPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$presentPlayersHash,
  dependencies: <ProviderOrFamily>[getPlayersProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getPlayersProvider,
    ...?getPlayersProvider.allTransitiveDependencies
  },
);

typedef PresentPlayersRef = AutoDisposeProviderRef<List<PublicPlayer>>;
String _$readyRosterHash() => r'48000ee42ee82a43faefc935c4df61159a69aadc';

/// See also [readyRoster].
@ProviderFor(readyRoster)
final readyRosterProvider = Provider<List<String>>.internal(
  readyRoster,
  name: r'readyRosterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$readyRosterHash,
  dependencies: <ProviderOrFamily>[getGameProvider, isPlayerReadyProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    getGameProvider,
    ...?getGameProvider.allTransitiveDependencies,
    isPlayerReadyProvider,
    ...?isPlayerReadyProvider.allTransitiveDependencies
  },
);

typedef ReadyRosterRef = ProviderRef<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
