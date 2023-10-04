// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resultViewNotifierHash() =>
    r'd4f543a2e9470c10402b01f5024294ab6b121c5a';

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

abstract class _$ResultViewNotifier
    extends BuildlessStreamNotifier<ResultViewModel> {
  late final String roomId;
  late final String userId;

  Stream<ResultViewModel> build(
    String roomId,
    String userId,
  );
}

/// See also [ResultViewNotifier].
@ProviderFor(ResultViewNotifier)
const resultViewNotifierProvider = ResultViewNotifierFamily();

/// See also [ResultViewNotifier].
class ResultViewNotifierFamily extends Family<AsyncValue<ResultViewModel>> {
  /// See also [ResultViewNotifier].
  const ResultViewNotifierFamily();

  /// See also [ResultViewNotifier].
  ResultViewNotifierProvider call(
    String roomId,
    String userId,
  ) {
    return ResultViewNotifierProvider(
      roomId,
      userId,
    );
  }

  @override
  ResultViewNotifierProvider getProviderOverride(
    covariant ResultViewNotifierProvider provider,
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
  String? get name => r'resultViewNotifierProvider';
}

/// See also [ResultViewNotifier].
class ResultViewNotifierProvider
    extends StreamNotifierProviderImpl<ResultViewNotifier, ResultViewModel> {
  /// See also [ResultViewNotifier].
  ResultViewNotifierProvider(
    String roomId,
    String userId,
  ) : this._internal(
          () => ResultViewNotifier()
            ..roomId = roomId
            ..userId = userId,
          from: resultViewNotifierProvider,
          name: r'resultViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$resultViewNotifierHash,
          dependencies: ResultViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              ResultViewNotifierFamily._allTransitiveDependencies,
          roomId: roomId,
          userId: userId,
        );

  ResultViewNotifierProvider._internal(
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
  Stream<ResultViewModel> runNotifierBuild(
    covariant ResultViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
      userId,
    );
  }

  @override
  Override overrideWith(ResultViewNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ResultViewNotifierProvider._internal(
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
  StreamNotifierProviderElement<ResultViewNotifier, ResultViewModel>
      createElement() {
    return _ResultViewNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResultViewNotifierProvider &&
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

mixin ResultViewNotifierRef on StreamNotifierProviderRef<ResultViewModel> {
  /// The parameter `roomId` of this provider.
  String get roomId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _ResultViewNotifierProviderElement
    extends StreamNotifierProviderElement<ResultViewNotifier, ResultViewModel>
    with ResultViewNotifierRef {
  _ResultViewNotifierProviderElement(super.provider);

  @override
  String get roomId => (origin as ResultViewNotifierProvider).roomId;
  @override
  String get userId => (origin as ResultViewNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
