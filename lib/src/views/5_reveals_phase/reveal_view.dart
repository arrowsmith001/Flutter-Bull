import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/reveal_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/view_models/5_reveals_phase/reveal_view_model.dart';
import 'package:flutter_bull/src/widgets/utter_bull_player_avatar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevealView extends ConsumerStatefulWidget {
  const RevealView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RevealViewState();
}

class _RevealViewState extends ConsumerState<RevealView>
    with WhoseTurnID, UserID, RoomID {
  late final vmProvider =
      revealViewNotifierProvider(roomId, userId, whoseTurnId);

  GameNotifier get gameNotifier =>
      ref.read(gameNotifierProvider(roomId).notifier);

  AsyncValue<RevealViewModel> get vmAsync => ref.watch(vmProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: vmAsync.whenDefault((vm) {
      return Column(children: [
        _buildPlayerStatementPreamble(
            vm.playerWhoseTurn, vm.playerWhoseTurnStatement),
      
        vm.isRevealed ? Text(vm.isStatementTruth ? "TRUE" : "BULL", style: Theme.of(context).textTheme.displayMedium) : Container(),
        
        Expanded(
            child: Row(
          children: [
            Flexible(child: _buildVoteList(true, vm.playersVotedTruth)),
            Flexible(child: _buildVoteList(false, vm.playersVotedLie)),
          ],
        )),
        vm.isMyTurn
            ? Flexible(child: _buildRevealerControls(vm.isRevealed))
            : Container()
      ]);
    }));
  }

  void onReveal() {
    // ref.read(gameNotifierProvider(roomId).notifier).reveal(userId);
  }

  void onNextReveal() {
    //ref.read(gameNotifierProvider(roomId).notifier).nextReveal(userId);
  }

  Widget _buildPlayerStatementPreamble(
      PlayerWithAvatar playerWhoseTurn, String playerWhoseTurnStatement) {
    return Row(
      children: [
        Flexible(child: UtterBullPlayerAvatar(playerWhoseTurn.avatarData)),
        Flexible(child: Text(playerWhoseTurnStatement))
      ],
    );
  }

  Widget _buildVoteList(bool truthOrLie, List<PlayerWithAvatar> playersVoted) {
    return Column(children: [
      Text(truthOrLie ? 'TRUE' : 'BULL'),
      Flexible(
        child: ListView(
          shrinkWrap: true,
          children: playersVoted
              .map((p) => UtterBullPlayerAvatar(p.avatarData))
              .toList(),
        ),
      )
    ]);
  }

  Widget _buildRevealerControls(bool isRevealed) {
    if (!isRevealed) {
      return ElevatedButton(
          onPressed: () => gameNotifier.reveal(userId), child: Text('Reveal'));
    } else {
      return ElevatedButton(
          onPressed: () => gameNotifier.revealNext(userId), child: Text('Advance'));
    }
  }
}
