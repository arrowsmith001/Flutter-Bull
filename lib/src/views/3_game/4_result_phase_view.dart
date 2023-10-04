import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/rounded_border.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/result_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/view_models/3_game/4_result_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../view_models/6_results_phase/player_result_summary.dart';

// TODO: Make results look pretty :)))))))))))))

class ResultView extends ConsumerStatefulWidget {
  const ResultView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultViewViewState();
}

class _ResultViewViewState extends ConsumerState<ResultView>
    with RoomID, UserID {
  @override
  Widget build(BuildContext context) {
    final vmProvider = resultViewNotifierProvider(roomId, userId);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(body: vmAsync.whenDefault((ResultViewModel vm) {
      return SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: 24),
            child: AutoSizeText(
              'RESULTS',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 200),
              maxLines: 1,
            ),
          ),
          ListView.builder(
              itemCount: vm.playerResultSummaries.length,
              itemBuilder: (context, i) {
                final prs = vm.playerResultSummaries[i];
                final PlayerWithAvatar player = vm.playerMap[prs.playerId]!;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: PlayerResultSummaryView(prs, player, i + 1),
                );
              },
              shrinkWrap: true)
        ]),
      );
    }));
  }
}

class PlayerResultSummaryView extends StatefulWidget {
  const PlayerResultSummaryView(this.prs, this.player, this.podiumPosition,
      {super.key});

  final PlayerResultSummary prs;
  final PlayerWithAvatar player;
  final int podiumPosition;

  @override
  State<PlayerResultSummaryView> createState() =>
      _PlayerResultSummaryViewState();
}

class _PlayerResultSummaryViewState extends State<PlayerResultSummaryView> {
  late final PlayerResultSummary prs = widget.prs;
  late final PlayerWithAvatar player = widget.player;
  late final int podiumPosition = widget.podiumPosition;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      background: _getPodiumBackground(podiumPosition),
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.width / 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.width / 4,
                    child: UtterBullPlayerAvatar(null, player.avatarData)),
                AutoSizeText(player.player.name!,
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 1),
                Text(
                  prs.roundScore.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: const Color.fromARGB(255, 255, 190, 13)),
                )
              ],
            ),
          ),
        ),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: widget.prs.items
              .map((summaryItem) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PlayerResultSummaryItemView(summaryItem),
                    ),
                  ))
              .toList(),
        )
      ]),
    );
  }

  Widget? _getPodiumBackground(int podiumPosition) {
    return Container(color: Colors.green); // TODO: Replace with podium color
    if (podiumPosition > 3) return null;
    if (podiumPosition == 3)
      return ShimmeringBackground(color: Color.fromARGB(255, 209, 101, 0));
    if (podiumPosition == 2)
      return ShimmeringBackground(color: Color.fromARGB(255, 211, 211, 211));
    if (podiumPosition == 1)
      return ShimmeringBackground(color: Color.fromARGB(255, 255, 199, 14));
    else
      return null;
  }
}

class ShimmeringBackground extends StatelessWidget {
  const ShimmeringBackground({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Shimmer(
          gradient: LinearGradient(
              colors: [Colors.white, color ?? Colors.white, Colors.white]),
          child: Container(),
        ))
      ],
    );
  }
}

class PlayerResultSummaryItemView extends StatefulWidget {
  const PlayerResultSummaryItemView(this.summaryItem, {super.key});
  final PlayerResultSummaryItem summaryItem;
  @override
  State<PlayerResultSummaryItemView> createState() =>
      _PlayerResultSummaryItemViewState();
}

class _PlayerResultSummaryItemViewState
    extends State<PlayerResultSummaryItemView> {
  PlayerResultSummaryItem get summaryItem => widget.summaryItem;

  @override
  Widget build(BuildContext context) {
    return RoundedBorder(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            title: Text(summaryItem.message), leading: summaryItem.icon),
      ),
    );
  }
}
