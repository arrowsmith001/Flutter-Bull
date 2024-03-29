// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reveals_phase_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$revealsPhaseViewNotifierHash() =>
    r'848e451ca4949b96cba0d02a1e919f1da5966c65';

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

abstract class _$RevealsPhaseViewNotifier
    extends BuildlessStreamNotifier<RevealsPhaseViewModel> {
  late final String roomId;

  Stream<RevealsPhaseViewModel> build(
    String roomId,
  );
}

/// See also [RevealsPhaseViewNotifier].
@ProviderFor(RevealsPhaseViewNotifier)
const revealsPhaseViewNotifierProvider = RevealsPhaseViewNotifierFamily();

/// See also [RevealsPhaseViewNotifier].
class RevealsPhaseViewNotifierFamily
    extends Family<AsyncValue<RevealsPhaseViewModel>> {
  /// See also [RevealsPhaseViewNotifier].
  const RevealsPhaseViewNotifierFamily();

  /// See also [RevealsPhaseViewNotifier].
  RevealsPhaseViewNotifierProvider call(
    String roomId,
  ) {
    return RevealsPhaseViewNotifierProvider(
      roomId,
    );
  }

  @override
  RevealsPhaseViewNotifierProvider getProviderOverride(
    covariant RevealsPhaseViewNotifierProvider provider,
  ) {
    return call(
      provider.roomId,
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
  String? get name => r'revealsPhaseViewNotifierProvider';
}

/// See also [RevealsPhaseViewNotifier].
class RevealsPhaseViewNotifierProvider extends StreamNotifierProviderImpl<
    RevealsPhaseViewNotifier, RevealsPhaseViewModel> {
  /// See also [RevealsPhaseViewNotifier].
  RevealsPhaseViewNotifierProvider(
    String roomId,
  ) : this._internal(
          () => RevealsPhaseViewNotifier()..roomId = roomId,
          from: revealsPhaseViewNotifierProvider,
          name: r'revealsPhaseViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$revealsPhaseViewNotifierHash,
          dependencies: RevealsPhaseViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              RevealsPhaseViewNotifierFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  RevealsPhaseViewNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  Stream<RevealsPhaseViewModel> runNotifierBuild(
    covariant RevealsPhaseViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
    );
  }

  @override
  Override overrideWith(RevealsPhaseViewNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RevealsPhaseViewNotifierProvider._internal(
        () => create()..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  StreamNotifierProviderElement<RevealsPhaseViewNotifier, RevealsPhaseViewModel>
      createElement() {
    return _RevealsPhaseViewNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RevealsPhaseViewNotifierProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RevealsPhaseViewNotifierRef
    on StreamNotifierProviderRef<RevealsPhaseViewModel> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _RevealsPhaseViewNotifierProviderElement
    extends StreamNotifierProviderElement<RevealsPhaseViewNotifier,
        RevealsPhaseViewModel> with RevealsPhaseViewNotifierRef {
  _RevealsPhaseViewNotifierProviderElement(super.provider);

  @override
  String get roomId => (origin as RevealsPhaseViewNotifierProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
