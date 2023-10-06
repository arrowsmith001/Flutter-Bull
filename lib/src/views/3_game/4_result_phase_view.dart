import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/custom/widgets/rounded_border.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/result_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/3_game/4_result_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
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
            child: UglyOutlinedText(
              'RESULTS',
              outlineColor: Colors.grey,
            ),
          ),
          ListView.builder(
              itemCount: vm.playerResultSummaries.length,
              itemBuilder: (context, i) {
                final prs = vm.playerResultSummaries[i];
                final PublicPlayer player = vm.playerMap[prs.playerId]!;

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
  final PublicPlayer player;
  final int podiumPosition;

  @override
  State<PlayerResultSummaryView> createState() =>
      _PlayerResultSummaryViewState();
}

class _PlayerResultSummaryViewState extends State<PlayerResultSummaryView> {
  late final PlayerResultSummary prs = widget.prs;
  late final PublicPlayer player = widget.player;
  late final int podiumPosition = widget.podiumPosition;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: RoundedBorder(
            radius: 24.0,
            background: _getPodiumBackground(podiumPosition),
            child: Column(children: 
            [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.width / 4,
                          child: UtterBullPlayerAvatar(null, player.avatarData)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4.0,0,4,0),
                          child: AutoSizeText(player.player.name!,
                          textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge,
                              maxLines: 1),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0,4,0),
                          child: SizedBox(
                            width: 50,
                            child: UglyOutlinedText(
                              prs.roundScore.toString(),
                              // style: Theme.of(context)
                              //     .textTheme
                              //     .headlineLarge!
                              //     .copyWith(color: const Color.fromARGB(255, 255, 190, 13) )
                                  
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),

        
        Flexible(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: widget.prs.items
                .map((summaryItem) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: PlayerResultSummaryItemView(summaryItem),
                ))
                .toList(),
          ),
        )
      ],
    );
  }

  Widget? _getPodiumBackground(int podiumPosition) {
    if (podiumPosition > 3) return null;
    switch (podiumPosition) {
      case 3:
        return ShimmeringBackground(color: UtterBullGlobal.bronzeColor);
      case 2:
        return ShimmeringBackground(color: UtterBullGlobal.silverColor);
      case 1:
        return ShimmeringBackground(color: UtterBullGlobal.goldColor);
    }
    return null;
  }
}

class ShimmeringBackground extends StatelessWidget {
  const ShimmeringBackground({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 3),
      
        child: Container(color: Colors.white.withAlpha(100),),
       highlightColor: Colors.white,
         baseColor: color ?? Colors.white,);
   
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
            title: RichText(text: TextSpan(children: summaryItem.message, style: Theme.of(context).textTheme.headlineSmall)), leading: summaryItem.icon),
      ),
    );
  }
}
