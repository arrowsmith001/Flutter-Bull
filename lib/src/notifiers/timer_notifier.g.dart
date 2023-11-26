// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerNotifierHash() => r'0aa5bb9fbe5be4f453231f5889f9d5c8b5428ad5';

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

abstract class _$TimerNotifier extends BuildlessStreamNotifier<TimerState> {
  late final int? utcEnd;

  Stream<TimerState> build(
    int? utcEnd,
  );
}

/// See also [TimerNotifier].
@ProviderFor(TimerNotifier)
const timerNotifierProvider = TimerNotifierFamily();

/// See also [TimerNotifier].
class TimerNotifierFamily extends Family<AsyncValue<TimerState>> {
  /// See also [TimerNotifier].
  const TimerNotifierFamily();

  /// See also [TimerNotifier].
  TimerNotifierProvider call(
    int? utcEnd,
  ) {
    return TimerNotifierProvider(
      utcEnd,
    );
  }

  @override
  TimerNotifierProvider getProviderOverride(
    covariant TimerNotifierProvider provider,
  ) {
    return call(
      provider.utcEnd,
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
  String? get name => r'timerNotifierProvider';
}

/// See also [TimerNotifier].
class TimerNotifierProvider
    extends StreamNotifierProviderImpl<TimerNotifier, TimerState> {
  /// See also [TimerNotifier].
  TimerNotifierProvider(
    int? utcEnd,
  ) : this._internal(
          () => TimerNotifier()..utcEnd = utcEnd,
          from: timerNotifierProvider,
          name: r'timerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$timerNotifierHash,
          dependencies: TimerNotifierFamily._dependencies,
          allTransitiveDependencies:
              TimerNotifierFamily._allTransitiveDependencies,
          utcEnd: utcEnd,
        );

  TimerNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.utcEnd,
  }) : super.internal();

  final int? utcEnd;

  @override
  Stream<TimerState> runNotifierBuild(
    covariant TimerNotifier notifier,
  ) {
    return notifier.build(
      utcEnd,
    );
  }

  @override
  Override overrideWith(TimerNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TimerNotifierProvider._internal(
        () => create()..utcEnd = utcEnd,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        utcEnd: utcEnd,
      ),
    );
  }

  @override
  StreamNotifierProviderElement<TimerNotifier, TimerState> createElement() {
    return _TimerNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TimerNotifierProvider && other.utcEnd == utcEnd;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, utcEnd.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TimerNotifierRef on StreamNotifierProviderRef<TimerState> {
  /// The parameter `utcEnd` of this provider.
  int? get utcEnd;
}

class _TimerNotifierProviderElement
    extends StreamNotifierProviderElement<TimerNotifier, TimerState>
    with TimerNotifierRef {
  _TimerNotifierProviderElement(super.provider);

  @override
  int? get utcEnd => (origin as TimerNotifierProvider).utcEnd;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
