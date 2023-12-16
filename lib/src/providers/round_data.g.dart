// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_data.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getWhoseTurnIdHash() => r'561ecb8daeb0d3d52e620340fcb0e3940694eca9';

/// See also [getWhoseTurnId].
@ProviderFor(getWhoseTurnId)
final getWhoseTurnIdProvider = Provider<String?>.internal(
  getWhoseTurnId,
  name: r'getWhoseTurnIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getWhoseTurnIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetWhoseTurnIdRef = ProviderRef<String?>;
String _$getPlayerWhoseTurnHash() =>
    r'716053c5fc7d65ded79a95a25bc3accee3cf3af1';

/// See also [getPlayerWhoseTurn].
@ProviderFor(getPlayerWhoseTurn)
final getPlayerWhoseTurnProvider = AutoDisposeProvider<PublicPlayer?>.internal(
  getPlayerWhoseTurn,
  name: r'getPlayerWhoseTurnProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPlayerWhoseTurnHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetPlayerWhoseTurnRef = AutoDisposeProviderRef<PublicPlayer?>;
String _$getPlayerWhoseTurnStatementHash() =>
    r'9aed24b26c97c32d620f33b7947ae16851e3e10d';

/// See also [getPlayerWhoseTurnStatement].
@ProviderFor(getPlayerWhoseTurnStatement)
final getPlayerWhoseTurnStatementProvider = Provider<String?>.internal(
  getPlayerWhoseTurnStatement,
  name: r'getPlayerWhoseTurnStatementProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPlayerWhoseTurnStatementHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetPlayerWhoseTurnStatementRef = ProviderRef<String?>;
String _$getIsUserReadingHash() => r'f7daecf14b0762c224f89e6498c61d06a7cf1414';

/// See also [getIsUserReading].
@ProviderFor(getIsUserReading)
final getIsUserReadingProvider = Provider<bool>.internal(
  getIsUserReading,
  name: r'getIsUserReadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getIsUserReadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetIsUserReadingRef = ProviderRef<bool>;
String _$getHasPlayerVotedHash() => r'e0c65ba9e9256f36e383a1e0c060d77654a01468';

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

/// See also [getHasPlayerVoted].
@ProviderFor(getHasPlayerVoted)
const getHasPlayerVotedProvider = GetHasPlayerVotedFamily();

/// See also [getHasPlayerVoted].
class GetHasPlayerVotedFamily extends Family<bool?> {
  /// See also [getHasPlayerVoted].
  const GetHasPlayerVotedFamily();

  /// See also [getHasPlayerVoted].
  GetHasPlayerVotedProvider call(
    String? id,
  ) {
    return GetHasPlayerVotedProvider(
      id,
    );
  }

  @override
  GetHasPlayerVotedProvider getProviderOverride(
    covariant GetHasPlayerVotedProvider provider,
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
  String? get name => r'getHasPlayerVotedProvider';
}

/// See also [getHasPlayerVoted].
class GetHasPlayerVotedProvider extends Provider<bool?> {
  /// See also [getHasPlayerVoted].
  GetHasPlayerVotedProvider(
    String? id,
  ) : this._internal(
          (ref) => getHasPlayerVoted(
            ref as GetHasPlayerVotedRef,
            id,
          ),
          from: getHasPlayerVotedProvider,
          name: r'getHasPlayerVotedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getHasPlayerVotedHash,
          dependencies: GetHasPlayerVotedFamily._dependencies,
          allTransitiveDependencies:
              GetHasPlayerVotedFamily._allTransitiveDependencies,
          id: id,
        );

  GetHasPlayerVotedProvider._internal(
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
    bool? Function(GetHasPlayerVotedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetHasPlayerVotedProvider._internal(
        (ref) => create(ref as GetHasPlayerVotedRef),
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
    return _GetHasPlayerVotedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetHasPlayerVotedProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetHasPlayerVotedRef on ProviderRef<bool?> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _GetHasPlayerVotedProviderElement extends ProviderElement<bool?>
    with GetHasPlayerVotedRef {
  _GetHasPlayerVotedProviderElement(super.provider);

  @override
  String? get id => (origin as GetHasPlayerVotedProvider).id;
}

String _$getHasUserVotedHash() => r'c5600a0a2531f2904e43f3575f1924c2931c779c';

/// See also [getHasUserVoted].
@ProviderFor(getHasUserVoted)
final getHasUserVotedProvider = Provider<bool?>.internal(
  getHasUserVoted,
  name: r'getHasUserVotedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getHasUserVotedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetHasUserVotedRef = ProviderRef<bool?>;
String _$getNumberOfPlayersVotedHash() =>
    r'a3eef99f9e55de88517c590c276e39cfe3e42051';

/// See also [getNumberOfPlayersVoted].
@ProviderFor(getNumberOfPlayersVoted)
final getNumberOfPlayersVotedProvider = Provider<int?>.internal(
  getNumberOfPlayersVoted,
  name: r'getNumberOfPlayersVotedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getNumberOfPlayersVotedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetNumberOfPlayersVotedRef = ProviderRef<int?>;
String _$getNumberOfPlayersVotingHash() =>
    r'88629878085a7d040f738b0712c5f300343e1dae';

/// See also [getNumberOfPlayersVoting].
@ProviderFor(getNumberOfPlayersVoting)
final getNumberOfPlayersVotingProvider = Provider<int?>.internal(
  getNumberOfPlayersVoting,
  name: r'getNumberOfPlayersVotingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getNumberOfPlayersVotingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetNumberOfPlayersVotingRef = ProviderRef<int?>;
String _$getEligibleVoterIdsHash() =>
    r'858e6e41a15132cc27cb9b2334dd7ffed4eb5ebf';

/// See also [getEligibleVoterIds].
@ProviderFor(getEligibleVoterIds)
final getEligibleVoterIdsProvider = Provider<List<String>>.internal(
  getEligibleVoterIds,
  name: r'getEligibleVoterIdsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getEligibleVoterIdsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetEligibleVoterIdsRef = ProviderRef<List<String>>;
String _$getVotingPlayersHash() => r'0574b98d456607ee0a2c61ee1cf05836fd287111';

/// See also [getVotingPlayers].
@ProviderFor(getVotingPlayers)
final getVotingPlayersProvider = Provider<Map<String, VotingPlayer>>.internal(
  getVotingPlayers,
  name: r'getVotingPlayersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getVotingPlayersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetVotingPlayersRef = ProviderRef<Map<String, VotingPlayer>>;
String _$getRoundStatusHash() => r'4c7ccd2b99e51441423ddb67a97e5262932ffb19';

/// See also [getRoundStatus].
@ProviderFor(getRoundStatus)
final getRoundStatusProvider = Provider<RoundStatus?>.internal(
  getRoundStatus,
  name: r'getRoundStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getRoundStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetRoundStatusRef = ProviderRef<RoundStatus?>;
String _$getVoteOptionsStateHash() =>
    r'0466926c54775482cedb281a2cbd60e6740e7c16';

/// See also [getVoteOptionsState].
@ProviderFor(getVoteOptionsState)
final getVoteOptionsStateProvider = Provider<VoteOptionsState?>.internal(
  getVoteOptionsState,
  name: r'getVoteOptionsStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getVoteOptionsStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetVoteOptionsStateRef = ProviderRef<VoteOptionsState?>;
String _$getRoundTimeRemainingSecondsHash() =>
    r'86037d12ca1195328a1247c213e7ac11ebb252ba';

/// See also [getRoundTimeRemainingSeconds].
@ProviderFor(getRoundTimeRemainingSeconds)
final getRoundTimeRemainingSecondsProvider = Provider<int?>.internal(
  getRoundTimeRemainingSeconds,
  name: r'getRoundTimeRemainingSecondsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getRoundTimeRemainingSecondsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetRoundTimeRemainingSecondsRef = ProviderRef<int?>;
String _$getRoundTimeElapsedSecondsHash() =>
    r'98a38b87f808d384e63d7fa2201ca685fd868268';

/// See also [getRoundTimeElapsedSeconds].
@ProviderFor(getRoundTimeElapsedSeconds)
final getRoundTimeElapsedSecondsProvider = Provider<int?>.internal(
  getRoundTimeElapsedSeconds,
  name: r'getRoundTimeElapsedSecondsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getRoundTimeElapsedSecondsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetRoundTimeElapsedSecondsRef = ProviderRef<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
