import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/model/game_room.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/reveal_view_notifier.dart';
import 'package:flutter_bull/src/proto/regular_rectangle_packer.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/style/utter_bull_theme.dart';
import 'package:flutter_bull/src/view_models/5_reveals_phase/reveal_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_text_box.dart';
import 'package:logger/logger.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../custom/widgets/conditional_overlay.dart';
import '../../custom/widgets/rounded_border.dart';

class RevealViewController {
  RevealViewController(this.vm);
  RevealViewModel? vm;

  void setViewState(RevealViewState _revealViewState) {
    _state = _revealViewState;
  }

  RevealViewState? _state;

  void onRevealed() {
    _state?.setState(() {
      vm = vm?.copyWith(isRevealed: true);
    });

    _state?.onRevealed();
  }
}

// TODO: Clean up this friggin mess
class RevealView extends ConsumerStatefulWidget {
  const RevealView({this.controller, super.key});

  final RevealViewController? controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RevealViewState();
}

class RevealViewState extends ConsumerState<RevealView>
    with WhoseTurnID, UserID, RoomID, SingleTickerProviderStateMixin {
  late AnimationController animController;
  late Animation anim;

  @override
  void initState() {
    super.initState();
    widget.controller?.setViewState(this);

    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    anim = CurvedAnimation(parent: animController, curve: Curves.elasticInOut);

    animController.addListener(() {
      setState(() {});
    });
  }

  late final vmProvider =
      revealViewNotifierProvider(roomId, userId, whoseTurnId);

  GameNotifier get gameNotifier =>
      ref.read(gameNotifierProvider(roomId).notifier);

  AsyncValue<RevealViewModel> get vmAsync => widget.controller?.vm != null
      ? AsyncData(widget.controller!.vm!)
      : ref.watch(vmProvider);

  void onRevealed() async {
    await animController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    animController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(vmProvider.select((vm) => vm.valueOrNull?.isRevealed ?? false),
        (prev, next) {
      if (next) {
        onRevealed();
      }
    });

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: vmAsync.whenDefault((vm) {
          final int maxNumberInVoteList =
              max(vm.playersVotedTruth.length, vm.playersVotedLie.length);

          final Widget preamble = _buildPlayerStatementPreamble(
              vm.playerWhoseTurn,
              vm.playerWhoseTurnStatement,
              vm.isRevealed,
              vm.isStatementTruth);

          final preReveal =
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
              child: preamble,
            ),
            vm.isRevealed
                ? ListView(
                    shrinkWrap: true,
                    children: vm.achievements
                        .map((e) => ListTile(
                              title: Text(e.title),
                              leading: Image.asset(e.iconPath),
                            ))
                        .toList())
                : Container(),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: RoundedBorder(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Row(
                  children: [
                    Expanded(
                        child: ConditionalOverlay(
                            isActive: vm.isRevealed && !vm.isStatementTruth,
                            child: _buildVoteList(true, vm.playersVotedTruth,
                                maxNumberInVoteList))),
                    Expanded(
                        child: ConditionalOverlay(
                            isActive: vm.isRevealed && vm.isStatementTruth,
                            child: _buildVoteList(false, vm.playersVotedLie,
                                maxNumberInVoteList))),
                  ],
                ),
              )),
            )),
            vm.isMyTurn
                ? _buildRevealerControls(vm.isRevealed)
                : AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      child: AutoSizeText(
                          'Waiting for ${vm.playerWhoseTurn.player.name} to ${vm.isRevealed ? 'continue' : 'reveal'}...',
                          style: Theme.of(context).textTheme.headlineLarge,
                          maxLines: 1),
                    ),
                  )
          ]);

          return Stack(
            alignment: Alignment.center,
            children: [
              preReveal,
              Transform.scale(
                  scale: anim.value,
                  child: AutoSizeText(vm.isStatementTruth ? 'TRUE' : 'BULL',
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: Colors.black)))
            ],
          );
        }));
  }

  void _onRevealPressed() {
    ref.read(gameNotifierProvider(roomId).notifier).reveal(userId);
  }

  void _onRevealNextPressed() {
    ref.read(gameNotifierProvider(roomId).notifier).revealNext(userId);
  }

  Widget _buildPlayerStatementPreamble(PublicPlayer playerWhoseTurn,
      String playerWhoseTurnStatement, bool isRevealed, bool isStatementTruth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: UtterBullPlayerAvatar(
                    playerWhoseTurn.player.name!, playerWhoseTurn.avatarData),
              ),
            ),

            Flexible(
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: RoundedBorder(
                  color: (!isRevealed
                          ? Colors.white
                          : isStatementTruth
                              ? UtterBullGlobal.truthColor
                              : UtterBullGlobal.lieColor)
                      .withOpacity(0.9),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UtterBullTextBox(playerWhoseTurnStatement),
                    ),
                  ),
                ),
              ),
            )

            // Flexible(
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Flexible(child: UtterBullTextBox(playerWhoseTurnStatement)),
            //     ],
            //   ),
            // )

            // Flexible(child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(children: [
            //     Expanded(child: UtterBullTextBox(playerWhoseTurnStatement))
            //   ]),
            // ))
          ],
        )
      ],
    );
  }

  final AutoSizeGroup _voteListTitleAutosizeGroup = AutoSizeGroup();

  double get width => MediaQuery.of(context).size.width;

  Widget _buildVoteList(bool truthOrLie, List<PublicPlayer> playersVoted,
      int maxNumberInVoteList) {
    final themeColor =
        truthOrLie ? UtterBullGlobal.truthColor : UtterBullGlobal.lieColor;
    final bgColor = themeColor.withAlpha(125);

    final avatarList = playersVoted
        .map((p) => Padding(
              padding: EdgeInsets.all(12.0),
              child: UtterBullPlayerAvatar(p.player.name!, p.avatarData),
            ))
        .toList();

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            const Color.fromARGB(255, 255, 255, 255),
            bgColor,
            bgColor
          ])),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: AutoSizeText(truthOrLie ? 'TRUE' : 'BULL',
                  group: _voteListTitleAutosizeGroup,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: themeColor)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: AutoSizeText('${playersVoted.length} votes',
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: themeColor)),
            ),
            Flexible(
              child: Stack(alignment: Alignment.center, children: [
                Positioned(
                    child: LayoutBuilder(builder: (context, constraints) {

                      // Size adjusted against potentially small number of voters
                  final Size sizeAdj = Size(
                      constraints.biggest.width,
                      min(constraints.biggest.height,
                          max(1, maxNumberInVoteList) * (width / 2)));

                  return SizedBox.fromSize(
                    size: sizeAdj,
                    child: RegularRectanglePacker(
                        items: avatarList),
                  );
                }))
              ] // ListView(children: avatarList),
                  ),
            )
          ]),
    );
  }

  Widget _buildRevealerControls(bool isRevealed) {
    if (!isRevealed) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UtterBullButton(
            color: Colors.grey,
            gradient: LinearGradient(
                colors: [UtterBullGlobal.truthColor, UtterBullGlobal.lieColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
            title: 'Reveal',
            onPressed: () => gameNotifier.reveal(userId)),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UtterBullButton(
            title: 'Advance', onPressed: () => gameNotifier.revealNext(userId)),
      );
    }
  }
}
