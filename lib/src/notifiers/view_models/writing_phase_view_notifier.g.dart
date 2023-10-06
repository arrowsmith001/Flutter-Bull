// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writing_phase_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$writingPhaseViewNotifierHash() =>
    r'77e19913ffdc384434e1c238d873e6401013e45a';

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

abstract class _$WritingPhaseViewNotifier
    extends BuildlessStreamNotifier<WritingPhaseViewModel> {
  late final String roomId;
  late final String userId;

  Stream<WritingPhaseViewModel> build(
    String roomId,
    String userId,
  );
}

/// See also [WritingPhaseViewNotifier].
@ProviderFor(WritingPhaseViewNotifier)
const writingPhaseViewNotifierProvider = WritingPhaseViewNotifierFamily();

/// See also [WritingPhaseViewNotifier].
class WritingPhaseViewNotifierFamily
    extends Family<AsyncValue<WritingPhaseViewModel>> {
  /// See also [WritingPhaseViewNotifier].
  const WritingPhaseViewNotifierFamily();

  /// See also [WritingPhaseViewNotifier].
  WritingPhaseViewNotifierProvider call(
    String roomId,
    String userId,
  ) {
    return WritingPhaseViewNotifierProvider(
      roomId,
      userId,
    );
  }

  @override
  WritingPhaseViewNotifierProvider getProviderOverride(
    covariant WritingPhaseViewNotifierProvider provider,
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
  String? get name => r'writingPhaseViewNotifierProvider';
}

/// See also [WritingPhaseViewNotifier].
class WritingPhaseViewNotifierProvider extends StreamNotifierProviderImpl<
    WritingPhaseViewNotifier, WritingPhaseViewModel> {
  /// See also [WritingPhaseViewNotifier].
  WritingPhaseViewNotifierProvider(
    String roomId,
    String userId,
  ) : this._internal(
          () => WritingPhaseViewNotifier()
            ..roomId = roomId
            ..userId = userId,
          from: writingPhaseViewNotifierProvider,
          name: r'writingPhaseViewNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$writingPhaseViewNotifierHash,
          dependencies: WritingPhaseViewNotifierFamily._dependencies,
          allTransitiveDependencies:
              WritingPhaseViewNotifierFamily._allTransitiveDependencies,
          roomId: roomId,
          userId: userId,
        );

  WritingPhaseViewNotifierProvider._internal(
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
  Stream<WritingPhaseViewModel> runNotifierBuild(
    covariant WritingPhaseViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
      userId,
    );
  }

  @override
  Override overrideWith(WritingPhaseViewNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: WritingPhaseViewNotifierProvider._internal(
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
  StreamNotifierProviderElement<WritingPhaseViewNotifier, WritingPhaseViewModel>
      createElement() {
    return _WritingPhaseViewNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WritingPhaseViewNotifierProvider &&
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

mixin WritingPhaseViewNotifierRef
    on StreamNotifierProviderRef<WritingPhaseViewModel> {
  /// The parameter `roomId` of this provider.
  String get roomId;

  /// The parameter `userId` of this provider.
  String get userId;
}

class _WritingPhaseViewNotifierProviderElement
    extends StreamNotifierProviderElement<WritingPhaseViewNotifier,
        WritingPhaseViewModel> with WritingPhaseViewNotifierRef {
  _WritingPhaseViewNotifierProviderElement(super.provider);

  @override
  String get roomId => (origin as WritingPhaseViewNotifierProvider).roomId;
  @override
  String get userId => (origin as WritingPhaseViewNotifierProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
