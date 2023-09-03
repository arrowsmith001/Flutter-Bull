import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/view_models/selecting_player_phase_view_notifier.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_bull/src/widgets/common/utter_bull_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectingPlayerPhaseView extends ConsumerStatefulWidget {
  const SelectingPlayerPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectingPlayerPhaseViewState();
}

class _SelectingPlayerPhaseViewState
    extends ConsumerState<SelectingPlayerPhaseView>
    with RoomID, WhoseTurnID, UserID {
  @override
  Widget build(BuildContext context) {

    final vmProvider =
        selectingPlayerPhaseViewNotifierProvider(roomId, userId, whoseTurnId);
    final vmAsync = ref.watch(vmProvider);

    return Scaffold(
      body: vmAsync.whenDefault((vm) {
        
        return Center(
          child: Column(
            children: [
              Text(vm.roleDescriptionString),
              !vm.isMyTurn
                  ? Container()
                  : PlaceholderButton(
                      title: 'Advance',
                      onPressed: () {
                        ref.read(utterBullServerProvider).startRound(
                            ref.read(getCurrentGameRoomIdProvider),
                            ref.read(getSignedInPlayerIdProvider));
                      },
                    )
            ],
          ),
        );
      }),
    );
  }
}
