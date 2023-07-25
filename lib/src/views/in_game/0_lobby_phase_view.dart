import 'package:flutter/material.dart';
import 'package:flutter_bull/src/custom/extensions/riverpod_extensions.dart';
import 'package:flutter_bull/src/notifiers/room_notifier.dart';
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
    // TODO: Scope variables

    final roomId = ref.watch(getCurrentGameRoomProvider);
    final roomAsync = ref.watch(roomNotifierProvider(roomId));

    final playerId = ref.watch(getSignedInPlayerIdProvider);

    return Scaffold(
      body: roomAsync.whenDefault((room) {
        return Column(
          children: [
            Text(room.toJson().toString()),
            Text(room.roomCode.toString(), style: Theme.of(context).textTheme.headlineLarge,),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: room?.playerIds
                        .map((e) => ListTile(title: Text(e)))
                        .toList() ??
                    [],
              ),
            ),
            TextButton(
              child: Text("leave room"),
              onPressed: () {
                ref
                    .read(utterBullServerProvider)
                    .removeFromRoom(playerId, room.id!);
              },
            )
          ],
        );
      }),
    );
  }
}
