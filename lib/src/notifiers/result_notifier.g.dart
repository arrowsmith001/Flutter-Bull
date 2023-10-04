// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resultNotifierHash() => r'123faea171f7b941caf476dd37b7c28748f382bd';

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

abstract class _$ResultNotifier
    extends BuildlessStreamNotifier<ResultNotifierState0> {
  late final String? roomId;

  Stream<ResultNotifierState0> build(
    String? roomId,
  );
}

/// See also [ResultNotifier].
@ProviderFor(ResultNotifier)
const resultNotifierProvider = ResultNotifierFamily();

/// See also [ResultNotifier].
class ResultNotifierFamily extends Family<AsyncValue<ResultNotifierState0>> {
  /// See also [ResultNotifier].
  const ResultNotifierFamily();

  /// See also [ResultNotifier].
  ResultNotifierProvider call(
    String? roomId,
  ) {
    return ResultNotifierProvider(
      roomId,
    );
  }

  @override
  ResultNotifierProvider getProviderOverride(
    covariant ResultNotifierProvider provider,
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
  String? get name => r'resultNotifierProvider';
}

/// See also [ResultNotifier].
class ResultNotifierProvider
    extends StreamNotifierProviderImpl<ResultNotifier, ResultNotifierState0> {
  /// See also [ResultNotifier].
  ResultNotifierProvider(
    String? roomId,
  ) : this._internal(
          () => ResultNotifier()..roomId = roomId,
          from: resultNotifierProvider,
          name: r'resultNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$resultNotifierHash,
          dependencies: ResultNotifierFamily._dependencies,
          allTransitiveDependencies:
              ResultNotifierFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  ResultNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String? roomId;

  @override
  Stream<ResultNotifierState0> runNotifierBuild(
    covariant ResultNotifier notifier,
  ) {
    return notifier.build(
      roomId,
    );
  }

  @override
  Override overrideWith(ResultNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ResultNotifierProvider._internal(
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
  StreamNotifierProviderElement<ResultNotifier, ResultNotifierState0>
      createElement() {
    return _ResultNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResultNotifierProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ResultNotifierRef on StreamNotifierProviderRef<ResultNotifierState0> {
  /// The parameter `roomId` of this provider.
  String? get roomId;
}

class _ResultNotifierProviderElement
    extends StreamNotifierProviderElement<ResultNotifier, ResultNotifierState0>
    with ResultNotifierRef {
  _ResultNotifierProviderElement(super.provider);

  @override
  String? get roomId => (origin as ResultNotifierProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
