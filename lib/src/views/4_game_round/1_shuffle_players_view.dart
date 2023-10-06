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
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(milliseconds: animationTimerMs), () {});
  }

  late Timer _timer;
  int animationTimerMs = 2500;

  void _onTimerEnd() {
    Navigator.of(context).pushReplacementNamed(RoundPhase.reader.name);
  }

  @override
  Widget build(BuildContext context) {
    final vmProvider =
        gameRoundViewNotifierProvider(userId, roomId, whoseTurnId);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(body: Center(child: vmAsync.whenDefault((vm) {
      final PlayerSelector playerSelector = LinearScrollingPlayerSelector(
          width: MediaQuery.of(context).size.width,
          maxDuration: Duration(milliseconds: animationTimerMs),
          shuffledPlayerIds: vm.playersLeftToPlayIds,
          playerAvatars: vm.players,
          selectedIndex: vm.whoseTurnIndex,
          onAnimationEnd: () => _onTimerEnd());

      return playerSelector;
    })));
  }
}

abstract class PlayerSelector extends StatefulWidget {
  final Duration maxDuration;
  final Map<String, PublicPlayer> playerAvatars;
  final List<String> shuffledPlayerIds;
  final int selectedIndex;
  final double width;

  const PlayerSelector({
    super.key,
    required this.shuffledPlayerIds,
    required this.playerAvatars,
    required this.maxDuration,
    required this.selectedIndex,
    required this.width,
  });
}

class LinearScrollingPlayerSelector extends PlayerSelector {
  const LinearScrollingPlayerSelector(
      {super.key,
      required super.shuffledPlayerIds,
      required super.playerAvatars,
      required super.maxDuration,
      required super.selectedIndex,
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

  late AnimationController animController;
  late Animation<double> anim;
  late double startPosition = itemW / 2;
  late double endPosition = (itemW * n) - itemW * 2.5;

  @override
  void initState() {
    super.initState();

    _initializeList();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scroll();
    });
  }

  void _initializeList() {
    final shuffledIds = widget.shuffledPlayerIds;
    final whoseTurn = widget.shuffledPlayerIds[widget.selectedIndex];

    List<String> idsForward = List.empty(growable: true);

    int i = 0;
    while (i < n) {
      idsForward.add(shuffledIds[i % shuffledIds.length]);
      i++;
    }

    while (idsForward[n - 2] != whoseTurn) {
      final String removedId = idsForward.removeAt(n - 1);
      idsForward = [removedId, ...idsForward];
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
        currentPlayerName = widget.playerAvatars[ids[i]]!
                .player
                .name ??
            '';
      }
    });
  }

  late final ScrollController _controller =
      ScrollController(initialScrollOffset: startPosition);

  late List<String> ids;

  double sliderVal = 0.0;
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
        maxLines: 1,
            style: Theme.of(context).textTheme.displayLarge),
        Flexible(
          child: SizedBox(
            height: itemW,
            child: ListView.builder(
              //cacheExtent: MediaQuery.of(context).size.width,
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

                // Logger().d('offset:' + _controller.offset.toString());
                // Logger().d('w:' + w.toString());
                //final double scale = ;

                final avatar = widget.playerAvatars[ids[i]]!;

                final int sign = dx < 0 ? -1 : 1;

                final child = Transform.translate(
                  offset: Offset(dx * w / 5, 0),
                  child: Transform.scale(
                      scale: 1 - dx.abs(),
                      child: UtterBullPlayerAvatar(null, avatar.avatarData)),
                );

                if (i == n - 2) {
                  return Hero(tag: 'avatar', child: child);
                }

                return child;
              },
            ),
          ),
        ),
        Slider(
            value: sliderVal,
            onChanged: (v) {
              final double pos = _controller.offset;

              // Calculate index for name
              final int i = (pos / itemW).ceil();

              setState(() {
                lower = pos - (1.5 * itemW);
                upper = pos + w;

                if (0 <= i && i < n) {
                  currentPlayerName = widget.playerAvatars[ids[i]]!
                          .player
                          .name ??
                      '';
                }

                sliderVal = v;
                _controller.jumpTo(v * itemW * 50);
              });
            })
      ],
    );
  }

  Future<void> _scroll() async {
    final navigator = Navigator.of(context);

    _controller.addListener(() {
      _onScrollAnimTick();
    });

    await _controller.animateTo(endPosition,
        duration: widget.maxDuration, curve: Curves.decelerate);

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
      required super.selectedIndex,
      required super.width});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
