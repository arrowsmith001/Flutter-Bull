// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_phase_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$votingPhaseViewNotifierHash() =>
    r'723ad52b6e5b05cbf04f34ff6d488897d81afaa9';

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

abstract class _$VotingPhaseViewNotifier
    extends BuildlessStreamNotifier<VotingPhaseViewModel> {
  late final String roomId;
  late final String userId;
  late final String whoseTurnId;

  Stream<VotingPhaseViewModel> build(
    String roomId,
    String userId,
    String whoseTurnId,
  );
}

/// See also [VotingPhaseViewNotifier].
@ProviderFor(VotingPhaseViewNotifier)
const votingPhaseViewNotifierProvider = VotingPhaseViewNotifierFamily();

/// See also [VotingPhaseViewNotifier].
class VotingPhaseViewNotifierFamily
    extends Family<AsyncValue<VotingPhaseViewModel>> {
  /// See also [VotingPhaseViewNotifier].
  const VotingPhaseViewNotifierFamily();

  /// See also [VotingPhaseViewNotifier].
  VotingPhaseViewNotifierProvider call(
    String roomId,
    String userId,
    String whoseTurnId,
  ) {
    return VotingPhaseViewNotifierProvider(
      roomId,
      userId,
      whoseTurnId,
    );
  }

  @override
  VotingPhaseViewNotifierProvider getProviderOverride(
    covariant VotingPhaseViewNotifierProvider provider,
  ) {
    return call(
      provider.roomId,
      provider.userId,
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
  String? get name => r'votingPhaseViewNotifierProvider';
}

/// See also [VotingPhaseViewNotifier].
class VotingPhaseViewNotifierProvider extends StreamNotifierProviderImpl<
    VotingPhaseViewNotifier, VotingPhaseViewModel> {
  /// See also [VotingPhaseViewNotifier].
  VotingPhaseViewNotifierProvider(
    this.roomId,
    this.userId,
    this.whoseTurnId,
  ) : super.internal(
          () => VotingPhaseViewNotifier()
            ..roomId = roomId
            ..userId = userId
            ..whoseTurnId = whoseTurnId,
          from: votingPhaseViewNotifierProvider,
          name: r'votingPhaseViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$votingPhaseViewNotifierHash,
          dependencies: VotingPhaseViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              VotingPhaseViewNotifierFamily._allTransitiveDependencies,
        );

  final String roomId;
  final String userId;
  final String whoseTurnId;

  @override
  bool operator ==(Object other) {
    return other is VotingPhaseViewNotifierProvider &&
        other.roomId == roomId &&
        other.userId == userId &&
        other.whoseTurnId == whoseTurnId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, whoseTurnId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Stream<VotingPhaseViewModel> runNotifierBuild(
    covariant VotingPhaseViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
      userId,
      whoseTurnId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
