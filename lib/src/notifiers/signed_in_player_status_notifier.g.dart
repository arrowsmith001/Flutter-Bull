// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_in_player_status_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signedInPlayerStatusNotifierHash() =>
    r'7cee6c4c754aa4b9639a198117ddac25d7ecfb53';

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

abstract class _$SignedInPlayerStatusNotifier
    extends BuildlessStreamNotifier<SignedInPlayerStatusNotifierState> {
  late final String userId;

  Stream<SignedInPlayerStatusNotifierState> build(
    String userId,
  );
}

/// See also [SignedInPlayerStatusNotifier].
@ProviderFor(SignedInPlayerStatusNotifier)
const signedInPlayerStatusNotifierProvider =
    SignedInPlayerStatusNotifierFamily();

/// See also [SignedInPlayerStatusNotifier].
class SignedInPlayerStatusNotifierFamily
    extends Family<AsyncValue<SignedInPlayerStatusNotifierState>> {
  /// See also [SignedInPlayerStatusNotifier].
  const SignedInPlayerStatusNotifierFamily();

  /// See also [SignedInPlayerStatusNotifier].
  SignedInPlayerStatusNotifierProvider call(
    String userId,
  ) {
    return SignedInPlayerStatusNotifierProvider(
      userId,
    );
  }

  @override
  SignedInPlayerStatusNotifierProvider getProviderOverride(
    covariant SignedInPlayerStatusNotifierProvider provider,
  ) {
    return call(
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
  String? get name => r'signedInPlayerStatusNotifierProvider';
}

/// See also [SignedInPlayerStatusNotifier].
class SignedInPlayerStatusNotifierProvider extends StreamNotifierProviderImpl<
    SignedInPlayerStatusNotifier, SignedInPlayerStatusNotifierState> {
  /// See also [SignedInPlayerStatusNotifier].
  SignedInPlayerStatusNotifierProvider(
    this.userId,
  ) : super.internal(
          () => SignedInPlayerStatusNotifier()..userId = userId,
          from: signedInPlayerStatusNotifierProvider,
          name: r'signedInPlayerStatusNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$signedInPlayerStatusNotifierHash,
          dependencies: SignedInPlayerStatusNotifierFamily._dependencies,
          allTransitiveDependencies:
              SignedInPlayerStatusNotifierFamily._allTransitiveDependencies,
        );

  final String userId;

  @override
  bool operator ==(Object other) {
    return other is SignedInPlayerStatusNotifierProvider &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Stream<SignedInPlayerStatusNotifierState> runNotifierBuild(
    covariant SignedInPlayerStatusNotifier notifier,
  ) {
    return notifier.build(
      userId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
