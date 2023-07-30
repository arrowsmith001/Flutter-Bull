// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomNotifierHash() => r'350969bb022cc8ca91ab2fd65540360b88dac903';

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

abstract class _$RoomNotifier extends BuildlessStreamNotifier<GameRoom> {
  late final String? arg;

  Stream<GameRoom> build(
    String? arg,
  );
}

/// See also [RoomNotifier].
@ProviderFor(RoomNotifier)
const roomNotifierProvider = RoomNotifierFamily();

/// See also [RoomNotifier].
class RoomNotifierFamily extends Family<AsyncValue<GameRoom>> {
  /// See also [RoomNotifier].
  const RoomNotifierFamily();

  /// See also [RoomNotifier].
  RoomNotifierProvider call(
    String? arg,
  ) {
    return RoomNotifierProvider(
      arg,
    );
  }

  @override
  RoomNotifierProvider getProviderOverride(
    covariant RoomNotifierProvider provider,
  ) {
    return call(
      provider.arg,
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
  String? get name => r'roomNotifierProvider';
}

/// See also [RoomNotifier].
class RoomNotifierProvider
    extends StreamNotifierProviderImpl<RoomNotifier, GameRoom> {
  /// See also [RoomNotifier].
  RoomNotifierProvider(
    this.arg,
  ) : super.internal(
          () => RoomNotifier()..arg = arg,
          from: roomNotifierProvider,
          name: r'roomNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$roomNotifierHash,
          dependencies: RoomNotifierFamily._dependencies,
          allTransitiveDependencies:
              RoomNotifierFamily._allTransitiveDependencies,
        );

  final String? arg;

  @override
  bool operator ==(Object other) {
    return other is RoomNotifierProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Stream<GameRoom> runNotifierBuild(
    covariant RoomNotifier notifier,
  ) {
    return notifier.build(
      arg,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
