import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/view_models/game_round_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/view_models/3_game/2_game_round_view_model.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_player_avatar.dart';
import 'package:flutter_riverpod/src/consumer.dart';

class ReaderView extends ConsumerStatefulWidget {
  const ReaderView({super.key});

  @override
  ConsumerState<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends ConsumerState<ReaderView>
    with RoomID, WhoseTurnID, UserID {
  @override
  Widget build(BuildContext context) {
    final vmProvider =
        gameRoundViewNotifierProvider(userId, roomId, whoseTurnId);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(body: Center(child: vmAsync.whenDefault((vm) {
      final playerWhoseTurn =
          vm.players.firstWhere((p) => p.player.id == whoseTurnId);
      return Hero(tag: 'avatar', child: UtterBullPlayerAvatar(playerWhoseTurn.avatarData));
    })));
  }
}
