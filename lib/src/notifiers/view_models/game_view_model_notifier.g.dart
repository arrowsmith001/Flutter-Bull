// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameViewModelNotifierHash() =>
    r'1db98ae955b10625e5f7d2069a4ddafe3810869d';

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

abstract class _$GameViewModelNotifier
    extends BuildlessAutoDisposeAsyncNotifier<GameViewModel> {
  late final String roomId;

  Future<GameViewModel> build(
    String roomId,
  );
}

/// See also [GameViewNotifier].
@ProviderFor(GameViewNotifier)
const gameViewModelNotifierProvider = GameViewModelNotifierFamily();

/// See also [GameViewNotifier].
class GameViewModelNotifierFamily extends Family<AsyncValue<GameViewModel>> {
  /// See also [GameViewNotifier].
  const GameViewModelNotifierFamily();

  /// See also [GameViewNotifier].
  GameViewModelNotifierProvider call(
    String roomId,
  ) {
    return GameViewModelNotifierProvider(
      roomId,
    );
  }

  @override
  GameViewModelNotifierProvider getProviderOverride(
    covariant GameViewModelNotifierProvider provider,
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
  String? get name => r'gameViewModelNotifierProvider';
}

/// See also [GameViewNotifier].
class GameViewModelNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GameViewNotifier,
        GameViewModel> {
  /// See also [GameViewNotifier].
  GameViewModelNotifierProvider(
    this.roomId,
  ) : super.internal(
          () => GameViewNotifier()..roomId = roomId,
          from: gameViewModelNotifierProvider,
          name: r'gameViewModelNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gameViewModelNotifierHash,
          dependencies: GameViewModelNotifierFamily._dependencies,
          allTransitiveDependencies:
              GameViewModelNotifierFamily._allTransitiveDependencies,
        );

  final String roomId;

  @override
  bool operator ==(Object other) {
    return other is GameViewModelNotifierProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Future<GameViewModel> runNotifierBuild(
    covariant GameViewNotifier notifier,
  ) {
    return notifier.build(
      roomId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
