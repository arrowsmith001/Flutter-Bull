import 'dart:async';
import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/enums/game_phases.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_round_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dart:math' as Math;

class ShufflePlayersAnimationView extends ConsumerStatefulWidget {
  const ShufflePlayersAnimationView({super.key});

  @override
  ConsumerState<ShufflePlayersAnimationView> createState() =>
      _ShufflePlayersAnimationViewState();
}

class _ShufflePlayersAnimationViewState
    extends ConsumerState<ShufflePlayersAnimationView>
    with RoomID, WhoseTurnID, UserID {
  late Duration duration = UtterBullGlobal.playerSelectionAnimationDuration;

  @override
  void initState() {
    super.initState();
    _timer = Timer(duration, () {});
  }

  late Timer _timer;

  void _onTimerEnd() {
    Navigator.of(context).pushReplacementNamed(RoundPhase.reader.name);
  }

  @override
  Widget build(BuildContext context) {
    final vmProvider =
        gameRoundViewNotifierProvider(userId!, roomId, whoseTurnId);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(body: Center(child: vmAsync.whenDefault((vm) {
      final PlayerSelector playerSelector = LinearScrollingPlayerSelector(
          width: MediaQuery.of(context).size.width,
          maxDuration: duration,
          shuffledPlayerIds: vm.playersLeftToPlayIds,
          playerAvatars: vm.players,
          whoseTurn: whoseTurnId,
          onAnimationEnd: () => _onTimerEnd());

      return playerSelector;
    })));
  }
}

abstract class PlayerSelector extends StatefulWidget {
  final Duration maxDuration;
  final Map<String, PublicPlayer> playerAvatars;
  final List<String> shuffledPlayerIds;
  final String whoseTurn;
  final double width;

  const PlayerSelector({
    super.key,
    required this.shuffledPlayerIds,
    required this.playerAvatars,
    required this.maxDuration,
    required this.whoseTurn,
    required this.width,
  });
}

class LinearScrollingPlayerSelector extends PlayerSelector {
  const LinearScrollingPlayerSelector(
      {super.key,
      required super.shuffledPlayerIds,
      required super.playerAvatars,
      required super.maxDuration,
      required super.whoseTurn,
      required VoidCallback onAnimationEnd,
      required super.width});

  @override
  State<LinearScrollingPlayerSelector> createState() =>
      _LinearScrollingPlayerSelectorState();
}

class _LinearScrollingPlayerSelectorState
    extends State<LinearScrollingPlayerSelector>
    with SingleTickerProviderStateMixin {
  final int n = 20;

  double get w => widget.width;

  late AnimationController wrapUpAnimController =
      AnimationController(vsync: this, duration: duration2)
        ..addListener(() {
          setState(() {});
        });
  late Animation<double> wrapUpAnim =
      CurvedAnimation(parent: wrapUpAnimController, curve: Curves.decelerate);

  late double startPosition = itemW / 2;
  late double endPosition = (itemW * n) - itemW * 2.5;

  late Duration duration1 = widget.maxDuration * 0.9;
  late Duration duration2 = widget.maxDuration * 0.1;

  @override
  void initState() {
    super.initState();

    _initializeList();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scroll();
    });
  }

  @override
  void dispose() {
    wrapUpAnimController.dispose();
    super.dispose();
  }

  void _initializeList() {
    final shuffledIds = widget.shuffledPlayerIds;
    final whoseTurn = widget.whoseTurn;

    List<String> idsForward = List.empty(growable: true);

    int i = 0;
    while (i < n) {
      idsForward.add(shuffledIds[i % shuffledIds.length]);
      i++;
    }

    Logger().d(idsForward);
    int j = shuffledIds.length - 1;
    while (idsForward[n - 2] != whoseTurn) {
      idsForward = [shuffledIds[j], ...idsForward.sublist(0, n - 1)];
      Logger().d('new: ' + idsForward.toString());
      j = (j - 1) % shuffledIds.length;
    }

    ids = List.from(idsForward);
  }

  void _onScrollAnimTick() {
    final double pos = _controller.offset;
    final int i = (pos / itemW).ceil();
    setState(() {
      lower = pos - (1.5 * itemW);
      upper = pos + w;

      if (0 <= i && i < n) {
        currentPlayerName = widget.playerAvatars[ids[i]]!.player.name ?? '';
      }
    });
  }

  late final ScrollController _controller =
      ScrollController(initialScrollOffset: startPosition);

  late List<String> ids;

  String currentPlayerName = "";

  late double itemW = w / 2;

  late double lower = 0.0;
  late double upper = w + itemW / 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AutoSizeText(currentPlayerName,
            maxLines: 1, style: Theme.of(context).textTheme.displayLarge),
        Flexible(
          child: SizedBox(
            height: itemW,
            child: ListView.builder(
              clipBehavior: Clip.none,
              controller: _controller,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: ids.length,
              itemBuilder: (context, i) {
                // TODO: Bake this value into item viewmodel
                final double x = (i - 0.5) * itemW;

                if (x < lower || x > upper) {
                  return SizedBox(width: itemW);
                }

                final double dx = (x - _controller.offset) / (w + itemW);

                final avatar = widget.playerAvatars[ids[i]]!;

                final int sign = dx < 0 ? -1 : 1;

                final child = Transform.translate(
                  offset: Offset(dx * w / 5, 0),
                  child: Transform.scale(
                      scale: 1 - dx.abs(),
                      child: UtterBullPlayerAvatar(null, avatar.avatarData)),
                );

                bool isChosen = i == n - 2;

                if (isChosen) {
                  return Hero(tag: 'avatar', child: child);
                } else {
                  return Opacity(
                    opacity: 1 - wrapUpAnimController.value,
                    child: Transform.translate(
                        offset: Offset(
                            0,
                            (MediaQuery.of(context).size.height * 0.1) *
                                wrapUpAnim.value),
                        child: child),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _scroll() async {
    final navigator = Navigator.of(context);

    _controller.addListener(() {
      _onScrollAnimTick();
    });

    await _controller.animateTo(endPosition,
        duration: duration1, curve: Curves.decelerate);

    await wrapUpAnimController.forward(from: 0);

    navigator.pushReplacementNamed(RoundPhase.reader.name);
  }
}

// TODO: Implement
class RotaryPlayerSelector extends PlayerSelector {
  RotaryPlayerSelector(
      {super.key,
      required super.shuffledPlayerIds,
      required super.playerAvatars,
      required super.maxDuration,
      required super.whoseTurn,
      required super.width});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
