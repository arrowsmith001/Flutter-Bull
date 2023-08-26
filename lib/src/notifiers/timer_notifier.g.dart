// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerNotifierHash() => r'f2587e4c288e7f6aa51b26589a6573bd85634196';

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
    this.utcEnd,
  ) : super.internal(
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
        );

  final int? utcEnd;

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

  @override
  Stream<TimerState> runNotifierBuild(
    covariant TimerNotifier notifier,
  ) {
    return notifier.build(
      utcEnd,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
