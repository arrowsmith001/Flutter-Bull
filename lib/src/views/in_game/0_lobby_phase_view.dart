import 'package:flutter/material.dart';
import 'package:flutter_bull/src/providers/app_services.dart';
import 'package:flutter_bull/src/providers/app_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LobbyPhaseView extends ConsumerStatefulWidget {
  const LobbyPhaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LobbyViewState();
}

class _LobbyViewState extends ConsumerState<LobbyPhaseView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('hi'),
    );

    // TODO: Scope variables

    final room = ref.watch(getCurrentGameRoomProvider);
    final player = ref.watch(getCurrentPlayerProvider);

    return Column(
      children: [
        Text(room.toJson().toString()),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children:
                room.playerIds.map((e) => ListTile(title: Text(e))).toList(),
          ),
        ),
        TextButton(
          child: Text("leave room"),
          onPressed: () {
            ref
                .read(utterBullServerProvider)
                .removeFromRoom(player.id!, room.id!);
          },
        )
      ],
    );
  }
}
