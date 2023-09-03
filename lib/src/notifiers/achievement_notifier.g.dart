// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$achievementNotifierHash() =>
    r'f880131359b24a1d8cd50530712a15e69fec86b4';

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

abstract class _$AchievementNotifier
    extends BuildlessAsyncNotifier<AchievementWithIcon> {
  late final String achievementId;

  Future<AchievementWithIcon> build(
    String achievementId,
  );
}

/// See also [AchievementNotifier].
@ProviderFor(AchievementNotifier)
const achievementNotifierProvider = AchievementNotifierFamily();

/// See also [AchievementNotifier].
class AchievementNotifierFamily
    extends Family<AsyncValue<AchievementWithIcon>> {
  /// See also [AchievementNotifier].
  const AchievementNotifierFamily();

  /// See also [AchievementNotifier].
  AchievementNotifierProvider call(
    String achievementId,
  ) {
    return AchievementNotifierProvider(
      achievementId,
    );
  }

  @override
  AchievementNotifierProvider getProviderOverride(
    covariant AchievementNotifierProvider provider,
  ) {
    return call(
      provider.achievementId,
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
  String? get name => r'achievementNotifierProvider';
}

/// See also [AchievementNotifier].
class AchievementNotifierProvider extends AsyncNotifierProviderImpl<
    AchievementNotifier, AchievementWithIcon> {
  /// See also [AchievementNotifier].
  AchievementNotifierProvider(
    this.achievementId,
  ) : super.internal(
          () => AchievementNotifier()..achievementId = achievementId,
          from: achievementNotifierProvider,
          name: r'achievementNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$achievementNotifierHash,
          dependencies: AchievementNotifierFamily._dependencies,
          allTransitiveDependencies:
              AchievementNotifierFamily._allTransitiveDependencies,
        );

  final String achievementId;

  @override
  bool operator ==(Object other) {
    return other is AchievementNotifierProvider &&
        other.achievementId == achievementId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, achievementId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Future<AchievementWithIcon> runNotifierBuild(
    covariant AchievementNotifier notifier,
  ) {
    return notifier.build(
      achievementId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
