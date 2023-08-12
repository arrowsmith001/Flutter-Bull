import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/game_notifier.dart';
import 'package:flutter_bull/src/notifiers/player_notifier.dart';
import 'package:flutter_bull/src/notifiers/view_models/reveal_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/views/4_game_round/3_voting_phase_view.dart';
import 'package:flutter_bull/src/widgets/utter_bull_player_avatar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevealView extends ConsumerStatefulWidget {
  const RevealView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RevealViewState();
}

class _RevealViewState extends ConsumerState<RevealView>
    with WhoseTurnID, UserID, RoomID {
  @override
  Widget build(BuildContext context) {
    
    final viewModelProvider =
        revealViewNotifierProvider(roomId, userId, whoseTurnId);
 
    final vmAsync = ref.watch(viewModelProvider);

    return Scaffold(body: vmAsync.whenDefault((vm) {
      return Column(children: [
        _buildPlayerStatementPreamble(
            vm.playerWhoseTurn, vm.playerWhoseTurnStatement),
        Expanded(
            child: Column(
          children: [
            _buildVoteList(true, vm.playersVotedTruth),
            _buildVoteList(false, vm.playersVotedLie),
          ],
        ))
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
      children: 
      [
        Flexible(child: UtterBullPlayerAvatar(playerWhoseTurn.avatarData)),
        Flexible(child: Text(playerWhoseTurnStatement))
      ],
    );
  }

  Widget _buildVoteList(bool truthOrLie, List<PlayerWithAvatar> playersVoted) {
    return Column(children: [
      Text(truthOrLie ? 'TRUE' : 'BULL'),
      ListView(
        children: playersVoted
            .map((p) => UtterBullPlayerAvatar(p.avatarData))
            .toList(),
      )
    ]);
  }
}
