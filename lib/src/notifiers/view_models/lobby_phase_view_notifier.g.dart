// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby_phase_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lobbyPhaseViewNotifierHash() =>
    r'1726870250784394865ed1e8437f1467ac50f9b4';

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

abstract class _$LobbyPhaseViewNotifier
    extends BuildlessStreamNotifier<LobbyPhaseViewModel> {
  late final String roomId;
  late final String userId;

  Stream<LobbyPhaseViewModel> build(
    String roomId,
    String userId,
  );
}

/// See also [LobbyPhaseViewNotifier].
@ProviderFor(LobbyPhaseViewNotifier)
const lobbyPhaseViewNotifierProvider = LobbyPhaseViewNotifierFamily();

/// See also [LobbyPhaseViewNotifier].
class LobbyPhaseViewNotifierFamily
    extends Family<AsyncValue<LobbyPhaseViewModel>> {
  /// See also [LobbyPhaseViewNotifier].
  const LobbyPhaseViewNotifierFamily();

  /// See also [LobbyPhaseViewNotifier].
  LobbyPhaseViewNotifierProvider call(
    String roomId,
    String userId,
  ) {
    return LobbyPhaseViewNotifierProvider(
      roomId,
      userId,
    );
  }

  @override
  LobbyPhaseViewNotifierProvider getProviderOverride(
    covariant LobbyPhaseViewNotifierProvider provider,
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
  String? get name => r'lobbyPhaseViewNotifierProvider';
}

/// See also [LobbyPhaseViewNotifier].
class LobbyPhaseViewNotifierProvider extends StreamNotifierProviderImpl<
    LobbyPhaseViewNotifier, LobbyPhaseViewModel> {
  /// See also [LobbyPhaseViewNotifier].
  LobbyPhaseViewNotifierProvider(
    String roomId,
    String userId,
  ) : this._internal(
          () => LobbyPhaseViewNotifier()
            ..roomId = roomId
            ..userId = userId,
          from: lobbyPhaseViewNotifierProvider,
          name: r'lobbyPhaseViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lobbyPhaseViewNotifierHash,
          dependencies: LobbyPhaseViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              LobbyPhaseViewNotifierFamily._allTransitiveDependencies,
          roomId: roomId,
          userId: userId,
        );

  LobbyPhaseViewNotifierProvider._internal(
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
  Stream<LobbyPhaseViewModel> runNotifierBuild(
    covariant LobbyPhaseViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
      userId,
    );
  }

  @override
  Override overrideWith(LobbyPhaseViewNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: LobbyPhaseViewNotifierProvider._internal(
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
  StreamNotifierProviderElement<LobbyPhaseViewNotifier, LobbyPhaseViewModel>
      createElement() {
    return _LobbyPhaseViewNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LobbyPhaseViewNotifierProvider &&
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

mixin LobbyPhaseViewNotifierRef
    on StreamNotifierProviderRef<LobbyPhaseViewModel> {
  /// The parameter `roomId` of this provider.
  String get roomId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _LobbyPhaseViewNotifierProviderElement
    extends StreamNotifierProviderElement<LobbyPhaseViewNotifier,
        LobbyPhaseViewModel> with LobbyPhaseViewNotifierRef {
  _LobbyPhaseViewNotifierProviderElement(super.provider);

  @override
  String get roomId => (origin as LobbyPhaseViewNotifierProvider).roomId;
  @override
  String get userId => (origin as LobbyPhaseViewNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
